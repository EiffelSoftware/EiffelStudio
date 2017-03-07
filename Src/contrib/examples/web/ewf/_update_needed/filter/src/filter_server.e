note
	description : "Filter example."
	author      : "Olivier Ligot"
	date        : "$Date$"
	revision    : "$Revision$"

class
	FILTER_SERVER

inherit
	WSF_DEFAULT_SERVICE [FILTER_SERVER_EXECUTION]

create
	make

feature {NONE} -- Initialization

	make
		local
			l_message: STRING
			l_factory: INET_ADDRESS_FACTORY
		do
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

feature {NONE} -- Implementation

	port: INTEGER = 9090
			-- Port number

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
