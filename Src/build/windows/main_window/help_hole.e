-- General help hole.
class HELP_HOLE 

inherit

	EDIT_BUTTON
		redefine
			process_any
		end

creation

	make

feature {NONE}

	focus_string: STRING is 
		do
			Result := Focus_labels.help_label
		end;

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
