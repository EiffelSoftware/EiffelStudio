-- Set execution format.

deferred class
	
	EXEC_FORMAT

inherit

	FORMATTER
		redefine
			format
		end;
	SHARED_DEBUG;
	EXEC_MODES

feature

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

	format (stone: STONE) is
		do
			Run_info.set_execution_mode (execution_mode);
			text_window.set_last_format (Current)
		end;

feature {NONE}

	execution_mode: INTEGER is deferred end;

	display_info (i: INTEGER; s: STONE) is do end;
			-- Useless here.

	title_part: STRING is do Result := "" end;

end -- class EXEC_FORMAT
