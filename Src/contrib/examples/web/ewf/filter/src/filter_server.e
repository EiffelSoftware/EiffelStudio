note
	description : "Filter example."
	author      : "Olivier Ligot"
	date        : "$Date$"
	revision    : "$Revision$"

class
	FILTER_SERVER

inherit
	ANY

	WSF_HANDLER_HELPER

	WSF_DEFAULT_SERVICE

	WSF_ROUTED_SERVICE
		rename
			execute as execute_router
		end

	WSF_FILTERED_SERVICE

	WSF_FILTER
		rename
			execute as execute_router
		end

	SHARED_EJSON

create
	make

feature {NONE} -- Initialization

	make
		local
			l_message: STRING
			l_factory: INET_ADDRESS_FACTORY
		do
			initialize_router
			initialize_filter
			initialize_json
			set_service_option ("port", port)
			create l_message.make_empty
			l_message.append_string ("Launching filter server at ")
			create l_factory
			l_message.append_string (l_factory.create_localhost.host_name)
			l_message.append_string (" port ")
			l_message.append_integer (port)
			io.put_string (l_message)
			io.put_new_line
			make_and_launch
		end

	create_filter
			-- Create `filter'
		do
			create {WSF_CORS_FILTER} filter
		end

	setup_filter
			-- Setup `filter'
		local
			l_logging_filter: WSF_LOGGING_FILTER
		do
			create l_logging_filter
			filter.set_next (l_logging_filter)
			l_logging_filter.set_next (Current)
		end

	setup_router
			-- Setup `router'
		local
			l_options_filter: WSF_CORS_OPTIONS_FILTER
			l_authentication_filter: AUTHENTICATION_FILTER
			l_user_filter: USER_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_options_filter.make (router)
			create l_authentication_filter
			create l_user_filter

			l_options_filter.set_next (l_authentication_filter)
			l_authentication_filter.set_next (l_user_filter)

			create l_methods
			l_methods.enable_options
			l_methods.enable_get
			router.handle_with_request_methods ("/user/{userid}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent l_options_filter.execute), l_methods)
		end

	initialize_json
			-- Initialize `json'.
		do
			json.add_converter (create {JSON_USER_CONVERTER}.make)
		end

feature {NONE} -- Implementation

	port: INTEGER = 9090
			-- Port number

note
	copyright: "2011-2013, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
