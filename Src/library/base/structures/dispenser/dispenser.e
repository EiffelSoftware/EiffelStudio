--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Dispensers, i.e. containers for which clients
-- have no say as to what item they can access
-- at a given time. Examples are stacks and queues

indexing

	names: dispenser, active;
	access: fixed, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class DISPENSER [G] inherit

	SEQUENCE [G]
		export
			{NONE}
				search, search_equal, has, index_of
		redefine
			readable, writable, contractable,
			append
		end

feature -- Access

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := not empty
		end;

feature -- Insertion

	append (s: SEQUENCE [G]) is
			-- Append a copy of `s' to `Current'.
			-- (Synonym for `fill')
		do
			fill (s)
		end;

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := not empty
		end;

feature {NONE} -- Deletion

	remove_item (v: G) is
			-- Remove `v' from `Current'.
		do
		end;

	contractable: BOOLEAN is
			-- May items be removed from `Current'?
		do
			Result := not empty
		end;

invariant

	readable_definition: readable = not empty;
	writable_definition: writable = not empty;
	contractable_definition: contractable = not empty

end
