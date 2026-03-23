1.prwta ftiaxnoume to dir mas kai mesa vazoyme to yaml pou tha ftiaxei to pod ngix mas
a)
trexoume:

minikube start 

meta gia na kanoume to pod:
kubectl apply -f nginx-pod.yaml
b)
gia to port fowrard:
kubectl port-forward pod/nginx-pod 8080:80

kai epalitheuoume me:
curl http://localhost:8080

h apanthsh tou:
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

c)

logs:
kubectl logs pod/nginx-pod

output:
 /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/03/23 14:30:13 [notice] 1#1: using the "epoll" event method
2026/03/23 14:30:13 [notice] 1#1: nginx/1.29.5
2026/03/23 14:30:13 [notice] 1#1: built by gcc 15.2.0 (Alpine 15.2.0)
2026/03/23 14:30:13 [notice] 1#1: OS: Linux 5.15.153.1-microsoft-standard-WSL2
2026/03/23 14:30:13 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/03/23 14:30:13 [notice] 1#1: start worker processes
2026/03/23 14:30:13 [notice] 1#1: start worker process 31
2026/03/23 14:30:13 [notice] 1#1: start worker process 32
127.0.0.1 - - [23/Mar/2026:14:44:35 +0000] "GET / HTTP/1.1" 200 615 "-" "curl/8.5.0" "-"

d)

shell session:
kubectl exec -it pod/nginx-pod -- /bin/sh

mesa sto container allazoume to string sto index.html
nano /usr/share/nginx/html/index.html 
exit

epalhstheush:
curl http://localhost:8080

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

e)
download locally:
kubectl cp nginx-pod:/usr/share/nginx/html/index.html ./index.html

nano to index.html

<!DOCTYPE html>
<html>
<h1>New index.html for the second hy548 assignment.</h1>
</html>

to stelnoume pisw:
kubectl cp ./index.html nginx-pod:/usr/share/nginx/html/index.html

epalhtheysh :
curl http://localhost:8080

<!DOCTYPE html>
<html>
<h1>New index.html for the second hy548 assignment.</h1>
</html>

f)
Stop the Pod and remove the manifest
kubectl delete -f nginx-pod.yaml

2.