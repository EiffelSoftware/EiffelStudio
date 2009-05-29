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
	XU_SHARED_OUTPUTTER

create
	make

feature {NONE} -- Initialization

	make (a_server_config: XS_CONFIG)
			-- Initialization for `Current'.
		require
			a_server_config_attached: a_server_config /= Void
		do
		--	create webapps_mutex.make
			server_config := a_server_config
		ensure
			server_config_set: server_config = a_server_config
		end

feature -- Constants


feature -- Access

	server_config: XS_CONFIG

feature -- Status Change

	stop_apps
			-- Terminates all process from webapps
		do
			from
				server_config.webapps.start
			until
				server_config.webapps.after
			loop
				server_config.webapps.item_for_iteration.shutdown_all
				server_config.webapps.forth
			end
		end

feature  -- Implementation


	forward_request_to_app (a_request_message: STRING): XH_RESPONSE
			--Sends a request to the correct webserver.
		require
			not_a_request_message_is_detached_or_empty: a_request_message /= Void and then not a_request_message.is_empty
		local
			l_request_factory: XH_REQUEST_FACTORY
			l_uri_webapp_name: STRING
		do
			create Result.make_empty
			create l_request_factory.make


            if attached {XH_REQUEST} l_request_factory.get_request (a_request_message) as l_request then
				l_uri_webapp_name := l_request.target_uri.substring (2, l_request.target_uri.index_of ('/', 2))
				l_uri_webapp_name.remove_tail (1)

				if attached {XS_WEBAPP} server_config.webapps[l_uri_webapp_name] as webapp then
					webapp.set_request_message (a_request_message)
					Result := webapp.start_action_chain
				else
					Result := (create {XER_CANNOT_FIND_APP}.make ("")).render_to_response
				end
            else
            	Result := (create {XER_CANNOT_DECODE}.make ("")).render_to_response
            end
		ensure
			Result_attached: Result /= Void
		end

invariant
	server_config_attached: server_config /= Void
end
