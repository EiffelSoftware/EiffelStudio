
class COM_ICON_STONE 

inherit

	ICON_STONE
		undefine
			stone_cursor
		redefine
			original_stone, set_widget_default
		end;
	CMD_STONE
	
feature 

	set_widget_default is
		do
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
