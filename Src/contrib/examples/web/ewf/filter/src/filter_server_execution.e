note
	description : "Filter example."
	author      : "Olivier Ligot"
	date        : "$Date$"
	revision    : "$Revision$"

class
	FILTER_SERVER_EXECUTION

inherit
	WSF_FILTERED_ROUTED_EXECUTION
		redefine
			initialize
		end

	SHARED_EJSON

create
	make

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			initialize_json
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
			router.handle ("/user/{userid}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent l_options_filter.execute), l_methods)
		end

	initialize_json
			-- Initialize `json'.
		once
				-- See SHARED_EJSON, and the once function per thread `json'.
			json.add_converter (create {JSON_USER_CONVERTER}.make)
		end

note
	copyright: "2011-2015, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
