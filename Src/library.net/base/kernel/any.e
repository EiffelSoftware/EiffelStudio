indexing
	generator: "Eiffel Emitter 2.8b2"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

class
	ANY
	
feature {NONE} -- Initialization

	default_create is
			-- Default initialization
		do
		end
		
feature -- Access

	generator: STRING is
			-- Name of current object's generating class
			-- (base class of the type of which it is a direct instance)
		do
				-- FIXME: Should take into account Eiffel name, not
				-- CIL name.
			Result := create {STRING}.make_from_cil (get_type.get_name)
		end

 	generating_type: STRING is
			-- Name of current object's generating type
			-- (type of which it is a direct instance)
 		do
				-- FIXME: Should take into account genericity.
 			Result := create {STRING}.make_from_cil (get_type.get_name)
 		end

feature -- Status report

	conforms_to (other: ANY): BOOLEAN is
			-- Does type of current object conform to type
			-- of `other' (as per Eiffel: The Language, chapter 13)?
		require
			other_not_void: other /= Void
		do
			Result := get_type.is_instance_of_type (other)
		end

	same_type (other: ANY): BOOLEAN is
			-- Is type of current object identical to type of `other'?
		require
			other_not_void: other /= Void
		do
			Result := get_type.is_instance_of_type (other) and then
				other.get_type.is_instance_of_type (Current)
		ensure
			definition: Result = (conforms_to (other) and
										other.conforms_to (Current))
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		require
			other_not_void: other /= Void
		do
			Result := standard_is_equal (other)
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
			Result := equals_object_object (Current, other)
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
				Result := other = some
				if not Result then
					check
						not_implemented: False
					end
				end
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
			standard_copy (other)
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
			internal_copy (other)
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
				temp := feature {ISE_RUNTIME}.check_assert (False)
				Result := other.internal_clone
				Result.copy (other)
				temp := feature {ISE_RUNTIME}.check_assert (temp)
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
				temp := feature {ISE_RUNTIME}.check_assert (False)
				Result := other.internal_clone
				Result.standard_copy (other)
				temp := feature {ISE_RUNTIME}.check_assert (temp)
			end
		ensure
			equal: standard_equal (Result, other)
		end

	frozen deep_clone (other: ANY): like other is
			-- Void if `other' is void: otherwise, new object structure
			-- recursively duplicated from the one attached to `other'
		do
			check
				not_implemented: False
			end
			if other /= Void then
				Result := other.internal_clone
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
			Result := create {STRING}.make_from_cil (to_string)
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

	frozen internal_clone: ANY is
			-- Perform a memberwise clone of Current.
			-- Has to be exported, but should not be called by user code.
		do
			-- Built-in
		end

feature {NONE} -- Implementation

	frozen internal_copy (o: ANY) is
			-- Copy `o' into `Current'.
			-- Can only be called from `standard_copy' which ensures type validity.
		do
			-- Built-in
		end

invariant
	reflexive_equality: standard_is_equal (Current)
	reflexive_conformance: conforms_to (Current)

end -- class ANY
