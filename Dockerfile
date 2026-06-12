FROM python:3.9-slim

# Instala o rsyslog exigido para os logs do sistema (Requisito Obrigatório)
RUN apt-get update && apt-get install -y --no-install-recommends \
    rsyslog \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia e instala as dependências atualizadas
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante dos arquivos do projeto
COPY . .

EXPOSE 5000

# Inicializa o serviço de syslog e executa o app no caminho correto
CMD service rsyslog start && python todo_project/run.py