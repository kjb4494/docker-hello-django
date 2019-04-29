FROM gcr.io/google-appengine/python
ENV PYTHONUNBUFFERED 1
RUN groupadd -r uwsgi && \
    useradd -r -g uwsgi uwsgi -p `cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 24`
ADD requirements.txt .
RUN pip3 install --upgrade pip && \
    pip3 install -r requirements.txt && \
    rm -rf requirements.txt && \
    mkdir /src_code
WORKDIR /src_code
ADD docker_hello_django .
RUN python3 manage.py migrate --settings=docker_hello_django.settings.development && \
    mkdir /uwsgi
WORKDIR /uwsgi
ADD uwsgi .
CMD ["uwsgi", "--ini", "uwsgi_development.ini"]
