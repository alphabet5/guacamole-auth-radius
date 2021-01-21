# guacamole-auth-radius

This dockerfile is for easily building the latest radius-auth .jar for Apache Guacamole.

## Usage

- Clone the repo
```bash
cd guacamole-radius-extension
docker build --tag guacamole-auth-radius --build-arg VERSION=1.3.0 .
docker run -d --name=guacamole-auth-radius guacamole-auth-radius
docker cp guacamole-auth-radius:/guacamole-auth-radius-1.1.0.jar .
docker container prune -f
docker image prune -a -f
```
