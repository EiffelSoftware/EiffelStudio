Restbuck Eiffel Implementation based on the book of REST in Practice
====================================================================
This is an implementation of CRUD pattern for manipulate resources, this is the first step to use
the HTTP protocol as an application protocol instead of a transport protocol.

Restbuck Protocol
-----------------

* Method `POST` with URI `/order` : Create a new order, and upon success, receive a Locationheader specifying the new order's URI.
* Method `GET` with URI-template `/order/{orderId}` : Request the current state of the order specified by the URI.
* Method `PUT` with URI-template `/order/{orderId}` : Update an order at the given URI with new information, providing the full representation.
* Method `DELETE` with URI-tempalte `/order/{orderId}` : Logically remove the order identified by the given URI.

Resource Represenation
----------------------
The previous tables shows a contrat, the URI or URI-template, allows us to indentify resources, now we will chose a 
representation, for this particular case we will use JSON.

Note: 
1. *A resource can have multiple URIs*.
2. *A resource can have multiple Representations*.

RESTBUCKS_SERVER
----------------
This class implement the main entry of our REST CRUD service, we are using a default connector (Standalone Connector, 
using a WebServer written in Eiffel).
We are inheriting from `WSF_ROUTED_SKELETON_EXECUTION`, this allows us to map our service contrat, as is shown in the previous
table, the mapping is defined in the feature `setup_router`, this also show that the class `ORDER_HANDLER` will be in charge
 of handling different types of request to the ORDER resource.

```
	class RESTBUCKS_SERVER_EXECUTION

	inherit
		WSF_ROUTED_SKELETON_EXECUTION
			undefine
				requires_proxy
			end

		WSF_NO_PROXY_POLICY


		SHARED_RESTBUCKS_API

	create
		make

	feature {NONE} -- Initialization

		setup_router
			local
				doc: WSF_ROUTER_SELF_DOCUMENTATION_HANDLER
			do
				setup_order_handler (router)

				create doc.make_hidden (router)
				router.handle ("/api/doc", doc, router.methods_GET)
			end

		setup_order_handler (a_router: WSF_ROUTER)
			local
				order_handler: ORDER_HANDLER
			do
				create order_handler.make ("orderid", a_router)
				router.handle ("/order", order_handler, router.methods_POST)
				router.handle ("/order/{orderid}", order_handler, router.methods_GET + router.methods_DELETE + router.methods_PUT)
			end

	end
```

How to Create an order with POST
--------------------------------

Here is the convention that we are using: 
POST is used for creation and the server determines the URI of the created resource.
If the request POST is SUCCESS, the server will create the order and will response with
201 CREATED, the Location header will contains the newly created order's URI,
if the request POST is not SUCCESS, the server will response with
400 BAD REQUEST, the client send a bad request or
500 INTERNAL_SERVER_ERROR, when the server can deliver the request.
```
	POST /order HTTP/1.1
	Host: 127.0.0.1:8080
	Connection: keep-alive
	Content-Length: 196
	Origin: chrome-extension://fhjcajmcbmldlhcimfajhfbgofnpcjmb
	Content-Type: application/json
	Accept: */*
	Accept-Encoding: gzip,deflate,sdch
	Accept-Language: es-419,es;q=0.8,en;q=0.6
	Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3
		     
	{
	 "location":"takeAway",
	 "items":[
	          {
	           "name":"Late",
		   "option":"skim",
		   "size":"Small",
		   "quantity":1
		   }
	    ]
	}
```

Response success
```
	HTTP/1.1 201 Created
	Status	201 Created
	Content-Type	application/json
	Content-Length	123
	Location	http://localhost:8080/order/1
	Date	FRI,09 DEC 2011 20:34:20.00 GMT
	
	{
	  "location" : "takeAway",
	  "status" : "submitted",
	  "items" : [ {
	    "name" : "late",
	    "size" : "small",
	    "quantity" : 1,
	    "option" : "skim"
	  } ]
	}
```

note: 
    curl -vv http://localhost:9090/order -H "Content-Type: application/json" -d "{\"location\":\"takeAway\",\"items\":[{\"name\":\"Late\",\"option\":\"skim\",\"size\":\"Small\",\"quantity\":1}]}" -X POST 


How to Read an order with GET
-----------------------------
Using GET to retrieve resource information.
If the GET request is SUCCESS, we response with 200 OK, and a representation of the order
If the GET request is not SUCCESS, we response with 404 Resource not found
If is a Conditional GET and the resource does not change we send a 304, Resource not modifed

```
	GET /order/1 HTTP/1.1
	Host: 127.0.0.1:8080
	Connection: keep-alive
	Accept: */*
	Accept-Encoding: gzip,deflate,sdch
	Accept-Language: es-419,es;q=0.8,en;q=0.6
	Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3
	If-None-Match: 6542EF270D91D3EAF39CFB382E4CEBA7
```

Response
```
	HTTP/1.1 200 OK
	
	Status	200 OK
	Content-Type	application/json
	Content-Length	123
	Date	FRI,09 DEC 2011 20:53:46.00 GMT
	etag	2ED3A40954A95D766FC155682DC8BB52
	
	{
	  "location" : "takeAway",
	  "status" : "submitted",
	  "items" : [ {
	    "name" : "late",
	    "size" : "small",
	    "quantity" : 1,
	    "option" : "skim"
	  } ]
	}
```

note:
    curl -vv http://localhost:9090/order/1 

How to Update an order with PUT
-------------------------------
A successful PUT request will not create a new resource, instead it will change the state of the resource identified by the current uri.
If success we response with 200 and the updated order.
404 if the order is not found
400 in case of a bad request
500 internal server error
If the request is a Conditional PUT, and it does not mat we response 415, precondition failed.

Suposse that we had created an Order with the values shown in the _How to create an order with POST_
But we change our decision and we want to stay in the shop.

```
	PUT /order/1 HTTP/1.1
	Content-Length: 122
	Content-Type: application/json; charset=UTF-8
	Host: localhost:8080
	Connection: Keep-Alive
	Expect: 100-Continue

	{
	  "location" : "in shop",
	  "status" : "submitted",
	  "items" : [ {
	    "name" : "late",
	    "size" : "small",
	    "quantity" : 1,
	    "option" : "skim"
	  } ]
	}
```

Response success
```
	HTTP/1.1 200 OK
	Status	200 OK
	Content-Type	application/json
	Date	FRI,09 DEC 2011 21:06:26.00 GMT
	etag	8767F900674B843E1F3F70BCF3E62403
	Content-Length	122
	
	{
  	"location" : "in shop",
  	"status" : "submitted",
  	"items" : [ {
    		"name" : "late",
    		"size" : "small",
    		"quantity" : 1,
    		"option" : "skim"
  	} ]
	}
```

How to Delete an order with DELETE
----------------------------------
Here we use DELETE to cancel an order, if that order is in state where it can still be canceled.
204 if is ok
404 Resource not found
405 if consumer and service's view of the resouce state is inconsisent
500 if we have an internal server error

```
	DELETE /order/1 HTTP/1.1
	Host: localhost:8080
	Connection: Keep-Alive
```

Response success

```
	HTTP/1.1 204 No Content

	Status	204 No Content
	Content-Type	application/json
	Date	FRI,09 DEC 2011 21:10:51.00 GMT
```

If we want to check that the resource does not exist anymore we can try to retrieve a GET /order/1 and we will receive a
404 No Found

```
	GET /order/1 HTTP/1.1
	Host: localhost:8080
	Connection: Keep-Alive
```

Response

```
	HTTP/1.1 404 Not Found
	
	Status	404 Not Found
	Content-Type	application/json
	Content-Length	44
	Date	FRI,09 DEC 2011 21:14:17.79 GMT

	The following resource/order/1 is not found 
```

References
----------
1. [How to get a cup of coffe](http://www.infoq.com/articles/webber-rest-workflow) 
2. [Rest in Practice](http://restinpractice.com/default.aspx)

