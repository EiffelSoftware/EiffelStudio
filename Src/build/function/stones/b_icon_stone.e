

class B_ICON_STONE 

inherit

	ICON_STONE
		undefine
			stone_cursor
		redefine
			original_stone, set_widget_default
		end;
	BEHAVIOR_STONE
	
feature 

	set_widget_default is
		do
			initialize_transport
		end;
			
	original_stone: BEHAVIOR;

	
feature {NONE}

	context: CONTEXT is
		do
			Result := original_stone.context
		end;

	labels: LINKED_LIST [CMD_LABEL] is
		do
			Result := original_stone.labels
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

end
