# We'll use the ready made Horovod container.
FROM horovod/horovod:0.16.0-tf1.12.0-torch1.0.0-mxnet1.4.0-py3.5

# Setting this as the default working directory
WORKDIR /project_code

# Copy all the stuff from local code folder to container
COPY . .

## Installing all the required Python libraries
RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt

# Manually installing baselines module, because PyPI's version requires MuJoCo.
# MuJoCo is a propreitary physics engine and we do not require it in this project.
RUN mkdir /baselines
RUN cd /baselines
RUN git clone https://github.com/openai/baselines.git
RUN python baselines/setup.py install
RUN cd /project_code

# Don't know why this is needed, but it's mentioned in the README, so...
RUN mkdir sandbox_cachedir

ENTRYPOINT bash