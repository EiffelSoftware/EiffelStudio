class CASE_STORAGE 

inherit

	ICONED_COMMAND
		redefine
			text_window
		end;

creation

	make
	
feature 

	text_window: SYSTEM_TEXT;

	make (c: COMPOSITE; a_text_window: SYSTEM_TEXT) is
			-- Initialize the format button  with its bitmap.
			-- Set up the mouse click and control-click actions
			-- (click requires a confirmation, control-click doesn't).
		do
			init (c, a_text_window);
			set_action ("!c<Btn1Down>", Current, control_click)
		end;

feature {NONE}

	control_click: ANY is once !!Result end;
			-- No confirmation required

	work (argument: ANY) is
		local
			format_storage: FORMAT_CASE_STORAGE
		do
			if 
				argument = control_click or
				(last_confirmer /= Void and argument = last_confirmer)
			then
				set_global_cursor (watch_cursor);
				!! format_storage;
				format_storage.execute;
				restore_cursors
			else
				confirmer (text_window).call (Current,
					"This command requires exploring the entire%N%
					%system and may take a long time...",
					"Continue")
			end
		end;
	
feature {NONE}

	symbol: PIXMAP is 
		once 
			Result := bm_Case_storage 
		end;
 
	command_name: STRING is do Result := l_Case_storage end;

end -- class CASE_STORAGE
