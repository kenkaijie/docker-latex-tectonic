# Docker Image for Latex Builder (using tectonic)

Just a simple docker image for building latex documents and outputting a pdf. The image expects at least 1 *.tex file and 1 *.in file. The in file is generally used to substitute any git tag version numbering.

Uses the /usr/src folder as the root of all *.tex and *.in files. Be sure to mount the system using:

'''
docker run --mount src=/usr/src,target=/usr/src,type=bind kennethkaijieng/latex-tectonic:latest /bin/sh -c "tectonic main.tex"
'''

# Note on Caching

The cache only stores the minimal packages needed to compile a tex file. Building the docker with your owm preamble.in will dramatically speed up the process as it will cache the custom packages used.