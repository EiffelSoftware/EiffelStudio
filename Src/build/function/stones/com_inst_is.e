

class COM_INST_IS 

inherit

	ICON_STONE
		rename
			identifier as oui_identifier,
			make_visible as make_icon_visible
		undefine
			stone_cursor
		redefine
			original_stone
		end;
	ICON_STONE
		rename
			identifier as oui_identifier
		undefine
			stone_cursor
		redefine
			make_visible, original_stone
		select
			make_visible
		end;
	CMD_INST_STONE;

feature 

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			initialize_transport
		end;
			
	original_stone: CMD_INSTANCE;

	arguments: LINKED_LIST [ARG_INSTANCE] is
		do
			Result := original_stone.arguments
		end;

	associated_command: CMD is
		do
			Result := original_stone.associated_command
		end

end
