# Setup Docker Environment
// Source: https://ranchermanager.docs.rancher.com/v2.5/pages-for-subheaders/rancher-on-a-single-node-with-docker

docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  --privileged \
  rancher/rancher:latest
