
class APP_LINE_HOLE 

inherit

	APP_EDITOR_HOLE
        rename
            make as parent_make
		redefine
			process_transition
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
			set_focus_string (Focus_labels.transition_line_label)
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.transition_line_pixmap
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.transition_type
		end;

	process_transition (dropped: TRANS_STONE) is
		do
			dropped.data.create_editor
		end; 

end 
