--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sequences, i.e. data structures in which items are
-- arranged linearly, to which items can be appended, and
-- which items can be accessed in sequence only

indexing

	names: sequence;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SEQUENCE [G] inherit

	ACTIVE [G];
	
	SEQUENTIAL [G]

feature -- Access

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := not off
		end;

feature -- Insertion

	put (v: like item) is
			-- Add `v' to the end of `Current'.
			-- (Synonym for `add')
		require
			extensible: extensible
		do
			add (v)
		ensure
	--		new_count: count = old count + 1;
			item_inserted: has (v)
		end;

	append (s: SEQUENCE [G]) is
			-- Append a copy of `s' to `Current'.
		require
			argument_not_void: s /= Void
		do
			from
				s.start
			until
				not extensible or else s.off
			loop
				add (s.item);
				s.forth
			end
		ensure
	--		new_count: count >= old count
		end;

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := not off
		end;

end -- class SEQUENCE
