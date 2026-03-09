# Theodoros Nikaris csd4965 Assignment 1

## 1. 

### a) 
cmds:
```bash
docker pull nginx:1.29.5
docker pull nginx:1.29.5-alpine
```

### b)
cmd:
```bash
docker images | grep nginx
```

the output was:
```text
nginx:1.29.5                0236ee02dcbc        237MB         62.9MB
nginx:1.29.5-alpine         1d13701a5f9f       92.5MB           26MB
```

the alpine is smaller!!

### c)
cmd:
```bash
docker run -d -p 8000:80 --name my-nginx nginx:1.29.5
```

cmd to see the calls:
```bash
curl http://localhost:8000
```

anwser:
```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

### d)
```bash
docker ps
```

output:
```text
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS           
                          NAMES
e9da0c9e2dda   nginx:1.29.5   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:8000->80/tcp, [::]:8000->80/tcp   my-nginx
```

it is running , everyhting looks good!

### e)
```bash
docker logs my-nginx
```

the outputted logs:
```text
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf       
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/03/09 14:36:53 [notice] 1#1: using the "epoll" event method
2026/03/09 14:36:53 [notice] 1#1: nginx/1.29.5
2026/03/09 14:36:53 [notice] 1#1: built by gcc 14.2.0 (Debian 14.2.0-19)
2026/03/09 14:36:53 [notice] 1#1: OS: Linux 5.15.153.1-microsoft-standard-WSL2
2026/03/09 14:36:53 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1024:1048576
2026/03/09 14:36:53 [notice] 1#1: start worker processes
2026/03/09 14:36:53 [notice] 1#1: start worker process 29
2026/03/09 14:36:53 [notice] 1#1: start worker process 30
172.17.0.1 - - [09/Mar/2026:14:38:07 +0000] "GET / HTTP/1.1" 200 615 "-" "curl/8.5.0" "-"
```

### f)
```bash
docker stop my-nginx
```

### g)
```bash
docker start my-nginx
```

### h)
```bash
docker stop my-nginx ; docker rm my-nginx
```


## 2. 

(we start the Nginx container again and port fowrand it)

### a)

1. entering shell
```bash
docker exec -it my-nginx bash
```

2. replace the string in the index.html inside the ngix cont.
```bash
sed -i 's/Welcome to nginx!/Welcome to MY nginx!/' /usr/share/nginx/html/index.html
```

3. exiting the conteiners shell
```bash
exit
```

4. 
```bash
curl http://localhost:8000
```

output to confirm the change: 
```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to MY nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to MY nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

it worked!!

### b)

1. copy the file here locally
```bash
docker cp my-nginx:/usr/share/nginx/html/index.html ./index.html
```

2. now that we see the file in this dir , i will nano to it and change the code 

```bash
nano inde.html
```

what i wrote inside it:
```html
<!DOCTYPE html>
<html>
<h1>New index.html for the 548 class.</h1>
</html>
```

3. sending the file back inside
```bash
docker cp ./index.html my-nginx:/usr/share/nginx/html/index.html
```

4. Validate the change
```bash
curl http://localhost:8000
```

output: 
```html
<!DOCTYPE html>
<html>
<h1>New index.html for the 548 class.</h1>
</html>
```

confirmed!!

### c)
```bash
docker stop my-nginx
docker rm my-nginx
docker run -d -p 8000:80 --name my-nginx nginx:1.29.5

curl http://localhost:8000
```
output:
```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

so no , the changes didnt remain thats beacause we deleted the container that had the changes and we downloaded the ngix image again which of course doensnt contain our changes. 

### d)

1. first we stop and rm the prev container
```bash
docker stop my-nginx ; docker rm my-nginx
```

2. create the dir
```bash
mkdir website
```

3. create the file
```bash
echo "<h1>New index.html for the 548 class.</h1>" > website/index.html
```

4.  Start Nginx with a bind mount (-v) linking the local folder(website) to Nginx's web directory
```bash
docker run -d -p 8000:80 --name my-nginx -v "$PWD/website":/usr/share/nginx/html nginx:1.29.5
```

5. confirm results
```bash
curl http://localhost:8000
```

output:
```html
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.29.5</center>
</body>
</html>
```

we succeded!!!

## 3. 

kaname clone to 548 repo kai ekana update to dockerfile ws exeis: 

```dockerfile
FROM python:3.13.2-bookworm

ENV PYTHONUNBUFFERED=1

# Install vim-tiny and 
RUN apt-get update && \
    apt-get install -y vim-tiny && \
    rm -rf /var/lib/apt/lists/* 
    # clean up apt cache to save space

COPY . /app
WORKDIR /app

# Expose the db directory as a volume to persist the database
VOLUME ["/app/db"]

RUN pip install --no-cache-dir -r requirements.txt

# Ensure the start script is executable
RUN chmod +x ./start.sh

CMD ["./start.sh"]
```

### a)
to build command gia to neo conteiner
```bash
docker build -t my-django-app .
```

command gia na kanoume pull to python image kai na sygkrinoume to size
```bash
docker pull python:3.13.2-bookworm
```

kai ystera trexoyme : 
```bash
docker images
```

output:
```text
python:3.13.2-bookworm      4165118ed569       1.47GB          382MB
my-django-app:latest        5a48fe274d48       1.55GB          395MB
```

vlepoyme to neo image oti einai kata (1.55 - 1.47) GB megalytero

### b)
debug mode:
```bash
docker run -d -p 8001:8000 -e DJANGO_DEBUG=1 --name django-debug my-django-app
```

without debug mode:
```bash
docker run -d -p 8002:8000 -e DJANGO_DEBUG=0 --name django-nodebug my-django-app
```

trexoume docker ps na ta doume na trexoun:
```text
CONTAINER ID   IMAGE           COMMAND        CREATED              STATUS              PORTS                                         NAMES
f8cf8fd394ed   my-django-app   "./start.sh"   21 seconds ago       Up 21 seconds       0.0.0.0:8002->8000/tcp, [::]:8002->8000/tcp   django-nodebug
ba6899711bbb   my-django-app   "./start.sh"   About a minute ago   Up About a minute   0.0.0.0:8001->8000/tcp, [::]:8001->8000/tcp   django-debug
```

trexoun swsta , as kanoume epalitheysh trexontas:
```bash
curl http://localhost:8001
```

output:
```text
Hello world! (DEBUG is on)
```

```bash
curl http://localhost:8002
```

output:
```text
Hello world!
```

### c) 

docker log in , gia na kanoume sign in prin pusharoume
```bash
docker tag my-django-app teonikaris/my-django-app:latest
```

kai telos:
```bash
docker push teonikaris/my-django-app:latest
```

4. 

prwta ftiaxame to github workflow dir kai mesa valame ena yaml file poy tha kanei build kai that kanei push 

meta 

