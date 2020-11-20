TMDB (The Movie Database) is a community built movie and TV database.

!!! hint "The user can link his tmdb account to Recofinement."

## What is used

Recofinement retrieves on each connection:

* Get user favorite movies and series
* Get user rated movies and series
* Get user created list

## How to enable this feature

To make these features work, you can follow this guide:

!!! note "Recofinement can only use the third version of the TMDB api."

1. Create an account at [https://www.themoviedb.org/](https://www.themoviedb.org/)
2. Register for an API key, click the [API link](https://www.themoviedb.org/settings/api)

!!! hint
    You must define the following variable in the `.env` file of the [API](../../services/api).
    ```
    TMDB_CLIENT_TOKEN=<TMDB_CLIENT_TOKEN>
    ```
    See more in the [installation guide](../../installation/#environment-variables)
