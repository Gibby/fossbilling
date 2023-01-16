# Docker
Packaging Docker images for FOSSBilling.

## Prerequisites

Make sure you have [Docker](https://docs.docker.com/get-docker/) and docker-compose allready installed. If you want tot build the images your self. Git is a requirement!

## Run Docker image for FOSSBilling

### Using Docker Compose
This is an example of a `docker-compose.yml` file. You should change the values to suit your needs:

```yaml
version: "3.9"
services:
  fossbilling:
    image: fossbilling/fossbilling
    restart: always
    ports:
      - 80:80
    volumes:
      - fossbilling:/var/www/html
  mysql:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_DATABASE: exampledb
      MYSQL_USER: exampleuser
      MYSQL_PASSWORD: examplepass
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - mysql:/var/lib/mysql

volumes:
  fossbilling:
  mysql:
```

Then, use the web interface to install FOSSBilling. If you used this example, the database host field in the installer should be filled with `mysql`. Other fields should be self-explanatory.

When done with the installation you are still required to setup the cronjob. To setup the cronjon run
```
crontab -e
```
```
*/5 * * * * docker exec {name of container} php /var/www/html/cron.php
```

## Build images
Clone this repo

```bash
docker build -t fossbilling/fossbilling:latest -t fossbilling/fossbilling:0.2.4 .
```

- The image will have multiple tags. The `latest` tag is for the latest release. The `0.2.4` tag is the version of the FOSSBilling release. Don't forget to change the version number.

- Don't forget the `.` at the end of the command.

- fossbilling/fossbilling is the name of the image. You can change it to whatever you want.

## Licensing
This repository includes open source software and is released under the Apache v2.0 license. See [LICENSE](LICENSE) for the full license terms.
