
class ARG_ICON 

inherit

	ARG_STONE
		export
			{NONE} all
		end;
	ICON_STONE
		undefine
			stone_cursor
		redefine
			original_stone, set_widget_default
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

	set_widget_default is
		do
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
