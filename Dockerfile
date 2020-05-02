FROM ubuntu:latest
LABEL MAINTAINER "Nitin Goyal: goyalnitin634@gmail.com"
RUN apt-get update -y
RUN apt-get install -y python3-pip python3-dev build-essential
ADD . /flask-app
WORKDIR /flask-app
RUN pip install -r requirements.txt
ENTRYPOINT [ "python3" ]
CMD ["flask-docker.py"]