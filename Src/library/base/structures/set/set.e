--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sets without commitment to a particular representation

indexing

	names: set;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SET [G] inherit

	COLLECTION [G]
		redefine
			add, remove_item
		end

feature -- Insertion

	add (v: G) is
			-- Include `v' in `Current'.
		deferred
		ensure then
	--		old has (v) implies (count = old count);
	--		not old has (v) implies (count = old count + 1)
		end;

	put (v: G) is
			-- Include `v' in `Current'.
			-- Synonym for `add'.
		require
			extensible
		do
			add (v)
		ensure
	--		old has (v) implies (count = old count);
	--		not old has (v) implies (count = old count + 1);
	--		count >= old count;
			has (v)
		end;

	merge (other: like Current) is
			-- Add all items of `other'.
		require
			set_exists: other /= Void
		deferred
		ensure
			is_superset (other);
	--		is_superset (old Current)
		end;

feature -- Deletion

	remove_item (v: G) is
			-- Remove `v' from `Current' if it is already present.
		deferred
		ensure then
	--		old has (v) implies (count = old count - 1);
	--		not old has (v) implies (count = old count);
			item_deleted: not has (v)
		end;

feature -- Cursor

    cursor: CURSOR is
            -- Current cursor position
		deferred
        end;

	start is
			-- Move cursor to first position.
		deferred
		end;

    go_to (p: CURSOR) is
            -- Move cursor to position `p'.
		deferred
        end;

feature -- Transformation

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-set beginning at cursor position
            -- and having min (`n', `count' - `index' + 1) items
		deferred
		end;

	intersect (other: like Current) is
			-- Remove all items not in `other'.
		require
			set_exists: other /= Void
		deferred
		ensure
			is_subset_other: is_subset (other);
	--		is_subset (old Current)
		end;

	subtract (other: like Current) is
			-- Remove all items also in `other'.
		require
			set_exists: other /= Void
		deferred
		ensure
	--		is_subset (old Current);
			is_disjoint: disjoint (other)
		end;

	symdif (other: like Current) is
			-- Remove all items also in `other',
			-- and add all items of `other' not
			-- present in `Current'.
		require
			set_exists: other /= Void
		local
			temp: like Current
		do
			start;
			temp := duplicate (count);
			temp.intersect (other);
			merge (other);
			subtract (temp)
		end;

feature -- Comparison

	is_subset (other: like Current): BOOLEAN is
			-- Is `Current' a subset of `other'?
		require
			set_exists: other /= Void
		deferred
		end;

	is_superset (other: like Current): BOOLEAN is
			-- Is `Current' a superset of `other'?
		require
			set_exists: other /= Void
		do
			Result := other.is_subset (Current)
		end;

	disjoint (other: like Current): BOOLEAN is
			-- Do `Current' and `other' have no
			-- elements in common?
		require
			set_exists: other /= Void
		local
			temp: like Current;
			pos: CURSOR
		do
			if not empty then
				pos := cursor;
				start;
				temp := duplicate (count);
				temp.intersect (other);
				Result := temp.empty;
				go_to (cursor)
			else
				Result := true
			end
		end;

end
