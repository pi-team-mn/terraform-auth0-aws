# Dcrypting the client secrets

This is written for the client, not the issuer!

To ensure secrecy, only the authorized user can access this secret. This means that the issuer can't access the credentials and send them to you.

To get the secrets you will need to do the following.

1.  Create a role/user for yourself and add the following permissions

```json
{
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect": "Allow",
          "Action": "secretsmanager:GetSecretValue",
          "Resource": "<Provided secret ARN>"
        },
        {
          "Effect": "Allow",
          "Action": "kms:Decrypt",
          "Resource": "<Provided key ARN>"
        }
      ]
}
```

2. Assume this role/user

3. Retrieve the secrets by using the following command. This can also be done with an AWS client library

```shell script
aws secretsmanager get-secret-value --secret-id <Provided secret ARN> --version-stage AWSCURRENT
```

With this you have retrieved the Auth0 Client ID, Secret and Domain. See `getting-a-token.md` for info on how to retrieve a token.

