
class APP_SELF_HOLE 

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

	create_focus_label is
		do
			set_focus_string (Focus_labels.self_label)
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.self_label_pixmap
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.label_type
		end;

	process_label (dropped: LABEL_STONE) is
			-- Update the transition to self. 
		local
			cut_label_command: APP_CUT_LABEL;
		do
			!!cut_label_command;
			cut_label_command.execute (dropped.data.label)
		end; 

end 
