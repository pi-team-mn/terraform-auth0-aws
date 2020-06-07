# Dcrypting the client secrets

This is written for the client, not the issuer!

To ensure secrecy, only the authorized user can access this secret. This means that the issuer can't access the credentials and send them to you.

To get the secrets you will need to do the following.

1.  Create a role for yourself with the following permissions

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
          "Resource": "<Provided key ARN"
        }
      ]
}
```


