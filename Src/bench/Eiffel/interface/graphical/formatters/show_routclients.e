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
			!!Result.make; 
			Result.read_from_file (bm_Showfs) 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showsenders end;

	title_part: STRING is do Result := l_Senders end;

	display_info (i: INTEGER; f: FEATURE_STONE)  is
			-- Display Senders of `c'.
		local
			cmd: EWB_SENDERS;
			class_c: CLASS_C;
			feature_i: FEATURE_I;
		do
			feature_i := f.feature_i;
			class_c := feature_i.written_class;
			!!cmd.make (class_c.class_name, feature_i.feature_name);
			cmd.display_senders (text_window, class_c, feature_i.feature_id);
		end;

end
