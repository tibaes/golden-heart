# Set options for certfile, ip, password, and toggle off browser auto-opening
c.NotebookApp.certfile =u'/root/mycert.pem'
c.NotebookApp.keyfile = u'/root/mykey.key'
# Set ip to '*' to bind on all interfaces (ips) for the public server
c.NotebookApp.ip = '*'
c.NotebookApp.password = u'sha1:1dd2478c7247:b0de6a84a410ef6889a742ea5cc34a83be03d4d6'
c.NotebookApp.open_browser = False

# It is a good idea to set a known, fixed port for server access
c.NotebookApp.port = 9999 
