note
	description: "[
			Knows how to handle webapps
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_HANDLER

inherit
	XS_SHARED_SERVER_CONFIG
	XS_SHARED_SERVER_OUTPUTTER

create
	make

feature {NONE} -- Initialization

	make
				-- Initialization for `Current'.
		do
		end

feature -- Constants

feature -- Access

feature -- Status Change

	stop_apps
			-- Terminates all process from webapps
		do
			from
				config.file.webapps.start
			until
				config.file.webapps.after
			loop
				config.file.webapps.item_for_iteration.shutdown_all
				config.file.webapps.forth
			end
		end

feature  -- Basic Operations

	request_message_to_response (a_request_message: STRING): XC_COMMAND_RESPONSE
			-- Does the stuff. I don't bother writing much here, it's going to change tomorrow anyway....
		local
			l_response: XH_RESPONSE
			l_request_factory: XH_REQUEST_PARSER
			l_uri_webapp_name: STRING
			l_req_buf: detachable XH_REQUEST
		do
			create l_request_factory.make
		--	l_req_buf := test_request
			l_req_buf := l_request_factory.request (a_request_message)
	        if attached {XH_REQUEST} l_req_buf as l_request then
				l_uri_webapp_name := l_request.uri.substring (2, l_request.uri.index_of ('/', 2))
				l_uri_webapp_name.remove_tail (1)

				if attached {XS_WEBAPP} config.file.webapps[l_uri_webapp_name] as webapp then
					Result := webapp.send (create {XCWC_HTTP_REQUEST}.make_with_request (l_request))
				else
					Result := (create {XER_CANNOT_FIND_APP}.make ("")).render_to_command_response
				end
            else
            	Result := (create {XER_CANNOT_DECODE}.make ("")).render_to_command_response
            end
		end

	test_request: detachable XH_REQUEST
		local
			l_request_factory: XH_REQUEST_PARSER
		once
				create l_request_factory.make
				Result := l_request_factory.request ("GET /helloworld/ HTTP/1.1#HI##$#Host#%%#localhost:55000#$#User-Agent#%%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.11) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#$#Accept-Language#%%#en-us,en;q=0.5#$#Accept-Encoding#%%#gzip,deflate#$#Accept-Charset#%%#ISO-8859-1,utf-8;q=0.7,*;q=0.7#$#Keep-Alive#%%#300#$#Connection#%%#keep-alive#$#Cookie#%%#xuuid=928DE016-61DD-47DC-8688-EEEE0417E567#E##HO##E##SE##E##A#")
		end
end
