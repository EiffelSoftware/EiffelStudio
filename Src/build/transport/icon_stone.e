
class ICON_STONE 

inherit

	ICON
		rename
			button as source,
			same as oui_same
		end;

feature 

	original_stone: STONE_PARENT;
			-- Canonical representative of 
			-- current stone.
			-- For copy and multiple references 
			-- purposes.

	set_original_stone (s: like original_stone) is
		do
			original_stone := s.original_stone;
			set_label (s.label);
			set_symbol (s.symbol);
		end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with 
			-- current stone during transport.
		do
			Result := original_stone.stone_cursor
		end;
	
end
