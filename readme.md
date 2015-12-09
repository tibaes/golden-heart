Default jupyter password is "friend".

http://jupyter-notebook.readthedocs.org/en/latest/public_server.html
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mykey.key -out mycert.pem

docker run -it -p 9999:9999 --name affective goldenheart:latest
docker start -i affective


docker cp ~/.ssh/id_dsa.pub   affective:/root/.ssh/
docker cp ~/.ssh/id_dsa   affective:/root/.ssh/
