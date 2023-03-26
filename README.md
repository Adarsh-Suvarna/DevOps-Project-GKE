# Deploy an Application to GKE (Google Kubernetes Engine) 
### Tech used:
- Docker
- Kubernetes
- GKE (Google Kubernetes Engine)
- GCR (Google Container Registry)

<p>
<img src="https://raw.githubusercontent.com/tush-tr/tush-tr/master/res/docker.gif" height="36" width="36" >
<img src="https://raw.githubusercontent.com/tush-tr/tush-tr/master/res/kubernetes.svg.png"  height="36" width="36" ><img src="https://raw.githubusercontent.com/tush-tr/tush-tr/master/res/social-icon-google-cloud-1200-630.png" height="36" >
</p>

# Steps
- Create a kubernetes cluster on GKE.
- Setup Connection to created GKE cluster in with your local machine or cloud shell.
    ```sh
    gcloud container clusters get-credentials <CLUSTER_NAME> --zone <ZONE> --project <PROJECT_ID>
    ```
- Create a simple nodejs/express application.
- Write Dockerfile for the application
    ```Dockerfile
    FROM --platform=linux/amd64 node:14
    WORKDIR /usr/app
    COPY package.json .
    RUN npm install
    COPY . .
    EXPOSE 80
    CMD ["node","app.js"]
    ```
- Build the Docker image
    ```sh
    docker build -t us.gcr.io/<PROJECT_ID>/imagename:tag .
    ```
- Authenticate to GCR
    ```sh
    gcloud auth configure-docker
    ```
- Push docker image to GCR(Google Container Registry)
    ```sh
    docker push us.gcr.io/<PROJECT_ID>/imagename:tag
    ```
- Test the application using docker.
    ```sh
    docker run -d -p 3000:80 us.gcr.io/<PROJECT_ID>/imagename:tag
    ```
- Write kubernetes manifest file for deployment. ```deploy.yml```
    ```yml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name:  nodeappdeployment
      labels:
        type: backend
        app: nodeapp
    spec:
      replicas: 1
      selector:
        matchLabels:
          type: backend
          app: nodeapp
      template:
        metadata:
          name: nodeapppod
          labels:
            type: backend
            app: nodeapp
        spec:
          containers:
            - name: nodecontainer
              image: us.gcr.io/<PROJECT_ID>/imagename:tag
              ports:
                - containerPort: 80
    ```
- Write kubernetes manifest file for service. ```service.yml```
    ```yml
    kind: Service
    apiVersion: v1
    metadata:
      name: nodeapp-load-service
    spec:
      ports:
        - port: 80 
          targetPort: 80
      selector:
        type: backend
        app: nodeapp  
      type: LoadBalancer
    ```
- Apply manifest file to create deployment.
    ```sh
    kubectl apply -f deploy.yml
    ```
- Check status of the deployment.
    ```sh
    kubectl get deploy
    ```
- Apply manifest file to create load balancer service.
    ```sh
    kubectl apply -f service.yml
    ```
- Check status of service.
    ```sh
    kubectl get svc
    ```
- Check the external IP of the service in the browser.

### Cleanup
```sh
kubectl delete -f deploy.yml
kubectl delete -f service.yml
```

> Delete your GKE Cluster from GCP Console.