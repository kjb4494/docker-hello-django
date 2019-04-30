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
#### 명령어 모음
- cloudbuild에 사용된 docker 명령어
    ```
    1. 이미지 빌드
        docker build -t asia.gcr.io/hsgitlab-777/hello-world:1.0 .
    2. 이미지 저장소에 등록
        docker push asia.gcr.io/hsgitlab-777/hello-world:1.0
    3. 이미지 저장소에서 내려받기
        docker pull asia.gcr.io/hsgitlab-777/hello-world:1.0
    4. 이미지 기반으로 도커 컨테이너 실행
        docker run --restart always --name hello-world-1.0 -d -v /tmp:/tmp --log-driver=gcplogs asia.gcr.io/hsgitlab-777/hello-world:1.0
    5. 가장 최근에 생성된 컨테이너를 제외한 모든 컨테이너 중지
        docker stop $(docker ps -a -q | awk "NR>1")
    6. 가장 최근에 생성된 컨테이너를 제외한 모든 컨테이너 삭제
        docker rm $(docker ps -a -q | awk "NR>1")
    ```
- Dockerfile에 사용된 django 마이그레이션 명령어
    ```
    1. 개발 환경
      python3 manage.py migrate --settings=docker_hello_django.settings.development
    2. 프로덕션 환경
      python3 manage.py migrate --settings=docker_hello_django.settings.production
    ```
- VM에 Docker 설치하기
    ```
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    sudo systemctl restart docker
    ```
- VM에 Nginx 설치 및 설정하기
    ```
    sudo apt-get install nginx
    sudo rm /etc/nginx/sites-enabled/default
    
    sudo mkdir /nginx
    - 개발 환경
        sudo cp nginx_development/nginx.conf /nginx/
    - 프로덕션 환경
        sudo cp nginx_production/nginx.conf /nginx/
    sudo ln -s /nginx/nginx.conf /etc/nginx/sites-enabled/
    
    sudo mkdir /uwsgi
    sudo cp uwsgi/uwsgi_params /uwsgi/
    
    sudo systemctl restart nginx
    ```
- backup 스크립트 실행하기 (기능만 구현 - 오류제어 구현 x)
    ```
    gcloud compute ssh devops-gce --zone us-central1-c --command "sudo /backup/backup-util.sh 1.0.0"
    매개변수로 이미지 버전 입력
    ```
    
#### GCE Todo List 요약
- 소스코드 및 도커파일 작성하기
- VM에 docker, nginx 설치하기
- VM에 uwsgi_params, nginx.conf 경로 설정하기
- [*google cloud builder*](https://console.cloud.google.com/cloud-build) 설정하기
- cloudbuild.yaml 파일 설정하기

#### 참고 자료
- [*Django 개발 및 프로덕션 환경 분리하기*](https://cjh5414.github.io/django-settings-separate/)
- [*Nginx와 uWSGI간 통신 설정하기*](http://blog.ditullio.fr/2016/07/24/docker-django-uwsgi-nginx-web-app/)
- [*컨테이너간 디렉토리 공유하기*](https://www.digitalocean.com/community/tutorials/how-to-share-data-between-docker-containers)
    ```
    Note: 포트를 이용한 TCP통신보다 패킷의 오버헤드가 적은 유닉스 소켓 통신이 더 빠르기 때문에,
    컨테이너간(uWSGI, Nginx) 공유 디렉토리를 생성해 소켓을 공유하는 방법을 사용한다.
    ```
- [*gce를 기반으로 한 배포 자동화 Tip*](https://stackoverflow.com/questions/46349803/is-there-a-way-to-automatically-deploy-to-gce-based-on-a-new-image-being-created)
- [*gce, cloud-builder, gcr*](https://medium.com/google-cloud/continuous-delivery-in-google-cloud-platform-cloud-build-with-compute-engine-a95bf4fd1821)