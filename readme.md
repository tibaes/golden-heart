# Computer vision container

*Ennyn Durin aran Moria. Pedo mellon a minno.*

## Install


## Configuration

Default jupyter password is "friend"; default port: 9999.
Just in case you want another password, run inside python:

***
from notebook.auth import passwd
passwd()
***

Copy the result and replace the c.NotebookApp.password inside jupyter_notebook_config.py.
If you want another port, change the c.NotebookApp.port parameter.
And in case you want to replace the certificates for ssl, run:

***
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mykey.key -out mycert.pem
***

More information about secure jupyter notebooks can be found in the [project documentation](http://jupyter-notebook.readthedocs.org/en/latest/public_server.html).


*Im Narvi hain echant: Celebrimbor o Eregion teithant i thiw hin.*
