
deferred class FOCUSABLE  
	
feature {NONE}

	focus_source: WIDGET is
			-- Widget representing
			-- Current on the screen
		deferred
		end;	

	focus_label: LABEL is
			-- Label onto which the focus
			-- string of Current is to be 
			-- displayed
		deferred
		end;

	focus_string: STRING is
			-- String to be associated
			-- with Current when it is
			-- in focus
		deferred
		end;

	initialize_focus is
			-- Add the focusable behavior to Current.
		local
			Nothing: FOCUSABLE
		do
			focus_source.add_enter_action (focus_command, Current);
			focus_source.add_leave_action (focus_command, Nothing);
		end;

	focus_command: FOCUS_COMMAND is
			-- Actual EiffelVision command.
		once
			!!Result
		end;
	
feature 

	valid_focus_string: BOOLEAN is
		do
			Result := focus_string /= Void;
		end;

	set_focus is
			-- Display focus string of Current.
		require
			Non_void_focus_string: valid_focus_string;
		do
			focus_label.set_text (focus_string);
		end;

	reset_focus is
			-- Erase focus string of Current.
		do
			focus_label.set_text ("");
		end;
end
