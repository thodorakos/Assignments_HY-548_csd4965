FROM nginx:latest

# Install GNU wget
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

COPY initialize_site.sh /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.d/initialize_site.sh