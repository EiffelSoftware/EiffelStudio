
indexing
	status: "See notice at end of class"

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
				after or else item.name_item.is_equal(a_name)
			loop
				forth
			end;
			if not after then
				remove 
			end;
		end;

	remove_item_token (a_token: INTEGER) is
		do
			from
				start
			until
				after or else (item.token_item = a_token)
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
				after or else item.name_item.is_equal (a_name)
			loop
				forth
			end;
			if not after then
				Result := item.token_item;
			end;
		end;

	item_position (a_token: INTEGER): INTEGER is
		do
			from
				start
			until
				after or else (item.token_item = a_token)
			loop
				forth
			end;
			if item.token_item = a_token then
				Result := position
			end;
		end;

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
