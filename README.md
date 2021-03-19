### Initial - USER=devops PASSWORD=devops123

### Creating a new user & password:
```bash
docker run --rm --entrypoint htpasswd registry:2.7.0 -Bbn <user> <password> > auth/nginx.htpasswd
```
### Purge tags:

```bash
docker exec -t registry-ui /opt/docker-registry-ui -purge-tags -dry-run
```

### Setup environment:
```bash
docker-compose up -d
```
