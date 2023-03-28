# Deploy an Application to GKE (Google Kubernetes Engine) 
### Tech used:
- Docker
- Kubernetes
- GKE (Google Kubernetes Engine)
- GCR (Google Container Registry)

# Steps
- Create a kubernetes cluster on GCP Console.

  You can easily create the GKE cluster by login to the GCP console and click on Kubenetes Engine. 
  
  Click on Create button.
  <p>
  <img src="https://github.com/Adarsh-Suvarna/DevOps-Project-1/blob/main/image/GKE1.png">
  </p>

  Now click on USE A SETUP GUIDE option and click on My First Cluster and this helps you to easily create a GKE Cluster.
  Click on Create Now button and wait for few minutes and your GKE cluster will be ready!
  <p>
  <img src="https://github.com/Adarsh-Suvarna/DevOps-Project-1/blob/main/image/GKE2.png">
  </p>
- Setup Connection to created GKE cluster in with your local machine or cloud shell.
    ```sh
    gcloud container clusters get-credentials <CLUSTER_NAME> --zone <ZONE> --project <PROJECT_ID>
    ```
- Write Dockerfile for the application
    ```Dockerfile
    FROM  centos:latest
    MAINTAINER adarshasuvarna@outlook.com
    RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
    RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
    RUN yum install -y httpd \
    zip\
    unzip
    ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
    WORKDIR /var/www/html/
    RUN unzip photogenic.zip
    RUN cp -rvf photogenic/* .
    RUN rm -rf photogenic photogenic.zip
    CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
    EXPOSE 80
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
      name:  devops-project-1-deployment
      labels:
        type: backend
        app: devops-project-1
    spec:
      replicas: 1
      selector:
        matchLabels:
          type: backend
          app: devops-project-1
      template:
        metadata:
          name: devops-project-1-pod
          labels:
            type: backend
            app: devops-project-1
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
      name: devops-project-1-load-service
    spec:
      ports:
        - port: 80 
          targetPort: 80
      selector:
        type: backend
        app: devops-project-1  
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
  <p>
  <img src="https://github.com/Adarsh-Suvarna/DevOps-Project-1/blob/main/image/UI.png">
  </p>

### Cleanup
```sh
kubectl delete -f deploy.yml
kubectl delete -f service.yml
```