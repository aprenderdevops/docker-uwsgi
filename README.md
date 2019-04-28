# docker-uwsgi
Aplicación web desarrollada en [Python](https://www.python.org/), en este caso con el framework [Flask](http://flask.pocoo.org/), dentro de un contenedor [Docker](https://www.docker.com/) con el servidor [uWSGI](https://uwsgi-docs.readthedocs.io/en/latest/).

Para construir la imagen, ejecutar el siguiente comando:
```
$ docker build -t aprenderdevops/uwsgi .
```

Para arrancar el contenedor, ejecutar el siguiente comando:
```
$ docker run -d -p 8080:8000 --restart unless-stopped -v $(pwd)/WebApp:/WebApp aprenderdevops/uwsgi
```

Acceder a la aplicación con un navegador a http://localhost:8080

---

Tags: devops, docker, flask, python, uwsgi
