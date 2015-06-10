note
	description: "Summary description for {HELLO_WORLD_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HELLO_WORLD_EXECUTION

inherit
	WGI_EXECUTION

create
	make

feature {NONE} -- Initialization

	execute
		do
			response.set_status_code (200, Void)
			response.put_header_text ("Content-Type: text/plain%R%N")
			response.put_string ("Hello World!%N")
		end

note
	copyright: "2011-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

