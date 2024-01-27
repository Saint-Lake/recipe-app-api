FROM python:3.9-alpine3.13
LABEL maintainer="Lake Setser"

# makes sure when you are running python in a docker conatiner that the output of commands are not stored in a buffer
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
#SEE explaination of this run command on line 22 and on
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# LINE 13: Creates a new virtual environment of python
# LINE 14: upgrade pip with the virtual environment we just created
# LINE 15: Install list of required python modules
# LINE 16: Then we remove the tmp directory (keeping the image as light as possible)
# LINE 17 - 21: Linux command to add user inside of linux image. (since using root is always bad idea). We also disable the ability to login to the system with a password
# We also do not create a home directory for the user
# Name user django-user

ENV PATH="/py/bin:$PATH"

USER django-user