note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HELLO_WORLD

inherit
	WGI_SERVICE

create
	make

feature {NONE} -- Initialization

	make
		do
			print ("Example: start a Nino web server on port " + port_number.out + ", %Nand reply Hello World for any request such as http://localhost:8123/%N")
			(create {NINO_SERVICE}.make_custom (Current, "")).listen (port_number)
		end

	execute (req: WGI_REQUEST; res: WGI_RESPONSE)
		do
			res.set_status_code (200, Void)
			res.put_header_text ("Content-Type: text/plain%R%N")
			res.put_string ("Hello World!%N")
		end

	port_number: INTEGER = 8123

note
	copyright: "2011-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
