note
	description : "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_LITE_PARSER_FACTORY

inherit
	XML_PARSER_FACTORY

feature -- Status report

	is_parser_available: BOOLEAN = True
			-- Is XML parser available?

feature -- Access

	new_parser, new_lite_parser: XML_LITE_PARSER
			-- New XML parser
		do
			create Result.make
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
