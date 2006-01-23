indexing

	description: 
		"Save the application context."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SHARED_APPLICATION_CONTEXT

feature -- Access

	application_context: MEL_APPLICATION_CONTEXT is
			-- Application context
		do
			Result := application_context_cell.item
		end;

	application_class: STRING is
			-- Application class name used for resources.
		do
			Result := application_class_cell.item
		end

feature {NONE} -- Implementation

	application_class_cell: CELL [STRING] is
		once
			create Result.put (Void)
		end

	application_context_cell: CELL [MEL_APPLICATION_CONTEXT] is
		once
			create Result.put (Void)
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SHARED_MEL_DISPLAY


