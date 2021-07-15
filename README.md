# dev_stack

## Preparation


### Verbose PHP messages (optional)
Replace
```
    echo max_execution_time=0 >> /usr/local/etc/php/conf.d/php.ini;
```
with
```
    echo max_execution_time=0 >> /usr/local/etc/php/conf.d/php.ini; \
    echo error_reporting = E_ALL >> /usr/local/etc/php/conf.d/php.ini; \
    echo log_errors = On >> /usr/local/etc/php/conf.d/php.ini; \
    echo error_log = /proc/self/fd/2 >> /usr/local/etc/php/conf.d/php.ini;
```

### Build the PHP container
Build the custom PHP image & start the containers

```
docker build --tag=mkphp:1.0 images/php/8.0/
docker-compose up -d
```
