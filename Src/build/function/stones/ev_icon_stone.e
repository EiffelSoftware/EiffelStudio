

class EV_ICON_STONE 

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

	EVENT_STONE
		export
			{NONE} all
		end;

	EB_HASHABLE
		export
			{NONE} all
		end;
	
feature {NONE}

	same (other: like Current): BOOLEAN is
		do
			Result := not (other = Void) and then
				(label.is_equal (other.label))
		end;

	
feature 

	hash_code: INTEGER is
		do
			Result := label.hash_code
		end;

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			initialize_transport
		end;
			
	original_stone: EVENT;

	
feature {NONE}

	eiffel_text: STRING is
		do
			Result := original_stone.eiffel_text
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

end
