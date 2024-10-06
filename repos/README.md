# Github Repo Quickstart

Quickstart guide to setting up a new repo with rye.  See below for a list of files and guides included in this directory.

**Deep Dives**
- **Rye:** [rye_usage.md](https://github.com/drothermel/dr_setup/blob/repo_setup/repos/rye_usage.md)
- **Hydra:** [hydra_usage.md](https://github.com/drothermel/dr_setup/blob/repo_setup/repos/hydra_usage.md)
- **Wandb:** [wandb_usage.md](https://github.com/drothermel/dr_setup/blob/repo_setup/repos/wandb_usage.md)

**Template Files**

- `.gitignore`
  - Python base from github
  - Vim patterns also from github
  - IPynb patterns from jupyter
- `STARTER_README.md`
  - Link to this guide
  - Basic commands for rye, wandb, hydra + links to deep dives
- `__init__.py`
  - Goes into `src/proj/__init__.py` to enable dummy pytest to work
- `tests/`
  - `__init__.py`
  - Test file with a dummy test as an example for pytest
  - Allows `rye test -v` to work immediately

## Setup Instructions

### Clone Repo, Setup Rye

Clone the repo and setup a new branch for the req files that rye creates:
```shell
# Clone and make new branch
git clone PROJ_URL
cd PROJ; git checkout -b "setup_proj"; cd ..

# Make sure you're outside of the repo dir before continuing
```

Initialize rye and ensure its setup correctly:
```shell
# Init rye, assume readme gets copied in later
rye init --no-readme --name PROJ_NAME REPO_PATH
cd REPO_PATH

# rye sync creates the venv for the project and updates
#  the req files, so sync and then commit them.
rye sync
git add .; git commit -m "init rye"

# Rye manages python versions and everything pip, so choose
#  the version of python you want and pin it.
rye pin 3.12

# Finally, test that its working as expected, expect the
#  second command to print out the path to the rye venv
rye sync
python -c "import sys; print(sys.prefix)"

# And see your new env
rye show
rye list
```

Add core dev and util requirements:
```shell
# Jupyterlab and Vim Bindings
rye add --dev jupyterlab
rye add --dev jupyterlab_vim

# Pytest
rye add --dev pytest

# My Basic Utils
rye add dr_util --git https://github.com/drothermel/dr_util.git

# Finalize
rye sync

# Commit changes to your branch
```


### Add Template Files and Verify Setup

Add template files from the top level dir in the repo:
```shell
# Set an env variable for your path to dr_setup repo
export DRSETUP_PATH = "..."

# Copy in the gitignore
cp $DRSETUP_PATH/repos/.gitignore .

# Copy in the README template
cp $DRSETUP_PATH/repos/STARTER_README.md README.md

# Copy in the __init__.py and tests dir
cp $DRSETUP_PATH/repos/__init__.py ./src/PKG_NAME/__init__.py
cp -r $DRSETUP_PATH/repos/tests .
```

Verify everything is setup correctly:
```shell
# Verify dr_util with interactive python
>>> import dr_util.file_utils as fu
>>> print(fu.fu_help())
  ...expect output...
>>> fu.load_file("./README.md", force_suffix="txt", verbose=True)
  ...expect output...
>>> exit()

# Verify rye and pytest
rye sync
rye fmt
rye lint --fix
rye test -v
```

**Then you're good to go! Don't forget to merge your setup branch.**
