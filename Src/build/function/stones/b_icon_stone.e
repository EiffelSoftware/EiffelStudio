

class B_ICON_STONE 

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
	BEHAVIOR_STONE
	
feature 

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
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
