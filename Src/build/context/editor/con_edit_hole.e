class CON_EDIT_HOLE 

inherit

	EB_BUTTON;
	HOLE
		redefine
			stone, compatible
		end
	CONTEXT_STONE
		redefine
			transportable
		end
	
creation
	make
	
feature {NONE}

	associated_editor: CONTEXT_EDITOR;

	target: WIDGET is
		do
			Result := Current
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end

	entity_name: STRING is
		do
			Result := original_stone.entity_name
		end

	eiffel_text: STRING is
		do
			Result := original_stone.entity_name
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := associated_editor.focus_label
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.context_label
		end;

feature 

	original_stone: CONTEXT is
		do
			Result := associated_editor.edited_context
		end;
	
	source: WIDGET is
		do
			Result := Current
		end;

	context_label: STRING is
		do
			Result := original_stone.label
		end;

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void
		end;

	stone: CONTEXT_STONE

	compatible (s: CONTEXT_STONE): BOOLEAN is
		do
			stone ?= s
			Result := stone /= Void
		end

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

	label: STRING is
		do
			Result := original_stone.label
		end;

feature {NONE}

	process_stone is
			-- Set the new edited context
		do
			associated_editor.set_edited_context (stone.original_stone)
		end

end
