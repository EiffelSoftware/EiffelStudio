class STATE_ED_HOLE

inherit

	EDIT_BUTTON
		redefine
			process_state
		end

creation

	make

feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.state_pixmap
		end;

	focus_string: STRING is 
		do
			Result := Focus_labels.state_label
		end;

	create_empty_editor is
		local
			editor: STATE_EDITOR
		do
			editor := Window_mgr.state_editor;
			window_mgr.display (editor)
		end;

	stone_type: INTEGER is
		do
			Result := stone_types.state_type
		end;

	process_state (dropped: STATE_STONE) is
		do
			dropped.data.create_editor
		end
	
end
