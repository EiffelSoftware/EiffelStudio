class CON_EDIT_HOLE 

inherit

	EB_BUTTON		
	HOLE
    	redefine
			process_context
		select
			init_toolkit
		end
	CONTEXT_STONE;
	CONTEXT_DRAG_SOURCE
	
creation
	make
	
feature {NONE}

	associated_editor: CONTEXT_EDITOR;

	target: WIDGET is
		do
			Result := Current
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.context_label)
		end;

	data: CONTEXT is
		do
			Result := associated_editor.edited_context
		end;
	
	source: WIDGET is
		do
			Result := Current
		end;

	context_label: STRING is
		do
			Result := data.label
		end;

	make (ed: CONTEXT_EDITOR; a_parent: COMPOSITE) is
		require
			valid_ed: ed /= Void
		do
			associated_editor := ed;
			make_visible (a_parent);
			register;
			initialize_transport
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.context_pixmap
		end;

	full_symbol: PIXMAP is
		do
			Result := Pixmaps.context_dot_pixmap
		end;

feature {NONE}

	process_context (dropped: CONTEXT_STONE) is
			-- Set the new edited context
		do
			associated_editor.set_edited_context (dropped.data)
		end

feature

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_symbol (full_symbol)
			end
		end

end
