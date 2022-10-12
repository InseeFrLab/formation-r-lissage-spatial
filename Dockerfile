FROM inseefrlab/rstudio:ds-r4.2.3-2022.10.07

# Install additional R packages
RUN Rscript -e 'update.packages(ask = "no")' \
    && install2.r --error mapsf btb prettydoc rmdformats \
    && installGithub.r koncina/unilur
