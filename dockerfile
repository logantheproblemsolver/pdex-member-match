# syntax=docker/dockerfile:1

FROM python:3.11  # as intermediate

#RUN apk add git openssh
#ARG SSH_PRIVATE_KEY
#RUN mkdir /root/.ssh
#RUN echo "${SSH_PRIVATE_KEY}" >~/.ssh/id_rsa
#RUN chmod 600 ~/.ssh/id_rsa

#RUN touch /root/.ssh/known_hosts \
#RUN ssh-keyscan vs-ssh.visualstudio.com >> /root/.ssh/known_hosts
#RUN git clone git@ssh.dev.azure.com:v3/onyxhealth/SAFHIR/pdex-membermatch

#FROM python:3.11
#COPY --from=intermediate /pdex-membermatch /srv/pdex-membermatch

WORKDIR /code

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

ARG FLASK_APP=membermatch/__init__.py

# ENTRYPOINT ["gunicorn", "main:app"]
ENTRYPOINT ["gunicorn", "membermatch/__init__.py:app"]
