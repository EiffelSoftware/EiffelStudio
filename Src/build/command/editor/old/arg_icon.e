
class ARG_ICON 

inherit

	ARG_STONE
		export
			{NONE} all
		end;

	ICON_STONE
		rename
			make_visible as make_icon_visible,
			make as make_icon,
			identifier as oui_identifier
		undefine
			stone_cursor
		redefine
			original_stone
		end;

	ICON_STONE
		rename
			make as make_icon,
			identifier as oui_identifier
		undefine
			stone_cursor
		redefine
			make_visible, original_stone
		select
			make_visible
		end;

	REMOVABLE


creation

	make

	
feature {NONE}

	cmd_editor: CMD_EDITOR;

	
feature 

	make (ed: CMD_EDITOR) is
		do
			cmd_editor := ed
		end;

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			initialize_transport;
		end;

	remove_yourself is
		do
			cmd_editor.remove_argument (original_stone)
		end;

-- **************
-- Stone features
-- **************

	original_stone: ARG;

	
feature {NONE}

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

	type: CONTEXT_TYPE is
		do
			Result := original_stone.type
		end;

end
