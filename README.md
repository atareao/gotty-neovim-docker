# croni

This is a simple container with a cron.

## Use

Before deploy de container, change `poduser` file with your commands to execute. Must remember that there is minimal dependecies, as `curl`, if you need more dependencies, please add them.

The format of the `poduser` file is like crontab

```
docker stop croni
docker rm croni
docker build --tag atareao/croni .
docker run -d --name croni atareao/croni
docker logs -f croni
```
