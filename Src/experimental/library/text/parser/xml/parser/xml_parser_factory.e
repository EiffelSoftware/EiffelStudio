note
	description : "[
				Factory to create new XML_PARSER
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_PARSER_FACTORY

inherit
	XML_PARSER_FACTORY_I

feature -- Status report

	is_parser_available: BOOLEAN = True
			-- Is XML parser available?

feature -- Access

	new_parser: XML_PARSER
			-- New XML parser
		do
			Result := new_standard_parser
		end

	new_standard_parser: XML_STANDARD_PARSER
			-- New XML parser
		do
			create Result.make
		end

	new_stoppable_parser: XML_STOPPABLE_PARSER
			-- New stoppable XML parser
		do
			create Result.make
		end

	new_custom_parser: XML_CUSTOM_PARSER
			-- New custom XML parser
		do
			create Result.make
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
