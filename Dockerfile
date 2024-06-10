# FROM public.ecr.aws/lambda/python:3.8
# FROM lambci/lambda:build-python3.8 
# COPY app.py .
# CMD ["app.lambda_handler"]


# FROM public.ecr.aws/lambda/python:3.11
 FROM public.ecr.aws/lambda/python:3.9
# FROM public.ecr.aws/lambda/python:latest
# Copy function code
COPY app.py /var/task
# Install the function's dependencies using file requirements.txt
COPY requirements.txt  .
RUN  pip3 install -r requirements.txt --target "/var/runtime"
# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD ["app.lambda_handler"]