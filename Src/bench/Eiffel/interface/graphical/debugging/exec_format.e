-- Set execution format.

deferred class
	
	EXEC_FORMAT

inherit

	FORMATTER
		redefine
			format, execute, text_window
		end;
	SHARED_DEBUG;
	EXEC_MODES

feature

	make (c: COMPOSITE; a_text_window: PROJECT_TEXT) is
		do
			init (c, a_text_window);
			set_action ("<Btn3Down>", Current, Format_and_run)
		end;

	execute (argument: ANY) is
		do
			if argument /= get_in and argument /= get_out then
				warner.popdown
			end;
			if argument = get_in then
				text_window.tool.tell_type (command_name)
			elseif argument = get_out then
				text_window.tool.clean_type
			elseif license_problem then
				license_problem := False;
				if (argument = Void) then
					license_window.set_exclusive_grab;
					license_window.popup
				end
			elseif argument = update_symbol then
				text_window.set_last_format (Current);
				update_symbol.remove_action (Current, update_symbol)
			else
				format (Void);
				if argument = Format_and_run then
					text_window.tool.debug_run_command.execute (Void)
				end
			end
		end;

	format (stone: STONE) is
		do
			Run_info.set_execution_mode (execution_mode);
			update_symbol.add_action (Current, update_symbol)
		end;

	text_window: PROJECT_TEXT;

feature {NONE}

	Format_and_run: ANY is once !!Result end;

	execution_mode: INTEGER is deferred end;

	display_info (i: INTEGER; s: STONE) is do end;
			-- Useless here.

	title_part: STRING is do Result := "" end;

	update_symbol: TASK is
			-- This task prevents the exec format buttons to disappear
			-- and then reappear a few second later when one changes
			-- the format. (This problem occurred when change_and_running
			-- the step by step format because the X server was not able
			-- to redraw the format buttons before it had displayed the
			-- execution stack.)
		once
			!! Result.make
		end;

end -- class EXEC_FORMAT
