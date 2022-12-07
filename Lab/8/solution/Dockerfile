# syntax=docker/dockerfile:1
FROM continuumio/anaconda3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /code
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
COPY requirements.txt /code/
RUN conda install --file requirements.txt
COPY environment.yml /code/
RUN conda env create -f environment.yml
RUN echo "source activate my_env" > ~/.bashrc
ENV PATH /opt/conda/envs/env/bin:$PATH
RUN . /opt/conda/etc/profile.d/conda.sh