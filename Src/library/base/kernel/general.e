indexing

	description:
		"Platform-independent universal properties. %
		%This class is an ancestor to all developer-written classes.";

	status: "See notice at end of class";
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

feature -- Status report

	conforms_to (other: GENERAL): BOOLEAN is
			-- Does type of current object conform to type
			-- of `other' (as per Eiffel: The Language, chapter 13)?
		require
			other_not_void: other /= Void
		do
			Result := c_conforms_to ($other, $Current)
		end;

	same_type (other: GENERAL): BOOLEAN is
			-- Is type of current object identical to type of `other'?
		require
			other_not_void: other /= Void
		do
			Result := c_same_type ($other, $Current)
		ensure
			definition: Result = (conforms_to (other) and
										other.conforms_to (Current))
		end;

	consistent (other: like Current): BOOLEAN is
			-- Is current object in a consistent state so that `other'
			-- may be copied onto it? (Default answer: yes).
		do
			Result := true
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		require
			other_not_void: other /= Void
		do
			Result := c_standard_is_equal ($Current, $other)
		ensure
			symmetric: Result implies other.is_equal (Current);
			consistent: standard_is_equal (other) implies Result
		end;

	frozen standard_is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object, and field-by-field identical to it?
		require
			other_not_void: other /= Void
		do
			Result := c_standard_is_equal ($Current, $other)
		ensure
			same_type: Result implies same_type (other);
			symmetric: Result implies other.standard_is_equal (Current)
		end;

	frozen equal (some: GENERAL; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void or attached
			-- to objects considered equal?
		do
			if some = Void then
				Result := other = Void
			else
				Result := other /= Void and then
							some.is_equal (other)
			end
		ensure
			definition: Result = (some = Void and other = Void) or else
						((some /= Void and other /= Void) and then
						some.is_equal (other))
		end;

	frozen standard_equal (some: GENERAL; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void or attached to
			-- field-by-field identical objects of the same type?
			-- Always uses default object comparison criterion.
		do
			if some = Void then
				Result := other = Void
			else
				Result := other /= Void and then
							some.standard_is_equal (other)
			end
		ensure
			definition: Result = (some = Void and other = Void) or else
						((some /= Void and other /= Void) and then
						some.standard_is_equal (other))
		end;

	frozen deep_equal (some: GENERAL; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void
			-- or attached to isomorphic object structures?
		do
			if some = Void then
				Result := other = Void
			else
				Result := other /= Void and then
							c_deep_equal ($some, $other)
			end
		ensure
			shallow_implies_deep: standard_equal (some, other) implies Result;
			both_or_none_void: (some = Void) implies (Result = (other = Void));
			same_type: (Result and (some /= Void)) implies some.same_type (other);
			symmetric: Result implies deep_equal (other, some)
		end;

feature -- Duplication

	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		require
			other_not_void: other /= Void;
			type_identity: same_type (other)
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
			type_identity: same_type (other)
		do
			c_standard_copy ($other, $Current)
		ensure
			is_standard_equal: standard_is_equal (other)
		end;

	frozen clone (other: GENERAL): like other is
			-- Void if `other' is void; otherwise new object
			-- equal to `other'
			--
			-- For non-void `other', `clone' calls `copy';
		 	-- to change copying/cloning semantics, redefine `copy'.
		local
			temp: BOOLEAN
		do
			if other /= Void then
				temp := c_check_assert (False);
				Result := other.c_standard_clone ($other);
				Result.setup (other);
				Result.copy (other);
				temp := c_check_assert (temp);
			end
		ensure
			equal: equal (Result, other)
		end;

	frozen standard_clone (other: GENERAL): like other is
			-- Void if `other' is void; otherwise new object
			-- field-by-field identical to `other'.
			-- Always uses default copying semantics.
		local
			temp: BOOLEAN
		do
			if other /= Void then
				temp := c_check_assert (False);
				Result := other.c_standard_clone ($other);
				Result.standard_copy (other)
				temp := c_check_assert (temp);
			end
		ensure
			equal: standard_equal (Result, other)
		end;

	frozen deep_clone (other: GENERAL): like other is
			-- Void if `other' is void: otherwise, new object structure
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
			-- 		`temp' := `deep_clone' (`other');
			--		`copy' (`temp')
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
			-- Assuming current object has just been created, perform
			-- actions necessary to ensure that contents of `other'
			-- can be safely copied onto it.
		do
		ensure
			consistent (other)
		end;

feature -- Output

	io: STD_FILES is
			-- Handle to standard file setup
		once
			!! Result;
			Result.set_output_default
		end;

	out, frozen tagged_out: STRING is
			-- New string containing terse printable representation
			-- of current object
		do
			Result := c_tagged_out (Current)
		end;

	print (some: GENERAL) is
			-- Write terse external representation of `some'
			-- on standard output.
		do
			if some /= Void then
				io.put_string (some.out)
			end
		end;

feature -- Basic operations

	frozen do_nothing is
			-- Execute a null action.
		do
		end;

	frozen default: like Current is
			-- Default value of object's type
		do
		end;

	frozen default_pointer: POINTER is
			-- Default value of type `POINTER'
			-- (Avoid the need to write `p'.`default' for
			-- some `p' of type `POINTER'.)
		do
		ensure
			-- Result = Result.default
		end;

	frozen Void: NONE;
			-- Void reference

feature {GENERAL} -- Implementation

	c_standard_clone (other: POINTER): GENERAL is
			-- New object of same dynamic type as `other'
		external
			"C | <copy.h>"
		alias
			"eclone"
		end;

feature {NONE} -- Implementation

	frozen c_conforms_to (obj1, obj2: POINTER): BOOLEAN is
			-- Does dynamic type of object attached to `obj1' conform to
			-- dynamic type of object attached to `obj2'?
		external
			"C | <plug.h>"
		alias
			"econfg"
		end;

	frozen c_same_type (obj1, obj2: POINTER): BOOLEAN is
			-- Are dynamic type of object attached to `obj1' and
			-- dynamic type of object attached to `obj2' the same?
		external
			"C | <plug.h>"
		alias
			"estypeg"
		end;

	c_standard_is_equal (target, source: POINTER): BOOLEAN is
			-- C external performing standard equality
		external
			"C | <equal.h>"
		alias
			"eequal"
		end;

	c_standard_copy (source, target: POINTER) is
			-- C external performing standard copy
		external
			"C | <copy.h>"
		alias
			"ecopy"
		end;

	frozen c_deep_clone (other: POINTER): GENERAL is
			-- New object structure recursively duplicated from the one
			-- attached to `other'
		external
			"C | <copy.h>"
		alias
			"edclone"
		end;

	frozen c_deep_equal (some: POINTER; other: like some): BOOLEAN is
			-- Are `some' and `other' attached to recursively isomorphic
			-- object structures?
		external
			"C | <equal.h>"
		alias
			"ediso"
		end;

	frozen c_tagged_out (some: GENERAL): STRING is
			-- Printable representation of current object
		external
			"C | <out.h>"
		end;

	frozen c_generator (some: POINTER): STRING is
			-- Name of the generating class of current object
		external
			"C | <out.h>"
		end;

	frozen c_check_assert (b: BOOLEAN): BOOLEAN is
		external
			"C | <copy.h>"
		end;

invariant

	reflexive_equality: standard_is_equal (Current);
	reflexive_conformance: conforms_to (Current)

end -- class GENERAL


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
