
class ICON_STONE 

inherit

	ICON
		rename
			button as source,
			same as oui_same
		export
			{ANY} managed
		end;

feature 

	original_stone: STONE_PARENT;
			-- Canonical representative of 
			-- current stone.
			-- For copy and multiple references 
			-- purposes.

	set_original_stone (s: like original_stone) is
		local
			p: WIDGET
		do
			p := parent;
			original_stone := s.original_stone;
			if label = Void or else 
				label.empty or else 
				s.label.count >= label.count 
			then
				p.set_managed (False);
			end;
			set_label (s.label);
			set_symbol (s.symbol);
			if not p.managed then
				p.set_managed (True);
			end;
		end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with 
			-- current stone during transport.
		do
			Result := original_stone.stone_cursor
		end;
	
feature {NONE}

	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent)
		end;

end
