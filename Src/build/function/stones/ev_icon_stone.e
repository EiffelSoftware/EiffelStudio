

class EV_ICON_STONE 

inherit

	ICON_STONE
		undefine
			stone_cursor, stone
		redefine
			data, set_widget_default
		end;
	EVENT_STONE;
	EB_HASHABLE
	
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

	set_widget_default is
		do
			initialize_transport
		end;
			
	data: EVENT;

	
feature {NONE}

	eiffel_text: STRING is
		do
			Result := data.eiffel_text
		end;

	identifier: INTEGER is
		do
			Result := data.identifier
		end;

end
