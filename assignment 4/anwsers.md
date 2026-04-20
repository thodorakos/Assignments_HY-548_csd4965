# theodoros nikaris csd4965

1)

a)

first we create the custom fruit crd with the crd.yaml

we apply it with: kubectl apply -f crd.yaml

```text
customresourcedefinition.apiextensions.k8s.io/fruits.hy548.csd.uoc.gr created
```

done!

b)
then we create the apple instace : kubectl apply -f apple-instance.yaml

```text
fruit.hy548.csd.uoc.gr/apple created
```

c)

Return the new instance in YAML format : kubectl get fruit apple -o yaml

```yaml
apiVersion: hy548.csd.uoc.gr/v1
kind: Fruit
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"hy548.csd.uoc.gr/v1","kind":"Fruit","metadata":{"annotations":{},"name":"apple","namespace":"default"},"spec":{"count":3,"grams":980,"origin":"Krousonas"}}
  creationTimestamp: "2026-04-20T13:50:08Z"
  generation: 1
  name: apple
  namespace: default
  resourceVersion: "8649"
  uid: 4895703c-2a7b-4826-a2f5-21680c5b3fd6
spec:
  count: 3
  grams: 980
  origin: Krousonas
```

d)

and finallly, we list all the fruits: kubectl get fruits

```text
NAME    AGE
apple   92s
```

2)

a)

first we download the controller.py and then we create the dockerfile that will run it 

then we build the image : docker build -t teonikaris/hy548-greeting-controller:v1 . 

we log in: docker login

and finally we push the image : docker push teonikaris/hy548-greeting-controller:v1

b)
we apply the given crd yaml : kubectl apply -f greeting-crd.yaml

and we create the asken yaml file greeting_controller and we apply it: kubectl apply -f greeting-controller.yaml

then we create a test greeting to verfiy: kubectl apply -f test-greeting.yaml

```text
> kubectl get deployments
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
greeting-controller           1/1     1            1           16m
my-hello                      2/2     2            2           12s

> kubectl get services
NAME                                    TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
my-hello                                ClusterIP      10.106.135.5     <none>        8080/TCP                     57s
```

3)

a)

we update the controller and we build the dockerfile that will run it

then we build and push the image:

docker build -t teonikaris/k8s-webhook-controller:v1 .

docker push teonikaris/k8s-webhook-controller:v1

b)

we download the cert-manager: kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.yaml


we update the webhooks yaml and then we apply it :kubectl apply -f webhook.yaml

we confirm its running: kubectl get pods -n custom-label-injector

to test : 

we create a test namespcae: kubectl create namespace test

Label the namespace for the webhook: kubectl label namespace test custom-label-injector=enabled

and deploy: kubectl run test-pod --image=alpine -n test -- restart=Never

we verify by:
kubectl get pod test-pod -n test-ns --show-labels
