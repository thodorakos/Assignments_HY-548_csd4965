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
a)

minikube start

kubectl apply -f a.yaml

epalhtheush:

kubectl get jobs
NAME       STATUS     COMPLETIONS   DURATION   AGE
wget-job   Complete   1/1           33s        35s

b)

kubectl apply -f b.yaml

kai epalhstheush:
kubectl get pvc,cronjob,pod

NAME                                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
persistentvolumeclaim/site-data-pvc   Bound    pvc-6fcdd902-bcd2-4dae-955e-529355b1b54f   1Gi        RWX            standard       <unset>                 11s

NAME                         SCHEDULE     TIMEZONE   SUSPEND   ACTIVE   LAST SCHEDULE   AGE
cronjob.batch/wget-cronjob   15 2 * * *   <none>     False     0        <none>          11s

NAME                 READY   STATUS      RESTARTS   AGE
pod/nginx-pod        1/1     Running     0          11s
pod/wget-job-llm8z   0/1     Completed   0          5m

h epikoinwnia metaxy twn container ginetai mesw enos  shared Persistent Volume Claim (PVC) , site-data-pvc.

epeidh ola ta container kanoun mount to idio Persistent Volume oti arxeia grapsei to cronjob einai amesa available gia to nginx server gia na diavasei.

c)

kanoume delete prwta to palio pod:
kubectl delete -f b.yaml

kanoume to kainourio:
kubectl apply -f c.yaml

kanoume trigger to cronjob ( giati den mporw na perimenw na paei 2.15:) )
kubectl create job --from=cronjob/wget-cronjob initial-download

confirm:
kubectl get pods -w

NAME                                READY   STATUS      RESTARTS   AGE
initial-download-q4zws              0/1     Completed   0          19s
nginx-deployment-75f7b7df5f-phnc2   0/1     Init:0/1    0          104s
wget-job-llm8z                      0/1     Completed   0          15m
nginx-deployment-75f7b7df5f-phnc2   0/1     PodInitializing   0          105s
nginx-deployment-75f7b7df5f-phnc2   1/1     Running           0          106s

port foward:
kubectl port-forward deployment/nginx-deployment 8080:80

kai telos :
curl http://localhost:8080

(epistrefei olo to html tou uoc.csd.gr)

3)

a)

prwta ftiaxnoume to script `initialize_site.sh` to opoio tha katevazei to site.
nano initialize_site.sh

meta ftiaxnoume to Dockerfile pou kanei install to wget
nano Dockerfile

build kai push to image sto Docker Hub mou:

docker login
docker build -t teonikaris/nginx-wget-site:v3 .
docker push teonikaris/nginx-wget-site:v3


b)

ftiaxnoume to 3b.yaml gia to Deployment kai to Service tou csd.gr


gia na kanoume apply:

kubectl apply -f 3b.yaml

an pods einai etoima:
siozos@LAPTOP-N2K5TIO3 /m/c/U/n/O/Υ/c/H/assignment 2 (main)> kubectl get pods -w
NAME                              READY   STATUS              RESTARTS   AGE
csd-deployment-685bd754c7-5s5fj   0/1     ContainerCreating   0          6s
csd-deployment-685bd754c7-bb9tz   0/1     ContainerCreating   0          6s
csd-deployment-685bd754c7-5s5fj   1/1     Running             0          18s
csd-deployment-685bd754c7-bb9tz   1/1     Running             0          19s

komple!

kai to minikube tunnel gia na doulepsei to external-ip tou LoadBalancer:
minikube tunnel
✅  Tunnel successfully started

epalhtheush:
kubectl get svc csd-service

NAME          TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
csd-service   LoadBalancer   10.109.14.18   127.0.0.1     80:30283/TCP   26m

kai telos:

curl http://127.0.0.1

c)

ftiaxnoume kainourio yaml to uoc-sites.yaml

katevazoume to plugin
minikube addons enable ingress

to kanoume aply : 
kubectl apply -f uoc-sites.yaml

perimenoume kai epalhtheuoume:

kubectl get ingress -w
NAME          CLASS   HOSTS   ADDRESS        PORTS   AGE
uoc-ingress   nginx   *       192.168.49.2   80      111s

kai telikh epalhtheush:
curl "http://192.168.49.2/csd"
curl "http://192.168.49.2/math"
