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


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

