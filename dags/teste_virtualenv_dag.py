from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.python import PythonVirtualenvOperator


def test():
    print("funcionou!")


dag = DAG(
    dag_id="teste_virtualenv_dag",
    start_date=datetime.strptime("2022-10-01 00:00:00", "%Y-%m-%d %H:%M:%S"),
    catchup=False,
    max_active_runs=1,
)

var_1 = PythonVirtualenvOperator(
    retries=1,
    system_site_packages=False,
    requirements=[
        "setuptools==58.0.4",
        "numpy==1.20.3",
        "scipy==1.7.1",
        "joblib==1.1.0",
        "threadpoolctl==2.2.0",
        "scikit-learn==0.24.2",
        "pandas==1.3.4",
        "xgboost==1.3.3",
        "slack_sdk",
    ],
    python_callable=test,
    python_version="3.7",
    task_id="test_python_37",
    priority_weight=0,
    pool="default_pool",
    execution_timeout=timedelta(minutes=60),
    dag=dag,
)

var_2 = PythonVirtualenvOperator(
    retries=1,
    system_site_packages=False,
    requirements=["setuptools==58.0.4"],
    python_callable=test,
    python_version="3.10",
    task_id="test_python_310",
    priority_weight=0,
    pool="default_pool",
    execution_timeout=timedelta(minutes=60),
    dag=dag,
)