--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	--
--|	270 Storke Road, Suite 7 Goleta, California 93117	--
--|				   (805) 685-1006		--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class GENERAL

feature -- Equality, clone, copy

	is_equal, frozen standard_is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object field-by-field identical
			-- to current object ?
		require
			other_not_void: other /= Void;
		do
			Result := c_standard_is_equal ($Current, $other)
		end;

	equal, frozen standard_equal (some: GENERAL; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void or attached to
			-- field-by-field identical objects ?
		do
			Result := 	(some = Void and other = Void)
						or else
						(	(some /= Void and other /= Void)
							and then
							some.is_equal (other)
						)
		ensure
			Result = 	(some = Void and other = Void)
						or else
						(	(some /= Void and other /= Void)
							and then
							some.is_equal (other)
						)
		end;

	copy, frozen standard_copy (other: like Current) is
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

	clone (other: GENERAL): like other is
			-- Void if `other' is void; otherwise new object
			-- field-by-field identical to `other'
		do
			if other /= Void then
				Result := other.twin;
			end
		ensure
			equal: equal (Result, other)
		end;

	frozen standard_clone (other: GENERAL): like other is
			-- Void if `other' is void; otherwise new object
			-- field-by-field identical to `other'
		do
			if other /= Void then
				Result := other.standard_twin;
			end
		ensure
			equal: equal (Result, Current)
		end;

	twin: like Current is
			-- New object field-by-field identical to `Current'
		do
			Result := c_standard_clone ($Current);
			Result.copy (Current)
		ensure
			is_equal: Result.is_equal (Current)
		end;

	frozen standard_twin: like Current is
			-- New object field-by-field identical to `other'
		do
			Result := c_standard_clone ($Current);
			Result.standard_copy (Current)
		ensure
			is_equal: Result.standard_is_equal (Current)
		end;

	deep_clone, frozen standard_deep_clone (other: GENERAL): like other is
			-- Void of `other' is void: otherwise, new object structure
			-- recursively duplicated from the one attached to `other'
		do
			if other /= Void then
				Result := c_deep_clone ($other)
			end
		ensure
			deep_equal: deep_equal (other, Result)
		end;

	deep_copy, frozen standard_deep_copy (other: like Current) is
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

	deep_equal, frozen standard_deep_equal
		(some: GENERAL; other: like some): BOOLEAN is
			-- Are `some' and `other' either both void or attached recursively
			-- isomrphic object structures ?
		do
			Result := 	(	some = Void and then other = Void)
						or else
						(	some /= Void and then other /= Void
							and then
							c_deep_equal ($some, $other)
						)
		end;

feature -- Simple input and output
	
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

	generator: STRING is
			-- Name of current object's generating class
			-- (base class of the type of which it is a direct instance)
		do
			Result := c_generator ($Current);
		end; 

feature -- Conformance

	conforms_to (other: like Current): BOOLEAN is
			-- Is dynamic type of current object a descendant of
			-- dynamic type `other' ?
		require
			other_not_void: other /= Void
		do
			Result := c_conforms_to ($Current, $other)
		end;

feature -- Exit feature

	die (code: INTEGER) is
			-- Exit program with exit status `code'.
		external
			"C"
		alias
			"esdie"
		end;

feature {NONE} -- Void value

	Void: NONE;
			-- Void reference

feature {NONE} -- C externals for copy, cloning and equality

	c_standard_is_equal (target, source: GENERAL): BOOLEAN is
			-- C external performing standard equality
			-- ## To be redefined in AREA into "spequal"
		external
			"C"
		alias
			"eequal"
		end;

	c_standard_copy (source, target: GENERAL) is
			-- C external performing standard copy
			-- ## To be redefined in AREA into "spcopy"
		external
			"C"
		alias
			"ecopy"
		end;

	c_standard_clone (other: GENERAL): like other is
			-- New object of same dynamic type as `other'
			-- ## To be redefined in AREA into "spclone"
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
			-- object structures ?
		external
			"C"
		alias
			"ediso"
		end;

feature {} -- Externals for object printing

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

feature {NONE} -- External for conformance query

	frozen c_conforms_to (obj1, obj2: GENERAL): BOOLEAN is
			-- Does dynamic type of object attached to `obj1' conform to
			-- dynamic type of object attached to `obj2' ?
		external
			"C"
		alias
			"econfg"
		end;

end
