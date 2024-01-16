FROM python:3
WORKDIR /app
COPY requirements.txt ./
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
COPY ./patientencode ./patientencode
# CMD [ "python","patientencode/manage.py","migrate"]
# CMD [ "python","patientencode/manage.py","runserver","0.0.0.0:8000"]
