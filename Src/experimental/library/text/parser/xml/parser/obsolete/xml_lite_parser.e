note
	description : "[
			Use XML_STANDARD_PARSER
		]"
	warning: "[
					<!DOCTYPE ..> is parsed but not used
					<!ENTITY ..> are not supported yet
			]"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"


class
	XML_LITE_PARSER

obsolete "Use {XML_STANDARD_PARSER} [2012-oct]"

inherit
	XML_STANDARD_PARSER

create
	make

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
