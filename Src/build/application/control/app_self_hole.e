
class APP_SELF_HOLE 

inherit

	APP_EDITOR_HOLE
		redefine
			stone, compatible
		end;
	LABELS

creation

	make
	
feature {NONE}

	stone: LABEL_SCR_L;

	compatible (s: LABEL_SCR_L): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.self_label
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.self_label_pixmap
		end;

	process_stone is
			-- Update the transition to self. 
		local
			cut_label_command: APP_CUT_LABEL;
		do
			!!cut_label_command;
			cut_label_command.execute (stone.label)
		end; 

end 
