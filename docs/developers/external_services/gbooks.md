Google books is a service from Googl. Books are provided either by publishers and authors through the Google Books Partner Program, additionally, Google has partnered with a number of magazine publishers to digitize their archives.

!!! hint "The user can link his tmdb account to Recofinement."

## What is used

Recofinement retrieves on each connection:

* the books with which the user has interacted (text review and/or rating)

## How to enable this feature

To make these features work, you can follow this guide:

1. Get a google account: [https://www.google.com/accounts/NewAccount](https://www.google.com/accounts/NewAccount)
2. Register your application (Recofinement) using the [Google API Console](https://console.developers.google.com/)
3. Activate the Books API int the Google API Console
4. Open the [Credential page](https://console.developers.google.com/apis/credentials) in the API Console
5. if necessary, configure the authorisation screen (Called "Oauth Consent screen")
6. On the Credential page, click on "Create credentials" - "OAuth Client ID"
7. Still on Credential page, on the "ID clients OAuth 2.0" section, you may find an OAuth client (the one you created), click on download button to download the "oauth file"

!!! hint
    You must define the following variable in the `.env` file of the [API](../../services/api).
    ```
    PATH_TO_GOOGLE_OAUTH_FILE=<PATH_TO_GOOGLE_OAUTH_FILE>
    ```
    See more in the [installation guide](../../installation/#environment-variables)
