#Task
Set up a local Kubernetes Cluster on my machine,
Deploy and App to the cluster,
Send some load/traffic to the app,
Devise a solution to visualize the traffic sent.











#Overview of the deployment
•	Install all dependencies i.e minikube, docker, java, python, taurus.
•	A python flask app was deployed “app.py” ensuring endpoint exposed to Prometheus for metrics. The python app is a simple app that prints “Hello World”.
•	A dockerfile was created. The docker file pulls a base python image from official python.
•	A requirement.txt file containing the dependencies to run the application.
•	Build docker image using Docker.
•	For the app deployment, a terraform script was written for automation of the process.
•	For Prometheus the scrape metrics, we needed to create configmap, deployment & service which was also included in the terraform script.
•	Finally, to visualize the traffic, Grafana deployment &service were also created in the terraform script.
•	Once my deployments were running, I logged into Grafana to configure Prometheus as my data source. 
•	Next was to create a dashboard to visualize the traffic. Since we set up had http request as metrics for Prometheus to track, we run a query for this on Grafana to visualize.
•	While using Taurus to send traffic to the application, Grafana was able to visualize the traffic and produce metrics.
•	Taurus was set up to send 1000 requests to the application, and print results.


#Challenges and Solution
•	First main challenge was deploying the application manually, while this method was able to solve bit size issues, it wasn’t sustainable as when changes occur, I’ll have had to keep deleting resources manually and re applying. The solution was to write a terraform script to automate the whole process.
•	Another challenge was configuring the metrics, despite being able to access my application, Grafana wasn’t receiving the traffic sent. This was because the load.yaml file had the incorrect ip address, which was making it fail. After changing the ip address, Grafana was able to visualize the traffic.
•	After running minikube service to deploy the application, the service port kept changing despite setting it to port to 3000, I realized minikube , despite setting a port, starts the tunnel on a different port. The solution was to get the port the service was running on by running “minikube service {servicename}”. This command starts the tunnel and declares the port it is running on.


#Results
•	All dependencies were installed on my local machine.
•	The dockerfile was used to build an image for the container. 
•	The Image was successfully pushed to dockerhub which was then used to deploy the application Kubernetes.
•	By running Terraform apply,  I was able to deploy the application.
•	Taurus was used to send traffic to the application.
•	Prometheus was used to scrape the metrics.
•	Grafana dashboard was used to visualize the traffic.


#Summary of Tools and Technologies Used.

•	Docker: To build container image.
•	Dockerhub:  A repository for storing docker images.
•	Minikube : For running docker images as a container.
•	Taurus : For sending traffic to app.
•	Prometheus: For scarping metrics.
•	Grafana: Visualizing Traffic/Metrics
•	Terraform: For Automation.


#Security and Automation Considerations

•	While this cluster was run locally, it could have also been run on an virtual machine with a cloud provider, providing security using security groups or on a server with firewall protection.
•	For other complex applications, the database could also be protected in a private subnet with a NAT gateway.
•	Jenkins could also be used as an automation tool.



