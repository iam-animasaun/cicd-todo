FROM python:3

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin/:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1
RUN pip install django==3.2

RUN python -c "import django; print(f'Django {django.get_version()} installed')"

COPY . .

RUN python manage.py migrate
EXPOSE 8000
CMD ["python","manage.py","runserver","0.0.0.0:8000"]


