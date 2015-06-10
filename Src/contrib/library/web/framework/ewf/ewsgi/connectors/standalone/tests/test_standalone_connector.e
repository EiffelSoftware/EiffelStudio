note
	description: "[
			Testing+developping the standalone connector, no need to review.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STANDALONE_CONNECTOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			conn: WGI_STANDALONE_CONNECTOR [TEST_EXECUTION]
		do
			print ("Starting httpd server ...%N")

			create conn.make
			conn.on_launched_actions.extend (agent on_launched)
			conn.set_port_number (9090)
			conn.set_max_concurrent_connections (100)
			conn.launch
		end

	on_launched (conn: WGI_STANDALONE_CONNECTOR [WGI_EXECUTION])
		do
			print ("Server listening on port " + conn.port.out + "%N")
		end

	on_stopped (conn: WGI_STANDALONE_CONNECTOR [WGI_EXECUTION])
		do
			print ("Server terminated%N")
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
