class CON_ED_HOLE

inherit

	EDIT_BUTTON
		redefine
			process_context
		end

creation

	make

feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.context_pixmap
		end;

	focus_string: STRING is 
		do
			Result := Focus_labels.context_label
		end;

	create_empty_editor is
		local
			editor: CONTEXT_EDITOR
		do
			editor := window_mgr.context_editor;
			window_mgr.display (editor)
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.context_type
		end;

	process_context (dropped: CONTEXT_STONE) is
		do
			dropped.data.create_editor
		end;
	
end
