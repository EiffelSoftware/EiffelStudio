
class APP_RETURN_H 

inherit

	APP_EDITOR_HOLE
		redefine
			stone, compatible
		end;
	LABELS

creation

	make
	
feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.return_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.return_label
		end;
	
feature {NONE}

	stone: LABEL_SCR_L;
			-- Stone that Current will accept.

	compatible (s: LABEL_SCR_L): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	process_stone is
			-- Set the return transition to the dropped stone. 
		local
			set_return_command: APP_SET_RETURN;
		do
			!!set_return_command;
			set_return_command.execute (stone.label);
		end;

end 
