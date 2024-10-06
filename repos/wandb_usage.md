# Using Wandb

**TODO:** Get link to docs.

**Additional Resources**
-- Note these may or may not actually work, it seems to be very poorly maintained…
- Data visualization guide: ([here](https://docs.wandb.ai/guides/data-vis))
- Tables tutorial: ([here](https://wandb.ai/stacey/nlg/reports/Visualize-Text-Data-Predictions--Vmlldzo1NzcwNzY?_gl=1*g9vscn*_ga*NTUyNDM3NDQ0LjE2OTAyMjQ1Mjc.*_ga_JH1SJHJQXJ*MTY5MDIyNDUyNi4xLjEuMTY5MDIyNTEwOC4xNi4wLjA.)) ([quickstart](https://docs.wandb.ai/guides/data-vis/tables-quickstart))
- Artifacts ([here](https://docs.wandb.ai/guides/artifacts)) ([example here](https://colab.research.google.com/github/wandb/examples/blob/master/colabs/wandb-artifacts/Pipeline_Versioning_with_W%26B_Artifacts.ipynb))


## Install and Setup

```shell
# Install the package with rye
rye add wandb

# On a new machine, login
wandb login
```

## Basic Usage
```python
import wandb

# TODO: Get cfg_dict example
wandb.init(
  project='name',
  config=cfg_dict,
)

wandb.log({"data": 100})
```

### Write Locations
```shell
# Right now only 1.4G despite never clearing it, so probably don't
# need to worry about this
/scratch/ddr8143/python_cache/.cache/wandb

# You can clean it with, where the final value is to leave
# anything smaller than 0GB (nothing)
# note that it clears the data but leaves the artifact directories,
# so to handle inode issues you might want to manually clear the
# the cache occasionally
wandb artifact cache cleanup 0GB

# The main logging is done to wandb.run.dir
# you can clean this after wandb.finish() is called but if you remove
# anything before you run will fail.
```

## Logging Examples

### Config Logging
It’s possible to programatically get the history and data from a run in python using the run_id.

```python
import wandb
import omegaconf

# You can do this outside of the run creation:
wandb.config = omegaconf.OmegaConf.to_container(
    cfg, resolve=True, throw_on_missing=True
)

# Or inside of the run creation:
run = wandb.init(
    name=run_name,
    project=cfg.wandb_project,
    config=run_cfg, # here
)
```

### Metric Logging

```python
import wandb
import matplotlib.pyplot as plt

# Create a table to make a custom chart (including composite histograms, here)
my_custom_data = [[x1, y1, z1], [x2, y2, z2]]
wandb.log({"custom_data_table": wandb.Table(data=my_custom_data,
                                columns = ["x", "y", "z"])})

# I think this autoconverts my data to a histogram of the data
wandb.log({"losses": wandb.Histogram(losses)})

# Log the histogram directly (here)
data = [[s] for s in scores]
table = wandb.Table(data=data, columns=["scores"])
wandb.log({'my_histogram': wandb.plot.histogram(table, "scores",
 	  title="Prediction Score Distribution")})

# PR curves (here)
wandb.log({"pr": wandb.plot.pr_curve(ground_truth, predictions)})

# Log a matplotlib or plotlyplot directly (here)
plt.plot([1, 2, 3, 4])
plt.ylabel("some interesting numbers")
wandb.log({"chart": plt})

# Log a table (here)
my_table = wandb.Table(
    columns=["a", "b"], 
    data=[["a1", "b1"], ["a2", "b2"]]
    )
run.log({"Table Name": my_table})
```

### Artifact Logging
```python
import wandb

# Current types: input_data_raw, input_data, dataset, training_data
#                scored_data, model, 

# Input artifacts (hosted locally)
in_artifact = wandb.Artifact(
    f'qmp_proof2chunk_raw__{split_name}', type='input_data_raw',
    description='Dir with chunk_*_*.json of qmp questions with proofs matched to context passages.',
    metadata={
        'script': 'set_cp.scripts.qmp_gold_chunk_match',
        'cfg': OmegaConf.to_container(cfg.gold_chunk_match, resolve=True),
    },
)
in_artifact.add_reference(f'file://{output_dir}')
run.use_artifact(in_artifact) ## IMPORTANT: USE_artifact

# Output artifacts (hosted locally)
out_artifact = wandb.Artifact(
    f'qmp_gt_evidence__{split_name}', type='input_data',
    description='Jsonl file with evidence chunks matching annotated proofs for qmp questions',
    metadata={
        'script': 'set_cp.scripts.qmp_gold_chunk_agg',
        'cfg': OmegaConf.to_container(cfg, resolve=True),
    },
)
out_artifact.add_reference(f'file://{output_file}')
run.log_artifact(out_artifact) ## IMPORTANT: LOG_artifact
```

## Reports

**Report Examples:**
- Entity Linking (with ELQ) v0: [here](https://drive.google.com/file/d/13NRit-L9KqJIEdkuz-iVsyk99zvUHa8m/view?usp=drive_link)
- Qent2sid Graphs v0: [here](https://drive.google.com/file/d/1nVCNigN4mdDpUUiGzLHWnip9DTp3UBX_/view?usp=drive_link)
- Scatter plot by time: [here](https://drive.google.com/file/d/19l6-5G6BgVyPAhav3fNGCPuMvb_ADq57/view?usp=drive_link)
- PR line plot: [here](https://drive.google.com/file/d/1h-dWxi1vVqdRokGPBNqFv2x7NdHyyh1T/view?usp=drive_link)
- Comparative bar plot: [here](https://drive.google.com/file/d/16-ekToKZYEPj8Zu5LjVx60kSYov9K5GF/view?usp=drive_link)

**Visualizations**
- Comparative histograms: (see [GT Annotations](https://wandb.ai/danielle-rothermel/qmp_gt_annotations/reports/GT-Annotations--Vmlldzo1MzAxODA4) report for example)
    - Have to be done quite manually, but possible
- Charts are created with the incredibly flexible Vega/Vegalite language
- Histograms just don’t work, but you can create your own if you spend long enough with Vega
- You have to choose Vega or Vegalite (you can’t mix syntax) but either works.
    - It feels easier to do complex things with Vega but the number of examples is much smaller.
- What I currently have:
    - A layered histogram with vegalite that will take two runs from wandb and log them together.
    - A composite histogram that will take two keys in the same run.
 
**Tables**
- For now the best I can do is stack tables from different runs on top of each other —> must log a metrics table for each run (see GT Annotations report)

