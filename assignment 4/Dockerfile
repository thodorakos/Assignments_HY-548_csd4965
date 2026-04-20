# Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the controller code
COPY controller.py .

# Install kopf, kubernetes client, pyyaml, and jinja2
RUN pip install --no-cache-dir kopf kubernetes pyyaml jinja2

# Run kopf for all namespaces (-A) and in standalone mode
CMD ["kopf", "run", "--standalone", "-A", "controller.py"]