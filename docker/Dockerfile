FROM apache/airflow:2.6.3-python3.10

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential zlib1g-dev libncurses5-dev libgdbm-dev \
    libnss3-dev libssl-dev libsqlite3-dev libreadline-dev \
    libffi-dev libbz2-dev vim gcc musl-dev libc-dev wget \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
  && tar -xf Python-3.7.4.tgz \
  && cd Python-3.7.4 \
  && ./configure --enable-optimizations \
  && make altinstall \
  && python3.7 --version

USER airflow

ADD ./docker/requirements.txt .
ADD ./dags ./dags
ADD ./plugins ./plugins

RUN pip install --upgrade pip \
  && pip install apache-airflow==${AIRFLOW_VERSION} -r requirements.txt