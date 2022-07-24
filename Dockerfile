FROM rocm/tensorflow:latest

LABEL maintainer="Leonardo Neumann <leonardo@neumann.dev.br>" \
    org.opencontainers.image.url="https://github.com/leonardohn/rocm-colab" \
    org.opencontainers.image.source="https://github.com/leonardohn/rocm-colab" \
    org.opencontainers.image.version="0.1.0" \
    org.opencontainers.image.title="rocm-colab" \
    org.opencontainers.image.description="Ready to use Colab runner with AMD ROCm support" \
    org.opencontainers.image.authors="Leonardo Neumann <leonardo@neumann.dev.br>" \
    org.opencontainers.image.licenses="MIT"

RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN pip install jupyter jupyter_http_over_ws matplotlib numpy pandas scipy scikit-learn \
 && jupyter serverextension enable --py jupyter_http_over_ws

ARG COLAB_PORT=8888

ENV COLAB_PORT=${COLAB_PORT}

EXPOSE ${COLAB_PORT}

WORKDIR /content

ENV TF_CPP_MIN_LOG_LEVEL=1

CMD [ "sh", "-c", "jupyter notebook --NotebookApp.allow_origin='https://colab.research.google.com' --allow-root --port ${COLAB_PORT} --NotebookApp.port_retries=0 --ip 0.0.0.0" ]
