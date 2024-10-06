# How to Install and Use Rye

**Resources**
- Official Docs: [rye.astral.sh](https://rye.astral.sh/)
- Intro Video: [youtube](https://rye.astral.sh/guide/)
- Overview of Env Management + Packaging Tools (for context): [by Anna-Lena Popkes](https://alpopkes.com/posts/python/packaging_tools/)

## Using Rye

Refresh State (mainly happens automatically)
```shell
rye sync
```

Inspect the state of the env
```shell
# Show state of env
rye show

# Show deps
rye list
```

Manage dependencies
```shell
# Pin a version of python
rye pin 3.12

# Add a dependency
rye add <pip_package_name> (optional: --dev)

# Remove a dependency
rye remove <pip_package_name> (optional: --dev)
```

Format, lint, test
```shell
# Run black
rye fmt (optional: file path)

# Run lint (and fix easy things)
rye lint --fix

# Run tests
rye test -v
    -s: No capture, disable stdout/stderr capture so it prints out
    -a: Test all packages in workspace
    -- -k 'single_test_name[single_param]': just run one test
```

Running Tools & Scripts
```shell
# Run program
rye run <tool_name>

# Learn to run scripts at bottom of:
# https://rye.astral.sh/guide/basics/#inspecting-the-project

```

## Install Rye

Follow instructions from the [rye project](https://rye.astral.sh/):
```shell
# Install rye
curl -sSf https://rye.astral.sh/get | bash

# Add the following to your .bashrc equivalent (after conda path updates!)
source "$HOME/.rye/env"

# Potentially add shell completion, etc by following this guide:
#  https://rye.astral.sh/guide/installation/#shell-completion
```

### Zsh Specific
```
mkdir $ZSH_CUSTOM/plugins/rye
rye self completion -s zsh > $ZSH_CUSTOM/plugins/rye/_rye
```

## Setup Rye for Repo

Clone the project and initialize rye in a setup branch:
```shell
# Clone and make new branch
git clone PROJ_URL
cd PROJ; git checkout -b "setup_proj"; cd ..

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

Then install main dev and util requirements.
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
