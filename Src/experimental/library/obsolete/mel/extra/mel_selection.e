note

	description:
		"MEL Implementation of string data being sent between application.%
		%The selection within MEL only supports string information being %
		%passed from one application to another. This class only supports %
		%XA_PRIMARY selection. All command callbacks are set to Void after they %
		%have been invoked."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION

inherit

	SHARED_MEL_DISPATCHER
		export
			{NONE} all
		end

create
	make_own_selection, 
	make_get_selection_value

feature {NONE} -- Initialization

	make_own_selection (a_widget: MEL_WIDGET; 
				target_atom: MEL_ATOM;
				time: INTEGER;
				a_string: STRING;
				lose_cmd: MEL_COMMAND; lose_arg: ANY;
				done_cmd: MEL_COMMAND; done_arg: ANY)
			-- Initialize Current to initiate the sending of data 
			-- through the selection mechanism.
			-- `time' specifies the the selection should commence (should
			-- be taken the MEL_EVENT class).
			-- `target_atom' indicates the data representation (usually
			-- you use the `make_string' from MEL_ATOM to identify a STRING atom).
			-- It can be used to represent you're own representation of the 
			-- data.
			-- `a_string' is the data that is being claimed for selection.
			-- `lose_cmd' will be invoked when another widget successfully
			-- claims the selection. `lose_arg' will be passed to `lose_cmd' 
			-- whenever it is invoked as a callback.

			-- `done_cmd' will be invoked when the transfer is complete.
		require
			valid_widget: a_widget /= Void and then not a_widget.is_destroyed;
			time_not_zero: time /= 0;
			valid_atom: target_atom /= Void and then target_atom.is_valid
		local
			lose_cmd_exec, done_cmd_exec: MEL_COMMAND_EXEC
		do
			if lose_cmd /= Void then
				create lose_cmd_exec.make (lose_cmd, lose_arg);
			end;
			if done_cmd /= Void then
				create done_cmd_exec.make (done_cmd, done_arg);
			end;
			Mel_dispatcher.make_own_selection (a_widget,
				target_atom, time, a_string, lose_cmd_exec, done_cmd_exec)
		ensure
			commands_set: lose_cmd /= Void implies 
						(lose_command.command = lose_cmd and then
						lose_command.argument = lose_arg) and then
					done_cmd /= Void implies 
						(done_command.command = done_cmd and then
						done_command.argument = done_arg)
		end;

	make_get_selection_value (a_widget: MEL_WIDGET;
				target_atom: MEL_ATOM;
				time: INTEGER;
				requestor_cmd: MEL_COMMAND)
			-- Initialize Current to obtain data though the 
			-- selection mechanism.
			-- `time' specifies the the selection should commence (should
			-- be taken the MEL_EVENT class).
			-- `target_atom' indicates the data representation that the user
			-- wishes to receive.
			-- `requestor_cmd' will be invoked with the data transferred (data
			-- is of type of STRING and is passed as an argument to the
			-- `execute' routine).
		require
			valid_widget: a_widget /= Void and then not a_widget.is_destroyed
			time_not_zero: time /= 0;
			valid_atom: target_atom /= Void and then target_atom.is_valid
		local
			cmd_exec: MEL_COMMAND_EXEC
		do
			if requestor_cmd /= Void then
				create cmd_exec.make (requestor_cmd, Void)
			end;
			Mel_dispatcher.make_get_selection_value (a_widget,
				target_atom, time, cmd_exec)
		ensure
			command_set: requestor_cmd = requestor_command.command
		end;

feature -- Access

	lose_command: MEL_COMMAND_EXEC
			-- Lose selection command
		do
			Result := Mel_dispatcher.lose_command
		end;

	done_command: MEL_COMMAND_EXEC
			-- Done selection command
		do
			Result := Mel_dispatcher.done_command
		end;

	requestor_command: MEL_COMMAND_EXEC
			-- Requestor command
		do
			Result := Mel_dispatcher.requestor_command
		end

feature -- Element change

	disown_selection (a_widget: MEL_WIDGET; time: INTEGER)
			-- Make the selection data no longer available.
		require
			valid_widget: a_widget /= Void and then not a_widget.is_destroyed
		local
			atom: MEL_ATOM
		do
			create atom.make_primary;
			xt_disown_selection (a_widget.screen_object, atom.identifier, time)
		end;

feature {NONE} -- External

	xt_disown_selection (a_widget, an_atom: POINTER; time: INTEGER)
		external
			"C (Widget, Atom, Time) | <X11/Intrinsic.h>"
		alias
			"XtDisownSelection"
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




end -- class MEL_SELECTION


