ARG BASE_CONTAINER=jupyter/base-notebook
FROM $BASE_CONTAINER

LABEL version=".1"
LABEL description="Jupyter notebook with support for interactive widgets"
LABEL maintainer="Chakri Cherukuri <chakri.v.cherukuri@gmail.com>"

USER $NB_UID

RUN conda install --quiet --yes \
    'conda-forge::blas=*=openblas' \
    'ipywidgets=7.4*' \
    'pandas=0.24*' \
    'scipy=1.2*' \
    'scikit-learn=0.20*' && \
    conda clean --all -f -y && \
    # ipywidgets nbextension
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    # install bqplot
    pip install bqplot==0.11.5 && \
    jupyter nbextension enable bqplot --py --sys-prefix && \
    # install voila
    conda install -c conda-forge voila && \
    jupyter serverextension enable voila --sys-prefix && \
    rm -rf work

USER $NB_UID
