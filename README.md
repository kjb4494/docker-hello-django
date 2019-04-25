## Docker Image Test Project

#### 메모장
- [*Docker 환경 아키텍처*](https://whatisthenext.tistory.com/124)
![아키텍처](http://i.imgur.com/haqK19z.png)
 
    - 아키텍처 수정사항
        ```
        1. nginx를 호스트에 배치한다.
        2. uWSGI이하를 컨테이너에 배치한다.
        3. 호스트와 컨테이너간 공유 디렉토리를 통해 socket 통신을 한다.
        4. gcr과 cloud builder를 이용해 이미지를 배포한다.
        ```
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
- [*Nginx와 uWSGI간 통신 설정하기*](http://blog.ditullio.fr/2016/07/24/docker-django-uwsgi-nginx-web-app/)
- [*컨테이너간 디렉토리 공유하기*](https://www.digitalocean.com/community/tutorials/how-to-share-data-between-docker-containers)
    ```
    Note: 포트를 이용한 TCP통신보 패킷의 오버헤드가 적은 유닉스 소켓 통신이 더 빠르기 때문에,
    컨테이너간(uWSGI, Nginx) 공유 디렉토리를 생성해 소켓을 공유하는 방법을 사용한다.
    ```
- [*gce를 기반으로 한 배포 자동화 Tip*](https://stackoverflow.com/questions/46349803/is-there-a-way-to-automatically-deploy-to-gce-based-on-a-new-image-being-created)
- Docker 설치하기
    ```
    sudo sh get-docker.sh
    ```