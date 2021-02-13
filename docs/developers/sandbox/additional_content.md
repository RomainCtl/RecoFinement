## Validate content

The sandbox allow administrator to add media content to the database. The administrator can validate the addition of the content to the database, or he can refuse it and the additional content will be deleted. The admin need `validate_media` permission to effectuate this action. 

![Profile recommendaiton creation screen](../assets/images/***.png)

Additional media content are different from basic content. 

### Application

| Name | Type | Description |
|---|---|---|
| __app_id__ | __Integer__ | __Application identifier__ |
| name | String | Application name |
| size | String | Application size
| installs | String | Number of installations by unique users |
| type | String | 'Paid' or 'Free' |
| price | String | Price |
| content_rating | String | application classification (by age group) |
| last_updated | String | last update date |
| current_version | String | current app version number |
| android_version | String | minimum android version required |
| cover | String | cover url |

### Book

| Name | Type | Description |
|---|---|---|
| __book_id__ | __Integer__ | __Additional book identifier__ |
| isbn | String | Book universal identifier |
| title | String | Book title |
| author | String | Book author |
| year_of_publication | Integer | Year of publication |
| publisher | String | Publisher company |
| image_url_s | String | URL for small image size |
| image_url_m | String | URL for medium image size |
| image_url_l | String | URL for large image size |

### Episode 

| Name | Type | Description |
|---|---|---|
| __episode_id__ | __Integer__ | __Episode identifier__ |
| imdbid | String | IMDB identifier |
| title | String |  |
| year | Integer | release year |
| season_number | Integer |  |
| episode_number | Integer |  |
| serie_id | Integer | [Serie](#series) identifier |

### Game

| Name | Type | Description |
|---|---|---|
| __game_id__ | __Integer__ | __Game identifier__ |
| steamid | Integer | Steam game identifier |
| name | String | Game name |
| short_description | Text |  |
| header_image | String |  |
| website | String | URL of official game website |
| developers | String | developers company name |
| publishers | String | publisher company name |
| price | String |  |
| release_date | String |  |

### Movie

| Name | Type | Description |
|---|---|---|
| __movie_id__ | __Integer__ | __Movie identifier__ |
| title | String | Movie title |
| language | String | Main language |
| actors | String | List of main actors separated by '\|' |
| year | String | Release year |
| producers | String | List of producers separated by '\|' |
| director | String | Name of the director |
| writer | String | Name of the writer |
| imdbid | String | IMDB movie identifier |
| tmdbid | String | TMDB movie identifier |
| cover | String | Cover url |
| plot_outline | String | synopsis |

### Serie

| Name | Type | Description |
|---|---|---|
| __serie_id__ | __Integer__ | __Serie identifier__ |
| imdbid | String | IMDB identifier |
| title | String |  |
| start_year | Integer |  |
| end_year | Integer |  |
| writers | Text | List of writers separated by ',' |
| directors | Text | List of directors separated by ',' |
| actors | Text | List of actors separated by ',' |
| cover | String | Cover url |
| plot_outline | String | synopsis |

### Track

| Name | Type | Description |
|---|---|---|
| __track_id__ | __Integer__ | __Track identifier__ |
| title | String | Track title |
| year | Integer | Release year |
| artist_name | String | Artist name |
| release | String | Realse (album) associated with this track |
| track_mmid | String | Million Song track identifier |
| recording_mbid | UUID | MusicBrainz track identifier |
| spotify_id | String | Track spotify id |
| covert_art_url | Text |  |