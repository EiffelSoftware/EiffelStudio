#!/usr/bin/python
import xmlrpclib
s=xmlrpclib.ServerProxy("http://localhost:55000/xmlrpc_demo/demo.xrpc")
i = s.demo.sum(4,5)
print(i)
i = s.demo.hello("Paul ")
print(i)

