note
	description: "Summary description for {XML_SHARED_UTILITIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_SHARED_UTILITIES

feature -- Access

	xml_utilities: XML_UTILITIES
			-- Shared utilities related to XML formatting/encoding/escaping.
		once
			create Result
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
