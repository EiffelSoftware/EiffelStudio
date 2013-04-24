note
	description: "Callbacks to build the associated XML_DOCUMENT, conforming to CALLBACKS_FILTER ... without really implementing it"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CALLBACKS_TREE

obsolete
	"[2011-02-09] Use rather XML_CALLBACKS_*_DOCUMENT classes"

inherit
	XML_CALLBACKS_NULL_FILTER_DOCUMENT

create
	make_null

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
