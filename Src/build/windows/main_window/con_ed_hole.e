class CON_ED_HOLE

inherit

	EDIT_BUTTON
		rename 
			make as parent_make
		redefine
			process_context
		end

creation

	make

feature {NONE}
	make (a_parent: COMPOSITE) is
		do
			parent_make (a_parent);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.context_pixmap
		end;

	create_focus_label is 
		do
			set_focus_string(Focus_labels.context_label)
		end;

	create_empty_editor is
		local
			editor: CONTEXT_EDITOR_TOP_SHELL
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
