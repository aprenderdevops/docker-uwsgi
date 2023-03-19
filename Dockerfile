# Version de Python (solo mayor y menor)
ARG PYTHON_VERSION=3.11

# Etapa build
FROM python:${PYTHON_VERSION} AS build
LABEL maintainer="Jose Arturo Fernandez <jarfernandez@aprenderdevops.com>"

# Se instala uWSGI y todas las librerias que necesita la aplicacion
COPY WebApp/requirements.txt requirements.txt
RUN pip install uwsgi && pip install -r requirements.txt
 
# Etapa run
FROM python:${PYTHON_VERSION}-slim AS run

# Es necesario volver a incluir en esta etapa esta variable
ARG PYTHON_VERSION

# Puerto HTTP por defecto para uWSGI
ARG UWSGI_HTTP_PORT=8000
ENV UWSGI_HTTP_PORT=$UWSGI_HTTP_PORT

# Aplicacion por defecto para uWSGI
ARG UWSGI_APP=webapp
ENV UWSGI_APP=$UWSGI_APP

# Se instalan dependencias
RUN apt-get update && apt-get install -y libxml2

# Se crea un usuario para arrancar uWSGI
RUN useradd -ms /bin/bash admin
USER admin

# Se copia el contenido de la imagen builder
COPY --from=build /usr/local/lib/python${PYTHON_VERSION}/site-packages /usr/local/lib/python${PYTHON_VERSION}/site-packages
COPY --from=build /usr/local/bin/uwsgi /usr/local/bin/uwsgi

# Se copia el contenido de la aplicacion
COPY WebApp /WebApp

# Se copia el fichero con la configuración de uWSGI
COPY uwsgi.ini uwsgi.ini

# Se establece el directorio de trabajo
WORKDIR /WebApp

# Se crea un volumen con el contenido de la aplicacion
VOLUME /WebApp

# Se inicia uWSGI
ENTRYPOINT ["uwsgi", "--ini", "/uwsgi.ini"]
