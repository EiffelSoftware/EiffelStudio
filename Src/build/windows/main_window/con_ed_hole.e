class CON_ED_HOLE

inherit

	EDIT_BUTTON

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
	
end
