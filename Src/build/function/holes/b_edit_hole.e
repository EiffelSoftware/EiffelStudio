
class B_EDIT_HOLE 

inherit

	FUNC_EDIT_HOLE
		rename
			make as func_edit_make,
			button as source,
			identifier as oui_identifier,
			make_visible as make_icon_visible
		redefine
			process_stone, function_editor, stone,
			compatible
		end;

	FUNC_EDIT_HOLE
		rename
			make as func_edit_make,
			button as source,
			identifier as oui_identifier
		redefine
			process_stone, function_editor, make_visible, stone,
			compatible
		select
			make_visible
		end;

	BEHAVIOR_STONE
		export
			{NONE} all
		redefine
			transportable
		end;

	PIXMAPS
		export
			{NONE} all
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

	
feature 

	make (ed: BEHAVIOR_EDITOR) is
		do
			func_edit_make (ed);
		end;

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			set_symbol (Behavior_pixmap);
			initialize_transport
		end; -- make_visible

	-- ** Stone definitions ** --

	
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
