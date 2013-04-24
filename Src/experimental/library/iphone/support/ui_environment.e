note
	description: "Way to access the shared UI_APPLICATION object."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_ENVIRONMENT

feature -- Access

	application: detachable UI_APPLICATION
			-- Singleton for UI_APPLICATION
		do
			Result := application_cell.item
		end

feature {NONE} -- Implementation

	application_cell: CELL [detachable UI_APPLICATION]
			-- Shared application
		once
			create Result.put (Void)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
