note
	description: "[
			Knows how to handle webapps
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_HANDLER

inherit
	XS_SHARED_SERVER_CONFIG

	XS_SHARED_SERVER_OUTPUTTER

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

	forward_request (a_request_message: STRING): XC_COMMAND_RESPONSE
			-- Does the stuff. I don't bother writing much here, it's going to change tomorrow anyway....
		local
			l_response: XH_RESPONSE
			l_request_parser: XH_REQUEST_MINI_PARSER
			l_uri_webapp_name: STRING
			l_req_buf: detachable XH_MINI_REQUEST
		do
			create l_request_parser.make
			l_req_buf := l_request_parser.request (a_request_message)
	        if attached {XH_MINI_REQUEST} l_req_buf as l_request then
				if not l_request.post_too_big then
					if attached {XS_WEBAPP} config.file.webapps[l_request.webapp] as webapp then
						Result := webapp.send (create {XCWC_HTTP_REQUEST}.make_with_request (a_request_message))
					else
						Result := (create {XER_CANNOT_FIND_APP}.make ("")).render_to_command_response
					end
				else
					Result := (create {XER_POST_TOO_BIG}.make ("")).render_to_command_response
				end
            else
            	Result := (create {XER_CANNOT_DECODE}.make ("")).render_to_command_response
            end
		end
end
