note

	description: "[
		Project-wide universal properties.
		This class is an ancestor to all developer-written classes.
		ANY may be customized for individual projects or teams.
		]"

	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	ANY

feature -- Customization

feature -- Access

	generator: STRING
			-- Name of current object's generating class
			-- (base class of the type of which it is a direct instance)
		external
			"built_in"
		ensure
			generator_not_void: Result /= Void
			generator_not_empty: not Result.is_empty
		end

 	generating_type: STRING
			-- Name of current object's generating type
			-- (type of which it is a direct instance)
		external
			"built_in"
 		ensure
 			generating_type_not_void: Result /= Void
			generating_type_not_empty: not Result.is_empty
 		end

feature -- Status report

	conforms_to (other: ANY): BOOLEAN
			-- Does type of current object conform to type
			-- of `other' (as per Eiffel: The Language, chapter 13)?
		require
			other_not_void: other /= Void
		external
			"built_in"
		end

	same_type (other: ANY): BOOLEAN
			-- Is type of current object identical to type of `other'?
		require
			other_not_void: other /= Void
		external
			"built_in"
		ensure
			definition: Result = (conforms_to (other) and
										other.conforms_to (Current))
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		require
			other_not_void: other /= Void
		external
			"built_in"
		ensure
			symmetric: Result implies other ~ Current
			consistent: standard_is_equal (other) implies Result
		end

	frozen standard_is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object, and field-by-field identical to it?
		require
			other_not_void: other /= Void
		external
			"built_in"
		ensure
			same_type: Result implies same_type (other)
			symmetric: Result implies other.standard_is_equal (Current)
		end

	frozen equal (a: detachable ANY; b: like a): BOOLEAN
			-- Are `a' and `b' either both void or attached
			-- to objects considered equal?
		do
			if a = Void then
				Result := b = Void
			else
				Result := b /= Void and then
							a.is_equal (b)
			end
		ensure
			definition: Result = (a = Void and b = Void) or else
						((a /= Void and b /= Void) and then
						a.is_equal (b))
		end

	frozen standard_equal (a: detachable ANY; b: like a): BOOLEAN
			-- Are `a' and `b' either both void or attached to
			-- field-by-field identical objects of the same type?
			-- Always uses default object comparison criterion.
		do
			if a = Void then
				Result := b = Void
			else
				Result := b /= Void and then
							a.standard_is_equal (b)
			end
		ensure
			definition: Result = (a = Void and b = Void) or else
						((a /= Void and b /= Void) and then
						a.standard_is_equal (b))
		end

	frozen is_deep_equal (other: like Current): BOOLEAN
			-- Are `Current' and `other' attached to isomorphic object structures?
		require
			other_not_void: other /= Void
		external
			"built_in"
		ensure
			shallow_implies_deep: standard_is_equal (other) implies Result
			same_type: Result implies same_type (other)
			symmetric: Result implies other.is_deep_equal (Current)
		end

	frozen deep_equal (a: detachable ANY; b: like a): BOOLEAN
			-- Are `a' and `b' either both void
			-- or attached to isomorphic object structures?
		do
			if a = Void then
				Result := b = Void
			else
				Result := b /= Void and then a.is_deep_equal (b)
			end
		ensure
			shallow_implies_deep: standard_equal (a, b) implies Result
			both_or_none_void: (a = Void) implies (Result = (b = Void))
			same_type: (Result and (a /= Void)) implies (b /= Void and then a.same_type (b))
			symmetric: Result implies deep_equal (b, a)
		end

feature -- Duplication

	frozen twin: like Current
			-- New object equal to `Current'
			-- `twin' calls `copy'; to change copying/twining semantics, redefine `copy'.
		external
			"built_in"
		ensure
			twin_not_void: Result /= Void
			is_equal: Result ~ Current
		end

	copy (other: like Current)
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		require
			other_not_void: other /= Void
			type_identity: same_type (other)
		external
			"built_in"
		ensure
			is_equal: Current ~ other
		end

	frozen standard_copy (other: like Current)
			-- Copy every field of `other' onto corresponding field
			-- of current object.
		require
			other_not_void: other /= Void
			type_identity: same_type (other)
		external
			"built_in"
		ensure
			is_standard_equal: standard_is_equal (other)
		end

	frozen clone (other: detachable ANY): like other
			-- Void if `other' is void; otherwise new object
			-- equal to `other'
			--
			-- For non-void `other', `clone' calls `copy';
		 	-- to change copying/cloning semantics, redefine `copy'.
		do
			if other /= Void then
				Result := other.twin
			end
		ensure
			equal: Result ~ other
		end

	frozen standard_clone (other: detachable ANY): like other
			-- Void if `other' is void; otherwise new object
			-- field-by-field identical to `other'.
			-- Always uses default copying semantics.
		do
			if other /= Void then
				Result := other.standard_twin
			end
		ensure
			equal: standard_equal (Result, other)
		end

	frozen standard_twin: like Current
			-- New object field-by-field identical to `other'.
			-- Always uses default copying semantics.
		external
			"built_in"
		ensure
			standard_twin_not_void: Result /= Void
			equal: standard_equal (Result, Current)
		end

	frozen deep_twin: like Current
			-- New object structure recursively duplicated from Current.
		external
			"built_in"
		ensure
			deep_twin_not_void: Result /= Void
			deep_equal: deep_equal (Current, Result)
		end

	frozen deep_clone (other: detachable ANY): like other
			-- Void if `other' is void: otherwise, new object structure
			-- recursively duplicated from the one attached to `other'
		do
			if other /= Void then
				Result := other.deep_twin
			end
		ensure
			deep_equal: deep_equal (other, Result)
		end

	frozen deep_copy (other: like Current)
			-- Effect equivalent to that of:
			--		`copy' (`other' . `deep_twin')
		require
			other_not_void: other /= Void
		do
			copy (other.deep_twin)
		ensure
			deep_equal: deep_equal (Current, other)
		end

feature {NONE} -- Retrieval

	frozen internal_correct_mismatch
			-- Called from runtime to perform a proper dynamic dispatch on `correct_mismatch'
			-- from MISMATCH_CORRECTOR.
		do
		end

feature -- Output

	io: STD_FILES
			-- Handle to standard file setup
		once
			create Result
			Result.set_output_default
		ensure
			io_not_void: Result /= Void
		end

	out: STRING
			-- New string containing terse printable representation
			-- of current object
		do
			Result := tagged_out
		ensure
			out_not_void: Result /= Void
		end

	frozen tagged_out: STRING
			-- New string containing terse printable representation
			-- of current object
		external
			"built_in"
		ensure
			tagged_out_not_void: Result /= Void
		end

	print (o: detachable ANY)
			-- Write terse external representation of `o'
			-- on standard output.
		do
			if o /= Void then
				io.put_string (o.out)
			end
		end

feature -- Platform

	Operating_environment: OPERATING_ENVIRONMENT
			-- Objects available from the operating system
		once
			create Result
		ensure
			operating_environment_not_void: Result /= Void
		end

feature {NONE} -- Initialization

	default_create
			-- Process instances of classes with no creation clause.
			-- (Default: do nothing.)
		do
		end

feature -- Basic operations

	default_rescue
			-- Process exception for routines with no Rescue clause.
			-- (Default: do nothing.)
		do
		end

	frozen do_nothing
			-- Execute a null action.
		do
		end

	frozen default: detachable like Current
			-- Default value of object's type
		do
		end

	frozen default_pointer: POINTER
			-- Default value of type `POINTER'
			-- (Avoid the need to write `p'.`default' for
			-- some `p' of type `POINTER'.)
		do
		ensure
			-- Result = Result.default
		end

	frozen as_attached: attached like Current
			-- Attached version of Current
			-- (Can be used during transitional period to convert
			-- non-void-safe classes to void-safe ones.)
		obsolete "Remove calls to this feature as soon as its client is void-safe."
		do
			Result := Current
		end

invariant
	reflexive_equality: standard_is_equal (Current)
	reflexive_conformance: conforms_to (Current)

end
