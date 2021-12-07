

## Setup
```
git clone --branch php https://github.com/michaelkeiluweit/dev_stack.git
```

Build the custom PHP image & start the containers
```
docker build --tag=mkphp:1.0 .
docker-compose up -d
```

```
docker-compose exec php bash
```

## Troubleshooting
- The apache webserver expects the directory `public` within the folder `www`, as it is the document root.
