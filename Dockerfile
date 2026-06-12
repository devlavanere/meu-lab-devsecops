FROM python:3.9-slim

# Instala dependências do sistema para o syslog
RUN apt-get update && apt-get install -y --no-install-recommends \
    rsyslog \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia o requirements da raiz para o container
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o resto do projeto (incluindo a pasta todo_project)
COPY . .

EXPOSE 5000

# Como o run.py está dentro de todo_project, executamos ele a partir dali
CMD service rsyslog start && python todo_project/run.py