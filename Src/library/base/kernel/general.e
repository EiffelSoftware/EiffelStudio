indexing

	description:
		"Platform-independent universal properties. %
		%This class is an ancestor to all developer-written classes.";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	GENERAL

feature -- Access

	generator: STRING is
			-- Name of current object's generating class
			-- (base class of the type of which it is a direct instance)
		do
			Result := c_generator ($Current);
		end;
 
	conforms_to (other: like Current): BOOLEAN is
			-- Is dynamic type of current object a descendant of
			-- dynamic type of `other'?
		require
			other_not_void: other /= Void
		do
			Result := c_conforms_to ($other, $Current)
		end;

feature -- Status report

	consistent (other: like Current): BOOLEAN is
			-- Is object in a consistent state so that others
			-- can be copied onto it? (Default answer: yes).
		do
			Result := true
		end;

feature -- Comparison

	is_equal, frozen standard_is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object field-by-field identical
			-- to current object?
		require
			other_not_void: other /= Void;
		do
			Result := c_standard_is_equal ($Current, $other)
		end;

	frozen equal (some: GENERAL; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void or attached
			-- to field-by-field identical objects?
			--
			-- For non-void arguments, `equal' calls `is_equal';
			-- to change comparison criterion, redefine `is_equal'.
		do
			Result := (some = Void and other = Void) or else
						((some /= Void and other /= Void) and then
						some.is_equal (other))
		ensure
			Result = (some = Void and other = Void) or else
						((some /= Void and other /= Void) and then
						some.is_equal (other))
		end;

	frozen standard_equal (some: GENERAL; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void or attached to
			-- field-by-field identical objects?
			-- Always uses the default object comparison criterion.
		do
			Result := (some = Void and other = Void) or else
						((some /= Void and other /= Void) and then
						some.standard_is_equal (other))
		ensure
			Result = (some = Void and other = Void) or else
						((some /= Void and other /= Void) and then
						some.standard_is_equal (other))
		end;

	deep_equal (some: GENERAL; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void or attached recursively
			-- isomrphic object structures?
		do
			Result := (some = Void and then other = Void) or else
						(some /= Void and then other /= Void and then
						c_deep_equal ($some, $other))
		end;

feature -- Duplication

	copy (other: like Current) is
			-- Copy the structure representing by `other' onto
			-- that represented by current object.
		require
			other_not_void: other /= Void;
			conformance: other.conforms_to (Current);
		do
			c_standard_copy ($other, $Current)
		ensure
			is_equal: is_equal (other)
		end;

	frozen standard_copy (other: like Current) is
			-- Copy every field of `other' onto corresponding field
			-- of current object.
		require
			other_not_void: other /= Void;
			conformance: other.conforms_to (Current);
		do
			c_standard_copy ($other, $Current)
		ensure
			is_equal: is_equal (other)
		end;

	frozen clone (other: GENERAL): like other is
			-- Void if `other' is void; otherwise new object
			-- field-by-field identical to `other'.
			--
			-- For non-void `other', `clone' calls `copy';
		 	-- to change copying/cloning semantics, redefine `copy'.
		do
			if other /= Void then
				Result := c_standard_clone ($other);
				Result.setup (other);
				Result.copy (other)
			end
		ensure
			equal: equal (Result, other)
		end;

	frozen standard_clone (other: GENERAL): like other is
			-- Void if `other' is void; otherwise new object
			-- field-by-field identical to `other'.
			-- Always uses the default copying semantics.
		do
			if other /= Void then
				Result := c_standard_clone ($other);
				Result.standard_copy (Current)
			end
		ensure
			equal: standard_equal (Result, Current)
		end;

	frozen deep_clone (other: GENERAL): like other is
			-- Void of `other' is void: otherwise, new object structure
			-- recursively duplicated from the one attached to `other'
		do
			if other /= Void then
				Result := c_deep_clone ($other)
			end
		ensure
			deep_equal: deep_equal (other, Result)
		end;

	frozen deep_copy (other: like Current) is
			-- Effect equivalent to that of:
			-- 		temp := deep_clone (other);
			--		copy (temp)
		require
			other_not_void: other /= Void
		local
			temp: like Current;
		do
			temp := deep_clone (other);
			copy (temp)
		ensure
			deep_equal: deep_equal (Current, other)
		end; 

	setup (other: like Current) is
			-- Perform actions on a freshly created object so that
			-- the contents of `other' can be safely copied onto it.
		do
		ensure
			consistent (other)
		end;

feature -- Output
	
	io: STD_FILES is
			-- Standard files access
		once
			!! Result;
			Result.set_output_default;
		end;

	out, frozen tagged_out: STRING is
			-- New string containing a terse printable representation
			-- of `some' field-by-field (empty string if void.)
		do
				Result := c_tagged_out (Current)
		end;

	print (some: GENERAL) is
			-- Write terse external representation of Current on
			-- standard input.
		do
			if some /= Void then
				io.putstring (some.out)
			end
		end; 

feature -- Miscellaneous

	frozen do_nothing is
		do
		end;

	Void: NONE;
			-- Void reference

	die (code: INTEGER) is
			-- Exit program with exit status `code'.
		external
			"C"
		alias
			"esdie"
		end;

feature {NONE} -- Implementation

	frozen c_conforms_to (obj1, obj2: GENERAL): BOOLEAN is
			-- Does dynamic type of object attached to `obj1' conform to
			-- dynamic type of object attached to `obj2'?
		external
			"C"
		alias
			"econfg"
		end;

	c_standard_is_equal (target, source: GENERAL): BOOLEAN is
			-- C external performing standard equality
		external
			"C"
		alias
			"eequal"
		end;

	c_standard_copy (source, target: GENERAL) is
			-- C external performing standard copy
		external
			"C"
		alias
			"ecopy"
		end;

	c_standard_clone (other: GENERAL): like other is
			-- New object of same dynamic type as `other'
		external
			"C"
		alias
			"eclone"
		end;

	frozen c_deep_clone (other: GENERAL): like other is
			-- New object structure recursively duplicated from the one
			-- attached to `other'
		external
			"C"
		alias
			"edclone"
		end;

	frozen c_deep_equal (some: GENERAL; other: like some): BOOLEAN is
			-- Are `some' and `other' attached to recursively isomorphic
			-- object structures?
		external
			"C"
		alias
			"ediso"
		end;

	frozen c_tagged_out (some: GENERAL): STRING is
			-- Printable representation of `some'
		external
			"C"
		end;

	frozen c_generator (some: GENERAL): STRING is
			-- Name of the generating class of `some'
		external
			"C"
		end;

invariant

end -- class GENERAL


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
