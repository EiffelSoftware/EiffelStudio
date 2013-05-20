note
	description: "Summary description for WGI_CGI_ERROR_STREAM."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_CGI_ERROR_STREAM

inherit
	WGI_ERROR_STREAM

	CONSOLE
		rename
			make as console_make
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_open_stderr ("stderr")
		end

feature -- Error

	put_error (a_message: READABLE_STRING_8)
		do
			put_readable_string_8 (a_message)
		end

	put_readable_string_8 (s: READABLE_STRING_8)
			-- Write `s' at end of default output.
		local
			ext: C_STRING
		do
			if s.count > 0 then
				create ext.make (s)
				console_ps (file_pointer, ext.managed_data.item, s.count)
			end
		end

note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
