indexing

	description:
		"Subsets with the associated operations, %
		%without commitment to a particular representation";

	copyright: "See notice at end of class";
	names: subset, set;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SUBSET [G] inherit

	SET [G];

feature -- Comparison

	is_subset (other: like Current): BOOLEAN is
			-- Is current set a subset of `other'?
		require
			set_exists: other /= Void;
			same_rule: object_comparison = other.object_comparison
		deferred
		end;

	is_superset (other: like Current): BOOLEAN is
			-- Is current set a superset of `other'?
		require
			set_exists: other /= Void;
			same_rule: object_comparison = other.object_comparison
		do
			Result := other.is_subset (Current)
		end;

	disjoint (other: like Current): BOOLEAN is
			-- Do current set and `other' have no
			-- elements in common?
		require
			set_exists: other /= Void;
			same_rule: object_comparison = other.object_comparison
		local
			temp: like Current;
		do
			if not empty then
				temp := duplicate (count);
				temp.intersect (other);
				Result := temp.empty;
			else
				Result := true
			end
		end;

feature -- Duplication

	duplicate (n: INTEGER): SUBSET [G] is
			-- New structure containing min (`n', `count')
			-- items from current structure
		require
			non_negative: n >= 0
		deferred
		end;

feature -- Basic operations

	intersect (other: like Current) is
			-- Remove all items not in `other'.
		require
			set_exists: other /= Void;
			same_rule: object_comparison = other.object_comparison
		deferred
		ensure
			is_subset_other: is_subset (other);
			--is_subset (old Current)
		end;

	merge (other: like Current) is
			-- Add all items of `other'.
		require
			set_exists: other /= Void;
			same_rule: object_comparison = other.object_comparison
		deferred
		ensure
			is_superset (other);
			--is_superset (old Current)
		end;

	subtract (other: like Current) is
			-- Remove all items also in `other'.
		require
			set_exists: other /= Void;
			same_rule: object_comparison = other.object_comparison
		deferred
		ensure
			--is_subset (old Current);
			is_disjoint: disjoint (other)
		end;

	symdif (other: like Current) is
			-- Remove all elements also in `other', and add all elements
			-- of `other' not already present.
		require
			set_exists: other /= Void;
			same_rule: object_comparison = other.object_comparison
		local
			temp: like Current
		do
			temp := duplicate (count);
			temp.intersect (other);
			merge (other);
			subtract (temp)
		end;

end -- class SUBSET


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
