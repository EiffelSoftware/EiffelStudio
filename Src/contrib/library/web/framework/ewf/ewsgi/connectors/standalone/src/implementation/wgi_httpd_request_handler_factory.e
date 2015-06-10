note
	description: "Implementation of WGI request handler factory for WGI_STANDALOE_CONNECTOR."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_HTTPD_REQUEST_HANDLER_FACTORY [G -> WGI_EXECUTION create make end]

inherit
	HTTPD_REQUEST_HANDLER_FACTORY

feature -- Access

	connector: detachable separate WGI_STANDALONE_CONNECTOR [G]
			-- httpd solution.

feature -- Element change

	set_connector (conn: like connector)
			-- Set `connector' with `conn'.
		do
			connector := conn
		end

feature -- Factory

	new_handler: separate WGI_HTTPD_REQUEST_HANDLER [G]
		do
			create Result.make_with_connector (connector)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
