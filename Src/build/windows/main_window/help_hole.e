-- General help hole.
class HELP_HOLE 

inherit

	EDIT_BUTTON
		rename
			make as parent_make
		redefine
			process_any
		end

creation

	make

feature {NONE}

	make (a_parent: COMPOSITE) is
        do
            parent_make (a_parent)
            set_focus_string (Focus_labels.help_label)
        end


-- samik	focus_string: STRING is 
-- samik		do
-- samik			Result := Focus_labels.help_label
-- samik		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.help_pixmap
		end;
	
feature {NONE}

	stone_type: INTEGER is
		do
			Result := Stone_types.any_type
		end;

	process_any (dropped: STONE) is
		local
			hw: HELP_WINDOW
		do
			!! hw.make (eb_screen);
			hw.update_text (dropped.data);
			hw.realize
		end;

	create_empty_editor is
		local
			hw: HELP_WINDOW
		do
			!! hw.make (eb_screen);
			hw.realize;
		end;	

end
