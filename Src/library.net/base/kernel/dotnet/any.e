indexing
	generator: "Eiffel Emitter 2.8b2"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

class
	ANY

inherit
	SYSTEM_OBJECT
		export
			{NONE} all
			{SYSTEM_OBJECT} get_type
		redefine
			finalize, equals, get_hash_code, to_string
		end
	
feature -- Access

	frozen generator: STRING is
			-- Name of current object's generating class
			-- (base class of the type of which it is a direct instance)
		do
 			create Result.make_from_cil (feature {ISE_RUNTIME}.generator (Current))
		ensure
			result_not_void: Result /= Void
		end

 	frozen generating_type: STRING is
			-- Name of current object's generating type
			-- (type of which it is a direct instance)
 		do
 			create Result.make_from_cil (feature {ISE_RUNTIME}.generating_type (Current))
 		ensure
 			result_not_void: Result /= Void
 		end

feature -- Status report

	frozen conforms_to (other: ANY): BOOLEAN is
			-- Does type of current object conform to type
			-- of `other' (as per Eiffel: The Language, chapter 13)?
		require
			other_not_void: other /= Void
		do
			Result := get_type.is_instance_of_type (other)
		end

	frozen same_type (other: ANY): BOOLEAN is
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
			Result := Current = other
			if not Result then
				Result := feature {ISE_RUNTIME}.standard_equal (Current, other)
			end
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
					Result := feature {ISE_RUNTIME}.deep_equal (some, other)
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
			feature {ISE_RUNTIME}.standard_copy (Current, other)
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
			feature {ISE_RUNTIME}.standard_copy (Current, other)
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
				Result ?= feature {ISE_RUNTIME}.standard_clone (other)
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
		do
			if other /= Void then
					-- No need for removing assertions checking
					-- as `standard_twin' will perform an atomic creation
				Result := other.standard_twin
			end
		ensure
			equal: standard_equal (Result, other)
		end

	frozen standard_twin: like Current is
			-- New object field-by-field identical to `other'.
			-- Always uses default copying semantics.
		do
				-- Built-in
			Result ?= memberwise_clone
		ensure
			standard_twin_not_void: Result /= Void
			equal: standard_equal (Result, Current)
		end

	frozen deep_clone (other: ANY): like other is
			-- Void if `other' is void: otherwise, new object structure
			-- recursively duplicated from the one attached to `other'
		do
			if other /= Void then
				Result ?= feature {ISE_RUNTIME}.deep_clone (other)
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
			Result := generating_type
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

feature {NONE} -- Disposal

	frozen finalize is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		local
			l_memory_object: MEMORY
		do
			l_memory_object ?= Current
			if l_memory_object /= Void then
				l_memory_object.dispose
			end
		end

feature {NONE} -- Implement .NET feature

	frozen equals (obj: SYSTEM_OBJECT): BOOLEAN is
			-- Compare `obj' to Current using Eiffel semantic.
		local
			l_other: like Current
		do
			l_other ?= obj
			if l_other /= Void then
				Result := get_type.equals_object (obj) and then is_equal (l_other)
			end
		end

	frozen to_string: SYSTEM_STRING is
			-- New string containing terse printable representation
			-- of current object
		do
			Result := out.to_cil
		end
		
	frozen get_hash_code: INTEGER is
			-- Hash code value.
		local
			h: HASHABLE
		do
			h ?= Current
			if h /= Void then
				Result := h.hash_code
			else
				Result := Precursor {SYSTEM_OBJECT}
			end
		end
		
invariant
	reflexive_equality: standard_is_equal (Current)
	reflexive_conformance: conforms_to (Current)

end -- class ANY
