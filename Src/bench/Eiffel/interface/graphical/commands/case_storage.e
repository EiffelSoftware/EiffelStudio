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
		do
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
		local
			format_storage: FORMAT_CASE_STORAGE
		do
			set_global_cursor (watch_cursor);
			!! format_storage;
			format_storage.execute;
			restore_cursors
		end;
	
feature {NONE}

	symbol: PIXMAP is 
		once 
			Result := bm_Case_storage 
		end;
 
	command_name: STRING is do Result := l_Case_storage end;

end -- class CASE_STORAGE
