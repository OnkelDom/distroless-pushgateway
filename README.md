# distroless-pushgateway

Automatic build for distroless pushgateway container

## Volumes

```
/app = application folder with /app/<command>
/config = config folder with /config/<app>.ext
/data = data forlder with /data volume mount
```

## Default CMD
```
CMD [ \
     "/app/pushgateway", \
     ]
```

## Automatic release check with cron
```
# Create two files:
# .telegram_token with your token
# .telegram_chatid with your chat id
# Clone repo and exec hourly cronjob
$ echo "@hourly /home/onkeldom/git-repos/distroless-pushgateway/get_release.sh 2>&1 | logger -t build_pushgateway" | sudo tee /etc/cron.d/build_pushgateway
```
