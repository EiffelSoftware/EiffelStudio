

class COM_INST_IS 

inherit

	ICON_STONE
		undefine
			stone_cursor
		redefine
			original_stone, set_widget_default
		end;
	CMD_INST_STONE;

feature 

	set_widget_default is
		do
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
