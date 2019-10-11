from alpine:latest

RUN apk add --no-cache python3-dev \
	&& pip3 install --upgrade pip

ADD . /app

WORKDIR /app

#RUN pip3 --no-cache install -r requirements.txt
RUN pip3 install -r requirements.txt


ENTRYPOINT ["python3"]
CMD ["app.py"]

EXPOSE 5000/tcp
