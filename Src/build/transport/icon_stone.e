
class ICON_STONE 

inherit

	DRAG_SOURCE;
	ICON
		rename
			button as source,
			same as oui_same
		end;

feature 

	data: DATA;
			-- Data to be transported.

	set_data (d: like data) is
		do
			data := d;
			set_label (data.label);
			set_symbol (data.symbol);
		end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with 
			-- current stone during transport.
		do
			Result := stone.stone_cursor
		end;

	stone: STONE is
			-- To be redefined
		do
		end;
	
end
