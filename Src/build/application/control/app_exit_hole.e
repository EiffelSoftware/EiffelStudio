
class APP_EXIT_HOLE 

inherit

	APP_EDITOR_HOLE
        rename
            make as parent_make
		redefine
			process_label
		end

creation

	make

feature {NONE}

	make (a_parent: COMPOSITE) is
		do
			parent_make (a_parent)
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.exit_label_pixmap
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.exit_label)
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
