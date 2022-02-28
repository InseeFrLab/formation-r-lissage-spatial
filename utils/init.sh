#!/bin/bash

# Clone training repo
REPO_URL=https://github.com/InseeFrLab/formation-r-lissage-spatial
CLONE_DIR=/home/rstudio/formation
git clone --depth 1 $REPO_URL $CLONE_DIR
cp $CLONE_DIR

# Copy training data
DATA_DIR=$CLONE_DIR/data
mkdir $DATA_DIR
mc cp s3/projet-formation/r-lissage-spatial/* $DATA_DIR/

# Launch RStudio in the right project
echo \
"
setHook('rstudio.sessionInit', function(newSession) {
    if (newSession && identical(getwd(), path.expand('~')))
    {
        rstudioapi::openProject('$CLONE_DIR')
        }
        }, action = 'append')
        " >> /home/rstudio/.Rprofile
