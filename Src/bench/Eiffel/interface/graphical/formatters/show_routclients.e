-- Command to display the routines clients

class SHOW_ROUTCLIENTS

inherit

	FORMATTER;
	SHARED_SERVER

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showcallers 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showsenders end;

	title_part: STRING is do Result := l_Senders end;

	display_info (i: INTEGER; f: FEATURE_STONE)  is
			-- Display Senders of `c'.
		local
			cmd: EWB_SENDERS;
		do
			!!cmd.null;
			cmd.display_senders (text_window, f.class_c, f.feature_i);
		end;

end
