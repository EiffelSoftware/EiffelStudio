
class COM_ICON_STONE 

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
	CMD_STONE
	
feature 

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			initialize_transport
		end;
			
	original_stone: CMD;

	
feature {NONE}

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end;

	arguments: EB_LINKED_LIST [ARG] is
		do
			Result := original_stone.arguments
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		do
			Result := original_stone.labels
		end;

	eiffel_text: STRING is
		do
			Result := original_stone.eiffel_text
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

end
