class
	APPLICATION

inherit
	XRPC_SHARED_SERVER_DISPATCHER

	XRPC_SHARED_REQUEST_HANDLER

	XRPC_SHARED_MARSHALLER

create
	make

feature {NONE} -- Initialization

	make
		local
			l_rpcs: MY_XMLRPC
			l_response: STRING
		do
				-- Create out RPCS
			create l_rpcs
				-- Extend the dispatch server with our own delegate
			dispatcher.extend (l_rpcs)
				-- The {MY_XMLRPC} object should now be assigned to a dispatcher.
			check has_dispatcher: l_rpcs.has_dispatcher end

				-- Perform call
			print ("%N-- Performing Call --%N")
			print ("Calling math.sum:%N%N")
			l_response := request_handler.response_string (sum_request_xml, dispatcher)
			print (l_response)
			print ("%N-- Done --%N")
		end

feature {NONE} -- Constants

	sum_request_xml: STRING =
"[
<?xml version="1.0"?>
<methodCall>
  <methodName>math.string_sum</methodName>
  <params>
    <param>
      <value><string>200</string></value>
    </param>
    <param>
      <value><string>33</string></value>
    </param>
  </params>
</methodCall>
]"

end
