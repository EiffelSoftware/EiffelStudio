
class APP_EXIT_HOLE 

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
			Result := Pixmaps.exit_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.exit_label
		end;

feature {NONE}

	stone: LABEL_SCR_L;
			-- Transition list
	compatible (s: LABEL_SCR_L): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;
	
	process_stone is
			-- Set exit label.
		local
			set_exit_command: APP_SET_EXIT;
		do
			!!set_exit_command;
			set_exit_command.execute (stone.label)
		end; 

end 
