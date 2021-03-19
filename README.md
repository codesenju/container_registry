### Initial - USER=devops PASSWORD=devops123

### Creating a new user & password:
```shell
docker run --rm --entrypoint htpasswd registry:2.7.0 -Bbn devops devops123 > auth/nginx.htpasswd
```
docker exec -t registry-ui /opt/docker-registry-ui -purge-tags -dry-run
