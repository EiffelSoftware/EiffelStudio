--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Circular chains,
-- without commitment to a particular representation

indexing

	names: circular, ring, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class CIRCULAR [G] inherit

	CHAIN [G]
		undefine
			exhausted
		redefine
			valid_cursor_index
		end

feature -- Access

	exhausted: BOOLEAN is
			-- Are there no more items to be read?
		deferred
		end;

feature -- Cursor

	forth is
			-- Move to next item in `Current'.
		deferred
		ensure then
			not_off: not off
		end;

	back is
			-- Move to previous item in `Current'.
		deferred
		ensure then
			not_off: not off
		end;

feature -- Assertion check

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
		do
			Result := (i >= 0) and (i <= count)
		ensure then
			valid_cursor_index_definition: Result = (i >= 0) and (i <= count)
		end;

end -- class CIRCULAR
