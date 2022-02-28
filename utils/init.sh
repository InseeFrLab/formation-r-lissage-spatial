#!/bin/bash

# Copy training data
DATA_DIR=/home/rstudio/formation/data
mkdir $DATA_DIR
mc cp s3/projet-formation/r-lissage-spatial/* $DATA_DIR

# Launch RStudio in the right project
echo \
"
setHook('rstudio.sessionInit', function(newSession) {
    if (newSession && identical(getwd(), path.expand('~')))
    {
        rstudioapi::openProject('/home/rstudio/formation')
        }
        }, action = 'append')
        " >> /home/rstudio/.Rprofile
