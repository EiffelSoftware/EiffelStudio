--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sequential lists,
-- without commitment to a particular representation

indexing

	names: list, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class LIST [G] inherit


	CHAIN [G]
		undefine
			search, off, search_equal
		end;

	LINEAR [G]
		undefine
			has, index_of
		end

feature -- Cursor

	after: BOOLEAN is
			-- Is there no position to the right of the cursor?
		do
			Result := index = (count + 1)
		end;

	before: BOOLEAN is
			-- Is there no position to the left of the cursor?
		do
			Result := index = 0
		end;

feature -- Obsolete features

	offleft: BOOLEAN is obsolete "Use ``before''"
		do
			Result := before or empty
		end;

	offright: BOOLEAN is obsolete "Use ``after''"
		do
			Result := after or empty
		end;

invariant

	assertion_1: not (after and before);
	before_definition: before = (index = 0);
	after_definition: after = (index = count + 1);
	offleft_definition: offleft = before or empty;
	offright_definition: offright = after or empty

end -- class LIST
