
class APP_EXIT_HOLE 

inherit

	APP_EDITOR_HOLE
		redefine
			process_label
		end

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

	stone_type: INTEGER is
		do
			Result := Stone_types.label_type
		end;
	
	process_label (dropped: LABEL_STONE) is
			-- Set exit label.
		local
			set_exit_command: APP_SET_EXIT;
		do
			!!set_exit_command;
			set_exit_command.execute (dropped.data.label)
		end; 

end 
