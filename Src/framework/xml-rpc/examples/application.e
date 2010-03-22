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
			l_o, l_o2: TEST_OBJECT
			l_struct: XRPC_STRUCT
			l_proxy: XRPC_PROXY
			l_args: ARRAY [STRING]
			l_response: detachable XRPC_RESPONSE
		do
			create l_struct.make
			create l_o.make_test
			l_o.encode_to_struct (l_struct)

			create l_o2.make_from_struct (l_struct)

			create l_proxy.make ("ws2.webservices.nl/xmlrpc/UTF-8")
			create l_args.make_filled ("addressReeksPostcodeSearch", 1, 1)
			l_response := l_proxy.call ("system.methodHelp", l_args)
		end

end
