# Hydra Usage Notes

The current version is 1.3, which works with python 3.6-3.11.

Installation:
```shell
rye add hydra-core==1.3
```

## Usage Example

Top Level Config
```yaml
# conf/qmp_passages.yaml

defaults:
- gold_split: dev
- _self_

trial: 0
dataset_dir: /scratch/ddr8143/multiqa/downloads/data/qampari/
remove_passages_without_answers: True
wandb: True
wandb_project: qmp_gt_annotations
processes: 48
```

Nested Config
```yaml
# conf/gold_split/dev.yaml

name: dev
dataset_filename: dev_data.jsonl
proof_filename: dev_proof_data.pkl
proof_passage_dirname: dev_proof_to_passage
gold_filename: dev_data_gold.jsonl
```

Usage in Python Script
```python
import hydra
from omegaconf import DictConfig, OmegaConf

@hydra.main(version_base=None, config_path="conf", config_name="qmp_passages")
def run(cfg: DictConfig):
		logging.info(">> Input config yaml:")
		logging.info("\n" + str(OmegaConf.to_yaml(cfg)))
	
		config_dict = OmegaConf.to_container(cfg, resolve=True)

if __name__ == "__main__":
		run()
```
