# AWS Auth0 Credentials

This module is used for JWT based authentication. It uses Auth0 to make an application and a grant. The credentials are stored in an AWS Secret.

With this module we try to ensure that secrets are never exposed improperly. Only the receiving party can decrypt the secrets and use it for authentication.

