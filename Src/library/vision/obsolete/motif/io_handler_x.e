indexing

	description:
		"A I/O handler manager. %
		%This class should be used to monitor I/O mechanism without interfering";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class IO_HANDLER_X 

inherit

	IO_HANDLER_I;

	EVENT_HDL

creation

	make
	
feature {NONE}

	argument: ANY;
				-- Argument to give to the command

	c_data: POINTER;
				-- Address of datas for C routines

	call_back is
			-- Call the command.
		require
			valid_command: command /= Void
		local
			command_clone: COMMAND;
			context_data: CONTEXT_DATA
		do
			if command.is_template then
				command_clone := clone (command)
			else
				command_clone := command
			end;
			command_clone.set_context_data (context_data);
			command_clone.execute (argument)
		end; 

	command: COMMAND;
			-- Command to call

	make (an_io_handler: IO_HANDLER; an_application_context: POINTER) is
					-- Create a openlook io_handler.
		require
			an_io_handler_exists: an_io_handler /= Void
		do
			c_data := c_io_create (an_application_context, 
						Current, $call_back);
			if false then
				call_back
			end
	   	end; 

feature 

	is_call_back_set: BOOLEAN is
			-- Is a call back already set ?
		do
			Result := c_io_is_call_back_set (c_data)
		end; 

	set_error_call_back (a_file: IO_MEDIUM; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when an operation
			-- on `a_file' had raised an I/O error.
			--| the behave of this routine should be examined when other
			--| error handlers are used (such as Eiffel exception mechanism).
		require else
			no_call_back_already_set: not is_call_back_set;
			not_a_command_void: not (a_command = Void)
		do
			c_io_set_error_call_back (c_data, a_file.handle);
			command := a_command;
			argument := an_argument
		ensure then
			is_call_back_set
		end; 

	set_no_call_back is
			-- Remove any call-back already set.
		require else
			a_call_back_must_be_set: is_call_back_set
		do
			c_io_set_no_call_back (c_data)
		ensure then
			not is_call_back_set
		end; 

	set_read_call_back (a_file: IO_MEDIUM; a_command: COMMAND; 
			an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_file' has
			-- data available.
		require else
			no_call_back_already_set: not is_call_back_set;
			not_a_command_void: a_command /= Void
		do
			c_io_set_read_call_back (c_data, a_file.handle);
			command := a_command;
			argument := an_argument
		ensure then
			is_call_back_set
		end;

	set_write_call_back (a_file: IO_MEDIUM; a_command: COMMAND; 
		an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_file' is
			-- available for writing.
		require else
			no_call_back_already_set: not is_call_back_set;
			not_a_command_void: a_command /= Void
		do
			c_io_set_write_call_back (c_data, a_file.handle);
			command := a_command;
			argument := an_argument
		ensure then
			is_call_back_set
		end

	destroy is
			-- Free `c_data' C structure.
		local
			null_pointer: POINTER
		do
			check
				not_freed: c_data /= null_pointer
			end;
			c_free_io (c_data);
			c_data := null_pointer;
		ensure then
			is_data_freed: is_data_freed
		end
		
	is_data_freed: BOOLEAN is
			-- Is `c_data' freed ?
		local
			null_pointer: POINTER
		do
			Result := null_pointer = c_data
		end;

feature {NONE} -- External features

	c_free_io (data: POINTER) is
		external
			"C"
		end;

	c_io_create (scr_obj: POINTER; obj: G_ANY_I; cb: POINTER): POINTER is
		external
			"C"
		end; 

	c_io_set_write_call_back (data: POINTER; file_descriptor: INTEGER) is
		external
			"C"
		end; 

	c_io_set_read_call_back (data: POINTER; file_descriptor: INTEGER) is
		external
			"C"
		end; 

	c_io_set_no_call_back (data: POINTER) is
		external
			"C"
		end;

	c_io_set_error_call_back (data: POINTER; file_descriptor: INTEGER) is
		external
			"C"
		end;

	c_io_is_call_back_set (data: POINTER): BOOLEAN is
		external
			"C"
		end;

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
