Mailjet is a French email marketing platform. It is a cloud-based email delivery and tracking system which allows users to send marketing emails and transactional emails.

## Why is mailjet used?

Recofinement uses mailjet to __send e-mails__ to users, and more specifically in these cases:

* When creating an account
* To send a password recovery email

## How to enable this feature

To make these features work, you can follow this guide:

1. [Create a Mailjet account](https://app.mailjet.com/signup)
2. [Retrieve your API and Secret keys](https://app.mailjet.com/account/api_keys), they will be used to authenticate the application (Recofinement).

!!! hint
    You must define the following two variables in the `.env` file of the [API](../../services/api).
    ```
    MJ_APIKEY_PUBLIC=<MAILJET_API_KEY>
    MJ_APIKEY_PRIVATE=<MAILJET_API_SECRET>
    ```
    See more in the [installation guide](../../installation/#environment-variables)
