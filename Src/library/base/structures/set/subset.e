indexing

	description:
		"Subsets with the associated operations, %
		%without commitment to a particular representation";

	status: "See notice at end of class";
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
			-- items in common?
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
		ensure
			correct_count_1: n <= count implies Result.count = n
			correct_count_2: n >= count implies Result.count = count
		end;

feature -- Basic operations

	intersect (other: like Current) is
			-- Remove all items not in `other'.
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		ensure
			is_subset_other: is_subset (other);
		end;

	merge (other: like Current) is
			-- Add all items of `other'.
		require
			set_exists: other /= Void
 			same_rule: object_comparison = other.object_comparison
		deferred
		ensure
			is_superset: is_superset (other);
		end;

	subtract (other: like Current) is
			-- Remove all items also in `other'.
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		ensure
			is_disjoint: disjoint (other)
		end;

	symdif (other: like Current) is
			-- Remove all items also in `other', and add all
			-- items of `other' not already present.
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
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

