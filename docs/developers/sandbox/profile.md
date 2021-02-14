## Create a profile

Profiles are user like element easy to create and to delete, used to test recommendation algorithms of the application. The profiles are linked to an administrator, who can modify their preferences and the content they like.  

### Profile structure

| Name | Type | Description |
|---|---|---|
| __profile_id__ | __Integer__ | __Visible profile identifier__ |
| uuid | UUID | profile identifier |
| profilename | String | Profile name |
| user_id | Integer | User id of profile creator |

### Profile creation 
![Profile creation screen](../assets/images/***.png)

## Create recommendation for this profile

Profile recommendations are created on-the-fly to be displayed as fast as possible. This recommendations are affacted by user's one, but user's one are not affected by profile recommendations.

They are made only with faststr algorithm :

 - Algo a
 - Algo b
 - Algo c
