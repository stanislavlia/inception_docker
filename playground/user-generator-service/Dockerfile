FROM tiangolo/uvicorn-gunicorn:python3.10

RUN pip3 install --no-cache-dir --upgrade fastapi faker uvicorn

WORKDIR /

COPY ./main.py /main.py

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7777", "--workers", "1"]