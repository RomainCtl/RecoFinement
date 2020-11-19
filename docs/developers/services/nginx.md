Nginx is an off-the-shelf tool that is used by all of Recofinement's micro-services and tools. It allows you to set up personalised urls for Recofinement services.

## Operating mode

Nginx is an off-the-shelf tool, it is not possible to launch it locally in a development mode. It must be launched with docker.

## Used configuration

In the mode of development, the urls of the micro-services have ports to differentiate them. For example, [UI service](../ui) uses port 80 (or 4200 for the non-build version), [API service](../api) uses the port 4040 and [Engine service](../engine) uses the port 4041.

With __Nginx__, you can only access to the [UI service](../ui) and the [API service](../api) services ([Engine service](../engine) is not accessible from the outside) from the url `<host>/recofinement` for the __UI__ and from `<host>/api` for the __API__.
