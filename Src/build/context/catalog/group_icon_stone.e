

class GROUP_ICON_STONE 

inherit

	ICON_STONE
		undefine
			stone_cursor
		redefine
			original_stone, set_widget_default
		end;
	TYPE_STONE;
	REMOVABLE
	
feature 

	remove_yourself is
		local
			cut_command: CUT_GROUP_CMD
		do
			!!cut_command;
			cut_command.execute (original_stone)
		end;

	set_widget_default is
		do
			initialize_transport;
		end;
			
	original_stone: CONTEXT_GROUP_TYPE;

	identifier: INTEGER is
		do
			Result := original_stone.group.identifier
		end;

	eiffel_type: STRING is
		do
			Result := original_stone.group.entity_name
		end;

end
