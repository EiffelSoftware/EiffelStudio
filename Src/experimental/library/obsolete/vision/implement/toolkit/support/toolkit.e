note

	description: "Implementation toolkit"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

	iterate
			-- Loop the application.
		deferred
		end;

	exit
			-- Exit from the application
		deferred
		end;
	
feature -- Access
	
	set_global_cursor (a_cursor: SCREEN_CURSOR)
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
	
	global_cursor: SCREEN_CURSOR
			-- Global cursor for the whole application.
			-- Void if no global cursor has been defined
			-- with `set_global_cursor'.
		deferred
		end;

	name: STRING
			-- Toolkit implementation name
		deferred
		end
	
	restore_cursors
			-- Restore the cursors as they were before `set_global_cursor'.
		deferred
		ensure
			no_global_cursor_anymore: (global_cursor = Void)
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TOOLKIT

