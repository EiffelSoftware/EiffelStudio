
class NAMER_HOLE 

inherit

	EDIT_BUTTON
		rename
			make as button_make
		redefine
			process_any
		end

creation

	make

feature {NONE}

	focus_string: STRING is 
		do
			Result := Focus_labels.namer_label
		end;

	make (a_parent: COMPOSITE; l: FOCUS_LABEL) is
		require
			valid_a_parent: a_parent /= Void;
			valid_l: l /= Void
		do
			button_make (a_parent, l);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.namer_pixmap
		end;
	
feature {NONE}

	stone_type: INTEGER is
		do
			Result := Stone_types.any_type
		end;

	process_any (dropped: STONE) is
		local
			namer_cmd: RENAME_COMMAND
		do
			!! namer_cmd;
			namer_cmd.execute (dropped);
		end;

	create_empty_editor is
		do
		end;

end
