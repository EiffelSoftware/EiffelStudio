indexing

	description: "[
		Project-wide universal properties.
		This class is an ancestor to all developer-written classes.
		ANY may be customized for individual projects or teams.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ANY

feature -- Customization

feature -- Access

	generator: STRING is
			-- Name of current object's generating class
			-- (base class of the type of which it is a direct instance)
		do
			Result := c_generator ($Current)
		end

 	generating_type: STRING is
			-- Name of current object's generating type
			-- (type of which it is a direct instance)
 		do
 			Result := c_generating_type ($Current)
 		end

feature -- Status report

	conforms_to (other: ANY): BOOLEAN is
			-- Does type of current object conform to type
			-- of `other' (as per Eiffel: The Language, chapter 13)?
		require
			other_not_void: other /= Void
		do
			Result := c_conforms_to ($other, $Current)
		end

	same_type (other: ANY): BOOLEAN is
			-- Is type of current object identical to type of `other'?
		require
			other_not_void: other /= Void
		do
			Result := c_same_type ($other, $Current)
		ensure
			definition: Result = (conforms_to (other) and
										other.conforms_to (Current))
		end

 	consistent (other: like Current): BOOLEAN is
 			-- Is current object in a consistent state so that `other'
 			-- may be copied onto it? (Default answer: yes).
 		obsolete
 			"Not used anymore, please remove it from your inheritance clauses if it appears."
 		do
 		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		require
			other_not_void: other /= Void
		do
			Result := c_standard_is_equal ($Current, $other)
		ensure
			symmetric: Result implies other.is_equal (Current)
			consistent: standard_is_equal (other) implies Result
		end

	frozen standard_is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object, and field-by-field identical to it?
		require
			other_not_void: other /= Void
		do
			Result := c_standard_is_equal ($Current, $other)
		ensure
			same_type: Result implies same_type (other)
			symmetric: Result implies other.standard_is_equal (Current)
		end

	frozen equal (some: ANY; other: like some): BOOLEAN is
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
		end

	frozen standard_equal (some: ANY; other: like some): BOOLEAN is
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
		end

	frozen deep_equal (some: ANY; other: like some): BOOLEAN is
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
			shallow_implies_deep: standard_equal (some, other) implies Result
			both_or_none_void: (some = Void) implies (Result = (other = Void))
			same_type: (Result and (some /= Void)) implies some.same_type (other)
			symmetric: Result implies deep_equal (other, some)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		require
			other_not_void: other /= Void
			type_identity: same_type (other)
		do
			c_standard_copy ($other, $Current)
		ensure
			is_equal: is_equal (other)
		end

	frozen standard_copy (other: like Current) is
			-- Copy every field of `other' onto corresponding field
			-- of current object.
		require
			other_not_void: other /= Void
			type_identity: same_type (other)
		do
			c_standard_copy ($other, $Current)
		ensure
			is_standard_equal: standard_is_equal (other)
		end

	frozen clone (other: ANY): like other is
			-- Void if `other' is void; otherwise new object
			-- equal to `other'
			--
			-- For non-void `other', `clone' calls `copy';
		 	-- to change copying/cloning semantics, redefine `copy'.
		local
			temp: BOOLEAN
		do
			if other /= Void then
				temp := c_check_assert (False)
				Result := c_standard_clone ($other)
				Result.copy (other)
				temp := c_check_assert (temp)
			end
		ensure
			equal: equal (Result, other)
		end
		
	frozen standard_clone (other: ANY): like other is
			-- Void if `other' is void; otherwise new object
			-- field-by-field identical to `other'.
			-- Always uses default copying semantics.
		local
			temp: BOOLEAN
		do
			if other /= Void then
				temp := c_check_assert (False)
				Result := c_standard_clone ($other)
				Result.standard_copy (other)
				temp := c_check_assert (temp)
			end
		ensure
			equal: standard_equal (Result, other)
		end

	frozen deep_clone (other: ANY): like other is
			-- Void if `other' is void: otherwise, new object structure
			-- recursively duplicated from the one attached to `other'
		do
			if other /= Void then
				Result := c_deep_clone ($other)
			end
		ensure
			deep_equal: deep_equal (other, Result)
		end

	frozen deep_copy (other: like Current) is
			-- Effect equivalent to that of:
			-- 		`temp' := `deep_clone' (`other');
			--		`copy' (`temp')
		require
			other_not_void: other /= Void
		local
			temp: like Current
		do
			temp := deep_clone (other)
			copy (temp)
		ensure
			deep_equal: deep_equal (Current, other)
		end

 	setup (other: like Current) is
 			-- Assuming current object has just been created, perform
 			-- actions necessary to ensure that contents of `other'
 			-- can be safely copied onto it.
 		obsolete
 			"Not used anymore by `clone', please remove it from your inheritance clauses%N%
 			%if it appears."
 		do
 		end

feature -- Output

	io: STD_FILES is
			-- Handle to standard file setup
		once
			create Result
			Result.set_output_default
		end

	out, frozen tagged_out: STRING is
			-- New string containing terse printable representation
			-- of current object
		do
			Result := c_tagged_out (Current)
		end

	print (some: ANY) is
			-- Write terse external representation of `some'
			-- on standard output.
		do
			if some /= Void then
				io.put_string (some.out)
			end
		end

feature -- Platform

	Operating_environment: OPERATING_ENVIRONMENT is
			-- Objects available from the operating system
		once
			create Result
		end

feature -- Basic operations

	default_rescue is
			-- Process exception for routines with no Rescue clause.
			-- (Default: do nothing.)
		do
		end

	default_create is
			-- Process instances of classes with no creation clause.
			-- (Default: do nothing.)
		do
		end

	frozen do_nothing is
			-- Execute a null action.
		do
		end

	frozen default: like Current is
			-- Default value of object's type
		do
		end

	frozen default_pointer: POINTER is
			-- Default value of type `POINTER'
			-- (Avoid the need to write `p'.`default' for
			-- some `p' of type `POINTER'.)
		do
		ensure
			-- Result = Result.default
		end

	frozen Void: NONE
			-- Void reference

feature {NONE} -- Implementation

	frozen c_standard_clone (other: POINTER): ANY is
			-- New object of same dynamic type as `other'
		external
			"C | %"eif_copy.h%""
		alias
			"eclone"
		end

	frozen c_conforms_to (obj1, obj2: POINTER): BOOLEAN is
			-- Does dynamic type of object attached to `obj1' conform to
			-- dynamic type of object attached to `obj2'?
		external
			"C [macro %"eif_plug.h%"]"
		alias
			"econfg"
		end

	frozen c_same_type (obj1, obj2: POINTER): BOOLEAN is
			-- Are dynamic type of object attached to `obj1' and
			-- dynamic type of object attached to `obj2' the same?
		external
			"C [macro %"eif_plug.h%"]"
		alias
			"estypeg"
		end

	frozen c_standard_is_equal (target, source: POINTER): BOOLEAN is
			-- C external performing standard equality
		external
			"C | %"eif_equal.h%""
		alias
			"eequal"
		end

	frozen c_standard_copy (source, target: POINTER) is
			-- C external performing standard copy
		external
			"C | %"eif_copy.h%""
		alias
			"ecopy"
		end

	frozen c_deep_clone (other: POINTER): ANY is
			-- New object structure recursively duplicated from the one
			-- attached to `other'
		external
			"C | %"eif_copy.h%""
		alias
			"edclone"
		end

	frozen c_deep_equal (some: POINTER; other: like some): BOOLEAN is
			-- Are `some' and `other' attached to recursively isomorphic
			-- object structures?
		external
			"C | %"eif_equal.h%""
		alias
			"ediso"
		end

	frozen c_tagged_out (some: ANY): STRING is
			-- Printable representation of current object
		external
			"C | %"eif_out.h%""
		end

	frozen c_generator (some: POINTER): STRING is
			-- Name of the generating class of current object
		external
			"C | %"eif_out.h%""
		end

	frozen c_check_assert (b: BOOLEAN): BOOLEAN is
		external
			"C | %"eif_copy.h%""
		end

 	frozen c_generating_type (obj: POINTER): STRING is
 		external
 			"C | %"eif_gen_conf.h%""
 		alias
 			"eif_gen_typename"
 		end

invariant

	reflexive_equality: standard_is_equal (Current)
	reflexive_conformance: conforms_to (Current)

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class ANY



