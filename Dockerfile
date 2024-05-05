# pull official base image
FROM python:3.12.2-alpine3.19

# set work directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# install dependencies
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy entrypoint.sh
COPY docker-entrypoint.sh .
RUN sed -i 's/\r$//g' /app/docker-entrypoint.sh

RUN chmod +x /app/docker-entrypoint.sh

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["/bin/sh", "/app/docker-entrypoint.sh"]