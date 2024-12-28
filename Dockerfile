FROM apache/airflow:2.10.3

USER root

# Установка системных зависимостей и очистка кэша в одном слое
RUN apt-get update && apt-get install -y python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Копирование и установка Python пакетов
COPY requirements.txt /requirements.txt

USER airflow

# Установка конкретной версии tqdm и остальных зависимостей
RUN pip install --no-cache-dir tqdm==4.67.1 \
    && pip install --no-cache-dir --only-binary :all: -r /requirements.txt

# Удаление requirements.txt, если он больше не нужен
RUN rm /requirements.txt



