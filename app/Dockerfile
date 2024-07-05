FROM python:3.8-slim-buster

WORKDIR /app

ENV FLASK_ENV=production
ENV FLASK_APP=main.py

COPY requirements.txt requirements.txt
RUN apt-get update && \
    apt-get install -y \
    bash \
    build-essential \
    cmake \  
    curl \
    git \
    libmariadb-dev-compat \
    libmariadb-dev && \ 
    pip3 install -r requirements.txt

COPY . .

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0"]