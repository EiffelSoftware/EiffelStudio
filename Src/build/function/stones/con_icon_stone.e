

class CON_ICON_STONE 

inherit

	ICON_STONE
		export
			{ANY} realized
		undefine
			stone_cursor
		redefine
			original_stone, set_widget_default
		end;
	CONTEXT_STONE
	
feature 

	set_widget_default is
		do
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
