--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Cursors for linked lists

indexing

	names: linked_list_cursor, cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_LIST_CURSOR [G] inherit

	CURSOR

creation 
	
	make

feature {LINKED_LIST} -- Creation

	make (active_element: like active; aft, bef: BOOLEAN) is
			-- Create a cursor and set it up on `active_element'.
		do
			active := active_element;
			after := aft;
			before := bef
		end;

feature {LINKED_LIST} -- Representation

	active: LINKABLE [G];
			-- Current element in linked list

	after: BOOLEAN;
			-- Is `Current' after the end of the list?

	before: BOOLEAN;
			-- Is `Current' before the start of the list?

end -- class LINKED_LIST_CURSOR
