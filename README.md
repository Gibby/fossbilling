# FOSSBilling Docker Image
This repository holds the source code that's used to build FOSSBilling's docker images.

## Using Docker Compose
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

Once the image is running, you can access access it via your web-browser and follow the on-screen steps to install FOSSBilling.
The database hostname should be `mysql` if you followed this example.

### Post installation steps
1. You should review the [securing FOSSBilling](https://fossbilling.org/docs/security/securing-fossbilling) documentation to ensure your environment has the correct configuration for maximum security.
2. Setup the cronjob to run once every 5 minutes.
When done with the installation you are still required to setup the cronjob. To setup the cronjon run every 5 minutes automatically.
	1. `crontab -e`
	2. `*/5 * * * * docker exec {name of container} php /var/www/html/cron.php`

## Building the images
Clone this repo

```bash
docker build -t fossbilling/fossbilling:latest -t fossbilling/fossbilling:latest .
```

- Currently only the latest tag is available.

- Don't forget the `.` at the end of the command.

- `fossbilling/fossbilling` is the name of the image. You can change it to whatever you want.

## Licensing
This repository includes open source software and is released under the Apache v2.0 license. See [LICENSE](LICENSE) for the full license terms.
