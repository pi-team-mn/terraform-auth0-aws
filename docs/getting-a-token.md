# Getting a token

This guide is for the client user, not the issuer!

Here we describe the steps needed to get a vald JWT token. You will need to have completed `decrypting-the-secrets` first.

With inspiration from [auth0 itself](https://auth0.com/blog/using-m2m-authorization/).

## What you will need

- Secret ARN 

## Steps

1. Decrypt the secrets
    (see `decrypting-the-secret`)
2. Make a call to Auth0 with the following credentials.
    ```http request
    POST https://<secret.domain>/oauth/token
    Content-Type: application/json
    {
      "audience": "<secret.audience>",
      "grant_type": "client_credentials",
      "client_id": "<secret.client_id>",
      "client_secret": "<secret.client_secret>"
    }
    ```
3. The response should contain a token
    ```json
    HTTP/1.1 200 OK
    Content-Type: application/json
    {
      "access_token": "eyJz93a...k4laUWw",
      "token_type": "Bearer",
      "expires_in": 86400
    }

    ```
4. Make a request to the secured service and add the following header
    `Authorization: Bearer <access_token>`
5. The request should now be accepted. If there is an issue with the token, you will get `HTTP 401` with a description detailing what went wrong
