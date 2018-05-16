from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime

default_args = { 'start_date': datetime(2018,1,1) }

with DAG('example', default_args=default_args) as dag:
    (
        BashOperator(task_id='print_date', bash_command='echo "Hello, world!"', )
        >>
        BashOperator(task_id='sleep',      bash_command='sleep 5', retries=3,)
    )