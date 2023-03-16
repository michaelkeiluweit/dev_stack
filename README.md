

## Setup

Build the custom PHP image & start the containers
```
git clone https://github.com/michaelkeiluweit/dev_stack.git --branch=symfony6
docker build --tag=php-symfony6 .
docker-compose up -d
docker-compose exec php bash
symfony new .
```

## Troubleshooting
- The apache webserver expects the directory `public` within the folder `www`, as it is the document root.
