-- Keycloak Prerequisites:
-- -> create group named 'registry_admins' in keycloak
-- -> create client role in registry client named 'admin' and assign the group mapping to client role 'admin'
-- -> create user and add the user to 'registry_admins' group
-- Create client mappers as follows:
-- Name             Category        Type               
-- groups           Token mapper    Group Membership
-- client roles     Token mapper    User Client Role

local opts = {
    redirect_uri_path = "/redirect_uri",
    accept_none_alg = true,
    discovery = "https://localhost:8443/realms/demo/.well-known/openid-configuration",
    client_id = "registry",
    client_secret = "thisisasecretforregistryclient",
    -- adammalone.net/post/integrating-nginx-and-keycloak-without-openresty/
    ssl_verify = "no",
    redirect_uri_scheme = "http",
    logout_path = "/logout",
    redirect_after_logout_uri = "https://localhost:8443/realms/demo/protocol/openid-connect/logout?redirect_uri=http://localhost:5043/",
    redirect_after_logout_with_id_token_hint = false,
    session_contents = {id_token=true}
  }
  -- call introspect for OAuth 2.0 Bearer Access Token validation
  local res, err = require("resty.openidc").authenticate(opts)
  if err then
     ngx.status = 403
     ngx.say(err)
     ngx.exit(ngx.HTTP_FORBIDDEN)
  end

    -- Group bases access control - create group named 'registry_admins' in keycloak
    --local i = 0
    --if res.id_token.groups ~= nil then
    --    for key,value in ipairs(res.id_token.groups)
    --    do
    --        if value == "/registry_admins" then
    --            i = i + 1
    --        end
    --    end
    --end
    -- if i is greater than 0 that means user is in group /registry_admins
    -- if i is zero that means user is not in group /registry_admins
    -- if i < 1 then
    --    ngx.exit(ngx.HTTP_UNAUTHORIZED)
    -- end

     -- RBAC - create client role in registry client named 'admin' and assign user to that client role
     -- Error handling
    local x = 0
    function checkRoles ()
        if res.id_token.resource_access.registry.roles ~= nil then
                for key,value in ipairs(res.id_token.resource_access.registry.roles)
                do
                    if value == "admin" then
                        x = x + 1
                    end
                end
        end
    end
    -- Error handling
    if pcall(checkRoles) then
        -- no errors while running `checkRoles()'
        if x < 1 then
            ngx.redirect("/logout")
        end
    else
        -- `checkRoles()' raised an error: take appropriate actions
    ngx.redirect("/logout")
    end