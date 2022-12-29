

## Setup

Build the PHP container

Build the custom PHP image & start the containers
```
docker build --tag=mkphp .
docker-compose up -d
```

## Troubleshooting
- The apache webserver expects the directory `public` within the folder `app`, as it is the document root.  
In case the entrypoint of your project is different to public, a workaround could be to create a symlink: `ln -s src/public/ public`.
