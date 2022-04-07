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


## Keycloak Prerequisites:
### - create group named 'registry_admins' in keycloak
### - create client role in registry client named 'admin' and assign the group mapping to client role 'admin'
### - create user and add the user to 'registry_admins' group
### - Create client mappers as follows:
| Name | Category |  Type |
| --- | ----------- |---|
| groups  |         Token mapper  |  Group Membership
| client roles|     Token mapper  |  User Client Role