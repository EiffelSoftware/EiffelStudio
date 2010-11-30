note
	description: "Constants for BOM."
	date: "$Date$"
	revision: "$Revision$"

class
	BOM_CONSTANTS

feature -- Access

	bom_utf8: STRING
		once
			create Result.make (3)
			Result.append_code (0xEF)
			Result.append_code (0xBB)
			Result.append_code (0xBF)
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
