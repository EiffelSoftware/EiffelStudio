
class APP_RETURN_H 

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
			Result := Pixmaps.return_pixmap
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.return_label)
		end;
	
feature {NONE}

	stone_type: INTEGER is
		do
			Result := Stone_types.label_type
		end;

	process_label (dropped: LABEL_STONE) is
			-- Set the return transition to the dropped stone. 
		local
			set_return_command: APP_SET_RETURN;
		do
			!!set_return_command;
			set_return_command.execute (dropped.data.label);
		end;

end 
