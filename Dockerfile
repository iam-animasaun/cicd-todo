FROM python:3

RUN python3 -. venv /opt/venv
ENV PATH="/opt/venv/bin/:$PATH"
RUN pip install django==3.2

COPY . .

RUN python manage.py migrate
EXPOSE 8000
CMD ["python","manage.py","runserver","0.0.0.0:8000"]


