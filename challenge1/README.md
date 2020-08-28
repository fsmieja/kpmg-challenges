For this challenge I decided to set up the 3 tier system in aws, using terraform

We have 2 VPCs, one for external facing web servers, and one private for app servers and DB

We have 2 web servers in two subnets load balanced by an ALB

We have 2 app servers in two subnets (no load balancing set up)

I defined things quite loosely, but in the time available I just made sure that terraform was able to understand it and in theory be in a position to deploy reliably and repeatably.

I didnt set up any auto-scaling.


In a modern cloud world, I would think a better way would be not to think so much of tiers, but to leverage Kubernetes, and microservices running in lightweight containers, running on a cluster of nodes (the nodes would be set up by terraform).  Even better, if we use EKS then it is really only needed to control the VPCs and subnets etc via terraform, and then let EKS do its magic setting up the Masters (with resiliency) and then EKS sets up the nodes on provisioned EC2 instances (again terraform can help here).  As far as load balancing across the cluster, you could leverage ALBs on AWS (integrating with EKS), but also the K8s service objects to do load balancing across the lower level microservice pods.
