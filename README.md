## Docker Image Test Project

#### 메모장
- [*Docker 환경 아키텍처*](https://whatisthenext.tistory.com/124)
![아키텍처](http://i.imgur.com/haqK19z.png)
- 준비 사항
    ```
    1. Nginx
    2. uWSGI
    3. Django
    4. Docker
    5. gcloud
    ```
- [*환경 분리하기*](https://cjh5414.github.io/django-settings-separate/)
- Docker 명령어
    ```
    docker build -t asia.gcr.io/hsgitlab-777/hello-world:1.0 .
    docker push asia.gcr.io/hsgitlab-777/hello-world:1.0
    docker run --name hello-world -it --rm -p 8000:8000 asia.gcr.io/hsgitlab-777/hello-world:1.0 /bin/bash
    ```
- Python 실행 명령어
    ```
    1. 개발 환경
      python3 manage.py migrate --settings=docker_hello_django.settings.development
      python3 manage.py runserver --settings=docker_hello_django.settings.development 0.0.0.0:8000
    2. 프로덕션 환경
      python3 manage.py migrate --settings=docker_hello_django.settings.production
      python3 manage.py runserver --settings=docker_hello_django.settings.production 0.0.0.0:8000
    ```