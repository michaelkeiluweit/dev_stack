

## Setup

Build the PHP container

Build the custom PHP image & start the containers
```
docker build --tag=mkphp:1.0 .
docker-compose up -d
```

## Troubleshooting
- The apache webserver expects the directory `public` within the folder `www`, as it is the document root.