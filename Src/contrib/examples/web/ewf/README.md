Examples
========

This folder contains a few examples demonstrating the EiffelWeb framework solution.


## tutorial
This is a step by step tutorial to discover the EiffelWeb framework (EWF). 
How to build your first service, access the request data and send the response, also how to use the router to dispatch url easily.

## simple
This is a very simple system that can be executed as standalone, or hosted as CGI or libFCGI application on Apache, IIS, ...
You will learn how to customize the launcher (port number for standalone, ...), and how to use the interface of `WSF_RESPONSE` to send the response. 
(note: in this example, you have to deal with the Content-Type and Content-Length http header, this requires basic knowledge about the http protocol).
[learn more](./simple/README.md)

## simple_ssl
Almost the same as `simple` example, except this `simple_ssl` example is using only the `standalone` connector, and is supporting `https://` request. You will learn how to configure the .ecf file to add ssl support (see `<variable name="ssl_enabled" value="true"/>`), and how to enable it for instance via the `simple.ini` file (imported from the class `APPLICATION`).
[learn more](./simple_ssl/README.md)

## simple_file
This demonstrates how to return a file to the client. In this example you will learn how to dispatch manually the URL thanks to the `request.path_info` value.
You will also learn how to use the `WSF_RESPONSE.send (message)` interface that does not require you to know that much about http protocol since you will build `WSF_FILE_RESPONSE` and `WSF_NOT_FOUND_MESSAGE` objects.
[learn more](./simple_file/README.md)

## upload_image
This example shows how to handle file uploading, and also how to use the `WSF_FILE_SYSTEM_HANDLER` to serve local files (i.e a file server component).
It also uses the `WSF_ROUTER` component to route URL based on URI-template declaration.
[learn more](./upload_image/README.md)

## form
The EiffelWeb framework provides the `wsf_html` library, it is a set of classes to make it easier to generate html using Eiffel code. This includes web form generation, but also web form handling as it analyzes the request data to fill the web form response. 
This example shows a simple web form asking for name, birthday, and other radio,checkboxes,combo,file ... input data, and store the result in local directory.
[learn more](./form/README.md)

## desktop_app
Using the EiffelVision2 embedded web browser component, you will learn how to embed a web server in your GUI application. This way you can run locally a web server and display html pages in the GUI application itself.
[learn more](./desktop_app/README.md)

## proxy
Via the `wsf_proxy` library, it is possible to implement a simple reverse proxy service. 
Note: you need to edit the `application_execution.e` file to use proper remote service.
[learn more](./proxy/README.md)

## websocket
The EiffelWeb framework provides a websocket server and websocket client solution. This example demonstrates how to build a simple websocket service and consume it from a html+javascript page. This is a very simple chat application.
[learn more](./websocket/README.md)

## rest
### restbuck CRUD system
Restbuck Eiffel Implementation based on the book of REST in Practice.
This is an implementation of CRUD pattern for manipulate resources, this is the first step to use the HTTP protocol as an application protocol instead of a transport protocol.
[learn more](./rest/restbucks_CRUD/readme.md)

## debug
This example is a simple service that analyze the request and return a formatted output of the request data (query parameters, form parameters, environment variables, and so on). It could be used to debug client, or to experiment the EiffelWeb behavior on various connectors (standalone, apache, iis, ...).
[learn more](./debug/README.md)

## obsolete
A set of example using the old interface of EiffelWeb  (i.e version v0). We keep them as example for people having existing project based on EWF v0, but willing to compile with latest EiffelStudio, and latest EWF source code.
[learn more](./obsolete/README.md)

## _update_needed
This folder contains set of examples that need to be reviewed and updated for various reason.
[learn more](./_update_needed/README.md)
