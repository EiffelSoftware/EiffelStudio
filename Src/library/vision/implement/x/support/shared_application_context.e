indexing

	description: 
		"Save the application context.";
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
			!! Result.put (Void)
		end

	application_context_cell: CELL [MEL_APPLICATION_CONTEXT] is
		once
			!! Result.put (Void)
		end;

end -- class SHARED_MEL_DISPLAY
