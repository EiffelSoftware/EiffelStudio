note
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_APPLICATION_SERVER

feature

	application_from_namespace (a_namespace: STRING_8): EDK_APPLICATION
			-- Retrieve application with namespace `a_namespace'.
		local
			a: detachable EDK_APPLICATION
		do
				--| FIXME IEK Implement multiple application instance handling.
			a := application_cell.item
			if not attached a then
				create a.make_with_default_namespace (a_namespace)
				application_cell.put (a)
			end
			Result := a
		end

feature {NONE} -- Implementation

	application_cell: CELL [detachable EDK_APPLICATION]
		once ("PROCESS")
			create Result.put (Void)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
