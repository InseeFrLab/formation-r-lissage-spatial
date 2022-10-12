#!/bin/bash

# Clone training repo
REPO_URL=https://github.com/InseeFrLab/formation-r-lissage-spatial
CLONE_DIR=/home/onyxia/work/formation
git clone --depth 1 $REPO_URL $CLONE_DIR
chown -R onyxia:users $CLONE_DIR
cd $CLONE_DIR

# Copy training data
# mkdir data
# mc cp --recursive s3/projet-formation/r-lissage-spatial/ data/

# Launch RStudio in the right project
# echo \
# "
# setHook('rstudio.sessionInit', function(newSession) {
#     if (newSession && identical(getwd(), path.expand('~')))
#     {
#         rstudioapi::openProject('$CLONE_DIR')
#         }
#         }, action = 'append')
#         " >> /home/onyxia/.Rprofile
