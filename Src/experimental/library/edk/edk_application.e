indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EDK_APPLICATION

create {EDK_APPLICATION_SERVER}
	make_with_default_namespace

feature {NONE} -- Initialization

	make_with_default_namespace (a_namespace: STRING_8)
			-- Create application object using `a_namespace' for default namespace.
		do
			default_namespace := a_namespace
			create display_cell.put (Void)
			display_cell.put (create {EDK_DISPLAY_DESKTOP}.make_for_application (Current))
		end

feature -- Access

	default_namespace: IMMUTABLE_STRING_8
		-- Default namespace of `Current' application object.
		-- Used as a prefix for creating differentiating multiple application objects at run-time

	display: EDK_DISPLAY
			-- Return the display used for displaying Windows.
		local
			l_result: detachable EDK_DISPLAY
		do
			l_result := display_cell.item
			check l_result /= Void end
			Result := l_result
		end

feature {NONE} -- Implementation

	display_cell: CELL [detachable EDK_DISPLAY]
		-- Place holder for cell.

end
