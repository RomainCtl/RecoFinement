Spotify is an audio streaming and media services provider.

Recofinement uses spotify to __listen to music__, but also to retrieve __user preferences__.

!!! hint "The user can link his spotify account to Recofinement."

## What is used

Recofinement retrieves on each connection:

* the top 20 music listened to by the user,
* the last 20 pieces of music listened to,
* the music from the first 20 playlists

## How to enable this feature

To make these features work, you can follow this guide:

1. Create a Spotify user account (Premium or Free). To do that, simply sign up at [http://www.spotify.com/](http://www.spotify.com/)
3. Register your application (Recofinement) at [Register app page](https://developer.spotify.com/documentation/general/guides/app-settings/#register-your-app) and retrieve your __client id__ and __client secret__.

!!! hint
    You must define the following two variables in the `.env` file of the [API](../../services/api).
    ```
    SPOTIFY_CLIENT_ID=<SPOTIFY_CLIENT_ID>
    SPOTIFY_CLIENT_SECRET=<SPOTIFY_CLIENT_SECRET>
    ```
    See more in the [installation guide](../../installation/#environment-variables)
