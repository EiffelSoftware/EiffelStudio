--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class SCROLL_ITEM_L

inherit

	LINKED_LIST [SCROLL_ITEM]
		export
			{NONE} all
		end

creation

	make

feature 

	remove_item_name (a_name: STRING) is
		do
			from
				start
			until
				offright or else item.name_item.is_equal(a_name)
			loop
				forth
			end;
			if not offright then
				remove 
			end;
		end;

	remove_item_token (a_token: INTEGER) is
		do
			from
				start
			until
				offright or else (item.token_item = a_token)
			loop
				forth
			end;
			if item.token_item = a_token then
				remove
			end;
		end;

	add_scroll_item (a_token: INTEGER; a_name: STRING) is 
		local
			a_scroll_item: SCROLL_ITEM
		do
			!!a_scroll_item.make (a_token, a_name);
			add_right (a_scroll_item);
		end;

	item_name (a_token: INTEGER): STRING is
		do
			from
				start
			until
				after or else (item.token_item = a_token)
			loop
				forth
			end;
			if item.token_item = a_token then
				Result := item.name_item;
			end;
		end;

	item_token (a_name: STRING): INTEGER is
		do
			from
				start
			until
				offright or else item.name_item.is_equal (a_name)
			loop
				forth
			end;
			if not offright then
				Result := item.token_item;
			end;
		end;

	item_position (a_token: INTEGER): INTEGER is
		do
			from
				start
			until
				offright or else (item.token_item = a_token)
			loop
				forth
			end;
			if item.token_item = a_token then
				Result := position
			end;
		end;

end 
