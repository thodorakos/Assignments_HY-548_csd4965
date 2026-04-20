# base image
FROM python:3.9-slim

WORKDIR /app

# Install deps
RUN pip install --no-cache-dir Flask jsonpatch

# Copy the modified controller script
COPY controller.py .

# Expose the HTTPS port
EXPOSE 8443

# Run the controller
CMD ["python", "controller.py"]