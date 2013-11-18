Restbuck Eiffel Implementation based on the book of REST in Practice
====================================================================
This is an implementation of CRUD pattern for manipulate resources, this is the first step to use
the HTTP protocol as an application protocol instead of a transport protocol.

Restbuck Protocol
-----------------

<table>
<TR><TH>Verb</TH>         <TH>URI or template</TH>     <TH>Use</TH></TR>
<TR><TD>POST</TD>         <TD>/order</TD>              <TD>Create a new order, and upon success, receive a Locationheader specifying the new order's URI.</TD></TR>
<TR><TD>GET</TD>          <TD>/order/{orderId}</TD>    <TD>Request the current state of the order specified by the URI.</TD></TR>
<TR><TD>PUT</TD>          <TD>/order/{orderId}</TD>    <TD>Update an order at the given URI with new information, providing the full representation.</TD></TR>
<TR><TD>DELETE</TD>       <TD>/order/{orderId}</TD>    <TD>Logically remove the order identified by the given URI.</TD></TR>
</table>

Resource Represenation
----------------------
The previous tables shows a contrat, the URI or URI template, allows us to indentify resources, now we will chose a 
representacion, for this particular case we will use JSON.

Note: <br/>
1. *A resource can have multiple URIs*.<br/>
2. *A resource can have multiple Representations*.<br/>

RESTBUCKS_SERVER
----------------
This class implement the main entry of our REST CRUD service, we are using a default connector (Nino Connector, 
using a WebServer written in Eiffel).
We are inheriting from URI_TEMPLATE_ROUTED_SERVICE, this allows us to map our service contrat, as is shown in the previous
table, the mapping is defined in the feature setup_router, this also show that the class ORDER_HANDLER will be encharge
of to handle different type of request to the ORDER resource.


	class
		RESTBUCKS_SERVER
	
	inherit
		ANY
	
		URI_TEMPLATE_ROUTED_SERVICE
	
		DEFAULT_SERVICE
			-- Here we are using a default connector using the default Nino Connector,
			-- but it's possible to use other connector (CGI or FCGI).
	
	create
		make
	
	feature {NONE} -- Initialization
	
		make
			-- Initialize the router (this will have the request handler and 
			-- their context).
			do
				initialize_router
				make_and_launch
			end
	
		create_router
			do
				create router.make (2)
			end
	
		setup_router
			local
				order_handler: ORDER_HANDLER [REQUEST_URI_TEMPLATE_HANDLER_CONTEXT]
			do
				create order_handler
				router.map_with_request_methods ("/order", order_handler, <<"POST">>)
				router.map_with_request_methods ("/order/{orderid}", order_handler, <<"GET", "DELETE", "PUT">>)
			end
	
	feature -- Execution
	
		execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
				-- I'm using this method to handle the method not allowed response
				-- in the case that the given uri does not have a corresponding http method
				-- to handle it.
			local
				h : HTTP_HEADER
				l_description : STRING
				l_api_doc : STRING
			do
				if req.content_length_value > 0 then
					req.input.read_string (req.content_length_value.as_integer_32)
				end
				create h.make
				h.put_status ({HTTP_STATUS_CODE}.method_not_allowed)
				h.put_content_type_text_plain
				l_api_doc := "%NPlease check the API%NURI:/order METHOD: POST%NURI:/order/{orderid} METHOD: GET, PUT, DELETE%N"
				l_description := req.request_method + req.request_uri + " is not allowed" + "%N" + l_api_doc
				h.put_content_length (l_description.count)
				h.put_current_date
				res.set_status_code ({HTTP_STATUS_CODE}.method_not_allowed)
				res.write_header_text (h.string)
				res.write_string (l_description)
			end
	
	end



How to Create an order with POST
--------------------------------

Here is the convention that we are using: 
POST is used for creation and the server determines the URI of the created resource.
If the request POST is SUCCESS, the server will create the order and will response with
201 CREATED, the Location header will contains the newly created order's URI,
if the request POST is not SUCCESS, the server will response with
400 BAD REQUEST, the client send a bad request or
500 INTERNAL_SERVER_ERROR, when the server can deliver the request.

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

Response success

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


How to Read an order with GET
-----------------------------
Using GET to retrieve resource information.
If the GET request is SUCCESS, we response with 200 OK, and a representation of the order
If the GET request is not SUCCESS, we response with 404 Resource not found
If is a Conditional GET and the resource does not change we send a 304, Resource not modifed

	GET /order/1 HTTP/1.1
	Host: 127.0.0.1:8080
	Connection: keep-alive
	Accept: */*
	Accept-Encoding: gzip,deflate,sdch
	Accept-Language: es-419,es;q=0.8,en;q=0.6
	Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3
	If-None-Match: 6542EF270D91D3EAF39CFB382E4CEBA7

Response
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


Response success

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

How to Delete an order with DELETE
----------------------------------
Here we use DELETE to cancel an order, if that order is in state where it can still be canceled.
204 if is ok
404 Resource not found
405 if consumer and service's view of the resouce state is inconsisent
500 if we have an internal server error


	DELETE /order/1 HTTP/1.1
	Host: localhost:8080
	Connection: Keep-Alive

Response success

	HTTP/1.1 204 No Content

	Status	204 No Content
	Content-Type	application/json
	Date	FRI,09 DEC 2011 21:10:51.00 GMT
	
If we want to check that the resource does not exist anymore we can try to retrieve a GET /order/1 and we will receive a
404 No Found

	GET /order/1 HTTP/1.1
	Host: localhost:8080
	Connection: Keep-Alive

Response

	HTTP/1.1 404 Not Found
	
	Status	404 Not Found
	Content-Type	application/json
	Content-Length	44
	Date	FRI,09 DEC 2011 21:14:17.79 GMT

	The following resource/order/1 is not found 


References
----------
1. [How to get a cup of coffe](http://www.infoq.com/articles/webber-rest-workflow) 
2. [Rest in Practice] (http://restinpractice.com/default.aspx)
