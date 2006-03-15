indexing
	description:
		"This class represents a MS_WINDOWS io handler. %
		%It is actually based on DDE and the references to files %
		%are ignored"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	IO_HANDLER_WINDOWS

inherit
	EVENT_HDL

	IO_HANDLER_I

create
	make

feature -- Initialization

	make (an_io_handler: IO_HANDLER) is
		do
		end

feature

	call_back is
			-- Call the command.
		local
                      command_clone: COMMAND
                      context_data: CONTEXT_DATA
              do
                      if not (command = Void) then
                              if command.is_template then
                                      command_clone := command.twin
                              else
                                      command_clone := command
                              end
                              command_clone.set_context_data (context_data)
                              command_clone.execute (argument)
                      end
		end

	command: COMMAND
			-- Command to call

	argument: ANY
			-- Argument to be passed

	destroy is
		do
			command := Void
			argument := Void
		end

	window: POINTER
			-- Window handler is attached to.

	is_call_back_set: BOOLEAN is
			-- Is a call back already set ?
		do
			Result := command /= Void
		end

	set_error_call_back (a_file: IO_MEDIUM; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when an operation
			-- on `a_file' had raised an I/O error.
			--| the behave of this routine should be examined when other
			--| error handlers are used (such as Eiffel exception mechanism).
		do
		end

	set_no_call_back is
			-- Remove any call-back already set.
		do
			command := Void
		end

	set_read_call_back (a_file: IO_MEDIUM; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_file' has
			-- data available.
		do
			command := a_command
			argument := an_argument
		end

	set_write_call_back (a_file: IO_MEDIUM; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_file' is
			-- available for writing.
		do
		end

feature {NONE} -- Implmentation

	win_ioh_make_client (cb: POINTER; obj: IO_HANDLER_WINDOWS): POINTER is
			-- Make the io handler function
		external
			"C"
		end

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




end -- class IO_HANDLER_WINDOWS

