

class GROUP_ICON_STONE 

inherit

	ICON_STONE
		rename
			identifier as oui_identifier,
			make_visible as icon_make_visible
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

	TYPE_STONE
		;

	REMOVABLE



	
feature 

	remove_yourself is
		local
			cut_command: CUT_GROUP_CMD
		do
			!!cut_command;
			cut_command.execute (original_stone)
		end;

	make_visible (a_parent: COMPOSITE) is
		do
			icon_make_visible (a_parent);
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
