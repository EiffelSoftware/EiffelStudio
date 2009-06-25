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
			l_request_factory: XH_REQUEST_FACTORY
			l_uri_webapp_name: STRING
		do


			create l_request_factory.make
	        if attached {XH_REQUEST} l_request_factory.get_request (a_request_message) as l_request then
				l_uri_webapp_name := l_request.target_uri.substring (2, l_request.target_uri.index_of ('/', 2))
				l_uri_webapp_name.remove_tail (1)

				if attached {XS_WEBAPP} config.file.webapps[l_uri_webapp_name] as webapp then
					--webapp.set_request_message (a_request_message)
					webapp.set_current_request (create {XCWC_HTTP_REQUEST}.make_with_request (l_request))
					Result := webapp.start_action_chain

				else
					Result := (create {XER_CANNOT_FIND_APP}.make ("")).render_to_command_response
				end
            else
            	Result := (create {XER_CANNOT_DECODE}.make ("")).render_to_command_response
            end
		end
end
