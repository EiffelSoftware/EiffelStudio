note
	description : "[
			Eiffel XML parser to replace Gobo's XM_EIFFEL_PARSER

		]"
	date: "$Date$"
	revision: "$Revision$"

class XM_EIFFEL_PARSER

inherit
	XML_CUSTOM_PARSER
		rename
			parse_from_stream as parse_from_xml_stream
		end

	XM_PARSER

create
	make

feature -- Access

	abort
			-- Abort parsing.
			-- Do not print error message.
		do
			request_stop
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
