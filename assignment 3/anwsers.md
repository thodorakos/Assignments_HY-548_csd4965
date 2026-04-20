# theodoros nikaris csd4965 

## 1)

first we apply the new yaml 

```bash
kubectl apply -f hello-ingress.yaml
```

and confirm:

```text
kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
hello-696f775cdc-sd9dn   1/1     Running   0          113s

kubectl get hpa
NAME        REFERENCE          TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
hello-hpa   Deployment/hello   cpu: 0%/80%   1         8         1          4m59s
```

we run minikube ip : its 192.168.49.2
i set it as a sys var with : set -Ux MINIKUBE_IP 192.168.49.2

and then we want to monitor the autoscaling: 

```bash
kubectl get hpa -w
```

the results:

```text
NAME        REFERENCE          TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
hello-hpa   Deployment/hello   cpu: 0%/80%   1         8         1          13m
hello-hpa   Deployment/hello   cpu: 4%/80%   1         8         1          13m
hello-hpa   Deployment/hello   cpu: 98%/80%   1         8         1          14m
hello-hpa   Deployment/hello   cpu: 98%/80%   1         8         2          14m
hello-hpa   Deployment/hello   cpu: 80%/80%   1         8         2          15m
hello-hpa   Deployment/hello   cpu: 93%/80%   1         8         2          16m
hello-hpa   Deployment/hello   cpu: 93%/80%   1         8         3          16m
hello-hpa   Deployment/hello   cpu: 0%/80%    1         8         3          17m
```

while running to stress test this:

```bash
hey -c 100 -z 3m http://$MINIKUBE_IP/hello
```

results:

```text
Summary:
  Total:        181.3236 secs
  Slowest:      6.1919 secs
  Fastest:      0.0012 secs
  Average:      1.4211 secs
  Requests/sec: 70.0957

  Total data:   10289406 bytes
  Size/request: 809 bytes

Response time histogram:
  0.001 [1]     |
  0.620 [3167]  |■■■■■■■■■■■■■■■■■■■■■■■
  1.239 [972]   |■■■■■■■
  1.858 [5400]  |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  2.477 [2371]  |■■■■■■■■■■■■■■■■■■
  3.097 [479]   |■■■■
  3.716 [56]    |
  4.335 [62]    |
  4.954 [74]    |■
  5.573 [100]   |■
  6.192 [28]    |


Latency distribution:
  10% in 0.2830 secs
  25% in 0.6283 secs
  50% in 1.5269 secs
  75% in 1.8274 secs
  90% in 2.2029 secs
  95% in 2.5948 secs
  99% in 4.9789 secs

Details (average, fastest, slowest):
  DNS+dialup:   0.0000 secs, 0.0012 secs, 6.1919 secs
  DNS-lookup:   0.0000 secs, 0.0000 secs, 0.0000 secs
  req write:    0.0000 secs, 0.0000 secs, 0.0016 secs
  resp wait:    1.1271 secs, 0.0008 secs, 5.2039 secs
  resp read:    0.0001 secs, 0.0000 secs, 0.0017 secs

Status code distribution:
  [200] 12663 responses
  [502] 47 responses
```

the scaling stops at 8 containers , we didnt reach them but if runned the hey command for more times we would.

## 2)

first we create the hello-chart dirs and then the yaml files needed for helm:

```text
Chart.yaml
values.yaml
```

and then the templates:

```text
deployment.yaml
hpa.yaml
ingress.yaml
service.yaml
```

and then to apply:

```bash
helm install goodbye ./hello-chart \
  --set message="Goodbye world!" \
  --set endpoint="/goodbye" \
  --set resources.limits.cpu="250m" \
  --set resources.requests.cpu="250m" \
  --set hpa.maxReplicas=20
```

the output:

```text
NAME: goodbye
LAST DEPLOYED: Mon Apr 20 15:21:11 2026
NAMESPACE: default
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE: None
```

and we confirm by : curl http://$(minikube ip)/goodbye

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Redirecting</title>
</head>
<body>
<pre>Redirecting to <a href="/goodbye/">/goodbye/</a></pre>
</body>
</html>
```

done!!

## 3) 

first we remove the existing ingrees with :

```bash
minikube addons disable ingress
```

we add the ngix ingress:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```

we update:

```bash
helm repo update
```

and then we install the ingress controller:

```bash
helm install my-ingress-nginx ingress-nginx/ingress-nginx
```

then we will apply the same yaml from exercise 1 but we will update so it will use the nginx ingress:

```bash
kubectl apply -f hello-ingress-v2.yaml
```

confirm:

```text
kubectl get pods
NAME                                         READY   STATUS    RESTARTS   AGE
goodbye-5f689f7cfb-8mtww                     1/1     Running   0          31m
hello-696f775cdc-sd9dn                       1/1     Running   0          70m
my-ingress-nginx-controller-8c485c76-jrr9z   1/1     Running   0          4m13s 
```

DONE!!!