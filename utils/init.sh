#!/bin/bash

# Clone training repo
REPO_URL=https://github.com/InseeFrLab/formation-r-lissage-spatial
CLONE_DIR=/home/rstudio/formation
git clone --depth 1 $REPO_URL $CLONE_DIR
chown -R rstudio:users $CLONE_DIR
cd $CLONE_DIR

# Copy training data
mkdir data
mc cp --recursive s3/projet-formation/r-lissage-spatial/ data/