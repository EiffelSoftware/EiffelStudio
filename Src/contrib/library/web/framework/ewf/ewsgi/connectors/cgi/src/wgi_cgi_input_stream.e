note
	description: "Input stream for CGI connector."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_CGI_INPUT_STREAM

inherit
	WGI_INPUT_STREAM
		undefine
			read_to_string
		end

	CONSOLE
		rename
			make as console_make,
			read_stream as read_string,
			end_of_file as end_of_input
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_open_stdin ("stdin")
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
