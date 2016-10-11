note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HELLO_WORLD

create
	make

feature {NONE} -- Initialization

	make
		do
			print ("Example: start a Standalone web server on port " + port_number.out + ", %Nand reply Hello World for any request such as http://localhost:8123/%N")
			(create {WGI_STANDALONE_CONNECTOR [HELLO_WORLD_EXECUTION]}.make_with_base ("")).launch_on_port (port_number)
		end

	port_number: INTEGER = 8123

note
	copyright: "2011-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
