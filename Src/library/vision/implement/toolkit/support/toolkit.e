indexing

	description: "Implementation toolkit";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	TOOLKIT

inherit

	CURSOR_TYPE
		export
			{NONE} all
		end


feature -- Basic operations

	iterate is
			-- Loop the application.
		deferred
		end;

	exit is
			-- Exit from the application
		deferred
		end;
	
feature -- Access
	
	set_global_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set a global cursor for the whole application.
			-- Warning: the effect of calling `set_type' on a SCREEN_CURSOR
			-- or `set_cursor' on a WIDGET is not defined.
			-- It depends on the specific implementation.
		require
			a_cursor_exists: a_cursor /= Void
			no_global_cursor_already_set: (global_cursor = Void)
		deferred
		ensure
			correctly_set: global_cursor = a_cursor
		end;	
	
	global_cursor: SCREEN_CURSOR is
			-- Global cursor for the whole application.
			-- Void if no global cursor has been defined
			-- with `set_global_cursor'.
		deferred
		end;

	name: STRING is
			-- Toolkit implementation name
		deferred
		end
	
	restore_cursors is
			-- Restore the cursors as they were before `set_global_cursor'.
		deferred
		ensure
			no_global_cursor_anymore: (global_cursor = Void)
		end;

end -- class TOOLKIT

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

