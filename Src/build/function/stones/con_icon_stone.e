

class CON_ICON_STONE 

inherit

	ICON_STONE
		rename
			identifier as oui_identifier,
			make_visible as make_icon_visible
		export
			{ANY} realized
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

	CONTEXT_STONE
		
		export
			{NONE} all
		end;
	
feature 

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			initialize_transport
		end;
			
	original_stone: CONTEXT;

	
feature {NONE}

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end;

	entity_name: STRING is
		do
			Result := original_stone.entity_name
		end;

	eiffel_text: STRING is
		do
			Result := original_stone.entity_name
		end;

end
