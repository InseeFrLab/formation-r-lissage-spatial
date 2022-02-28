FROM inseefrlab/rstudio:r4.1.2-spark3.2.0

# Install additional R packages
RUN Rscript -e 'update.packages(ask = "no")' \
    && install2.r --error mapsf btb \
    && installGithub.r koncina/unilur

# Copy project repo
ADD ./* /home/rstudio/formation