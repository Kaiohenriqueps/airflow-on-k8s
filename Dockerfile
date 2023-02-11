FROM apache/airflow:2.1.0

COPY requirements.txt .

RUN python -m pip install --upgrade pip

RUN pip install -r requirements.txt