
class B_EDIT_HOLE 

inherit

	FUNC_EDIT_HOLE
		redefine
			process_stone, function_editor, stone,
			compatible, set_widget_default
		end;
	BEHAVIOR_STONE
		export
			{NONE} all
		redefine
			transportable
		end;

creation

	make
	
feature {NONE}

	stone: BEHAVIOR_STONE;

	function_editor: BEHAVIOR_EDITOR;

	compatible (s: BEHAVIOR_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	set_widget_default is
		do
			initialize_transport
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.behavior_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.behaviour_label
		end;

	source: WIDGET is
		do
			Result := Current
		end;

	label: STRING is
		do
			Result := original_stone.label
		end;

feature {NONE}

	original_stone: BEHAVIOR;

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void;
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

	context: CONTEXT is
		do
			Result := original_stone.context
		end;

	labels: LINKED_LIST [CMD_LABEL] is
		do
			Result := original_stone.labels
		end;

	process_stone is
		do
			original_stone.merge (stone.original_stone)
		end;

	
feature 

	set_original_stone (b: BEHAVIOR) is
		do
			original_stone := b
		end;

end
