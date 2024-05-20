FROM lianfei/onnxruntime_cuda12.1.1_cudnn8_ubuntu2204

WORKDIR /app

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/notV3NOM/piper.git

WORKDIR /app/piper/src/python_run

RUN pip3 install -e .
RUN pip3 install -r requirements.txt
RUN pip3 install -r requirements_http.txt

COPY models /app/models

EXPOSE 5000

CMD python3 -m piper.http_server -m /app/models/en_US-lessac-high.onnx --cuda 