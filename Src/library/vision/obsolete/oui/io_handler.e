indexing

	description:
		"A I/O handler manager. %
		%This class should be used to monitor I/O mechanism without interfering %
		%with events mechanism (like scanning a UNIX pipe or socket)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class IO_HANDLER 

obsolete
	"This is only implemented in Motif.  Use add_input callbacks"

inherit

	G_ANY
		export
			{NONE} all
		end

creation

	make

feature 

	make is
			-- Create a io_handler.
		local
			ot: OBSOLETE_TOOLKIT
		do
			ot ?= toolkit;
			check
				obsolete_toolkit_instantiated: ot /= Void
			end;
			implementation := ot.io_handler (Current)
		end;

feature {NONE}

	implementation: IO_HANDLER_I;
			-- Implementation of io_handler

feature 

	is_call_back_set: BOOLEAN is
			-- Is a call back already set ?
		require
			exists: not destroyed
		do
			Result := implementation.is_call_back_set
		end;

	set_error_call_back (a_file: IO_MEDIUM; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when an operation
			-- on `a_file' had raised an I/O error.
			--| the behave of this routine should be examined when other
			--| error handlers are used (such as Eiffel exception mechanism).
		require
			exists: not destroyed;
			no_call_back_already_set: not is_call_back_set;
			not_a_command_void: not (a_command = Void)
		do
			implementation.set_error_call_back (a_file, a_command, an_argument)
		ensure
			is_call_back_set
		end;

	set_no_call_back is
			-- Remove any call-back already set.
		require
			exists: not destroyed;
			a_call_back_must_be_set: is_call_back_set
		do
			implementation.set_no_call_back
		ensure
			not is_call_back_set
		end;

	set_read_call_back (a_file: IO_MEDIUM; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_file' has
			-- data available.
		require
			exists: not destroyed;
			no_call_back_already_set: not is_call_back_set;
			not_a_command_void: not (a_command = Void)
		do
			implementation.set_read_call_back (a_file, a_command, an_argument)
		ensure
			is_call_back_set
		end;

	set_write_call_back (a_file: IO_MEDIUM; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_file' is
			-- available for writing.
		require
			exists: not destroyed;
			no_call_back_already_set: not is_call_back_set;
			not_a_command_void: not (a_command = Void)
		do
			implementation.set_write_call_back (a_file, a_command, an_argument)
		ensure
			is_call_back_set
		end;

	destroyed: BOOLEAN is
		do
			Result := implementation = Void
		end;

	destroy is
			-- Destroy Current.
		require
			exists: not destroyed
		do
			implementation.destroy;
			implementation := Void
		ensure
			destroyed: implementation = Void
		end

end


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

