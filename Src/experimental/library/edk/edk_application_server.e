note
	description: "Summary description for {EDK_APPLICATION_SERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_APPLICATION_SERVER

feature

	application_from_namespace (a_namespace: STRING_8): EDK_APPLICATION
			-- Retrieve application with namespace `a_namespace'.
		local
			l_result: detachable EDK_APPLICATION
		do
				--| FIXME IEK Implement multiple application instance handling.
			if application_cell.item = Void then
				application_cell.put (create {EDK_APPLICATION}.make_with_default_namespace (a_namespace))
			end
			l_result := application_cell.item
			check l_result /= Void end
			Result := l_result
		end

feature {NONE} -- Implementation

	application_cell: CELL [detachable EDK_APPLICATION]
		note
			once_status: global
		once
			create Result.put (Void)
		end

end
