FROM apache/airflow:2.5.1

USER root
RUN apt-get update -yqq \
    && apt-get install -y gcc freetds-dev
COPY requirements.txt .
RUN python -m pip install --upgrade pip
USER airflow
RUN pip install -r requirements.txt