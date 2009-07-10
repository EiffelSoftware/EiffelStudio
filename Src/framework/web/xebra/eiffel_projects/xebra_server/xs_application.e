note
	description: "[
		Xebra Server run class
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_APPLICATION

inherit
	ARGUMENTS
	XU_STOPWATCH

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_server: XS_MAIN_SERVER
			l_arg_parser: XS_ARGUMENT_PARSER
			l_common_classes: XC_CLASSES
		do
			create l_common_classes.make
			create l_arg_parser.make
			create l_server.make
			l_arg_parser.execute (agent l_server.setup (l_arg_parser))
--			
--			start_time
--			test_request.do_nothing
--			print (stop_time)

		end

	test_request: detachable XH_REQUEST
		local
			l_request_factory: XH_REQUEST_PARSER
		do
				create l_request_factory.make
				Result := l_request_factory.request ("GET /helloworld/ HTTP/1.1#HI##$#Host#%%#localhost:55000#$#User-Agent#%%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#$#Accept-Language#%%#en-us,en;q=0.5#$#Accept-Encoding#%%#gzip,deflate#$#Accept-Charset#%%#ISO-8859-1,utf-8;q=0.7,*;q=0.7#$#Keep-Alive#%%#300#$#Connection#%%#keep-alive#$#Cookie#%%#xuuid=928DE016-61DD-47DC-8688-EEEE0417E567#E##HO##E##SE##E##A#&blibli=123&blabla=2343")
		end
end
