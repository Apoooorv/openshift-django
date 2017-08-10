FROM fedora:latest

RUN dnf -y install python-pip mod_wsgi python-gunicorn && \
    dnf -y clean all && \
    pip install django && \
    chmod a+rwx /home/ && \
    cd /home/ && \
    django-admin startproject sample && \
    python /home/sample/manage.py migrate
   
COPY urls.py /home/sample/sample/ 

EXPOSE 8080

ENTRYPOINT cd /home/sample/ && gunicorn --bind 0.0.0.0:8080  --pythonpath /home/sample/sample/ wsgi
    

