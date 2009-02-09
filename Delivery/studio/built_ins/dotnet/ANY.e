class
	ANY

feature -- Access

	generator: STRING is
			-- Name of current object's generating class
			-- (base class of the type of which it is a direct instance)
		do
			Result := {ISE_RUNTIME}.generator (Current)
		end

 	generating_type: STRING is
			-- Name of current object's generating type
			-- (type of which it is a direct instance)
		do
			Result := {ISE_RUNTIME}.generating_type (Current)
 		end

feature -- Status report

	conforms_to (other: ANY): BOOLEAN is
			-- Does type of current object conform to type
			-- of `other' (as per Eiffel: The Language, chapter 13)?
		local
			l_cur: SYSTEM_OBJECT
			l_cur_type: SYSTEM_TYPE
		do
			l_cur := Current
			l_cur_type := l_cur.get_type
			check l_cur_type_attached: l_cur_type /= Void end
			Result := l_cur_type.is_instance_of_type (other)
		end

	same_type (other: ANY): BOOLEAN is
			-- Is type of current object identical to type of `other'?
		local
			l_cur, l_other: SYSTEM_OBJECT
			l_cur_type, l_other_type: ?SYSTEM_TYPE
		do
			l_cur := Current
			l_cur_type := l_cur.get_type
			l_other := other
			l_other_type := l_other.get_type
			check
				l_cur_type_attached: l_cur_type /= Void
				l_other_type_attached: l_other_type /= Void
			end
			Result := l_cur_type.is_instance_of_type (other) and then
				l_other_type.is_instance_of_type (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object, and field-by-field identical to it?
		do
			Result := standard_is_equal (other)
		end

	frozen standard_is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object, and field-by-field identical to it?
		do
			Result := Current = other
			if not Result then
				Result := {ISE_RUNTIME}.standard_is_equal (Current, other)
			end
		end

	frozen is_deep_equal (other: like Current): BOOLEAN is
			-- Are `Current' and `other' attached to isomorphic object structures?
		do
			Result := {ISE_RUNTIME}.deep_equal (Current, Current, other)
		end

feature -- Duplication

	frozen twin: like Current is
			-- New object equal to `Current'
			-- `twin' calls `copy'; to change copying/twining semantics, redefine `copy'.
		local
			l_temp: BOOLEAN
			l_result: ?like Current
		do
			l_temp := {ISE_RUNTIME}.check_assert (False)
			l_result ?= {ISE_RUNTIME}.standard_clone (Current)
			check l_result_attached: l_result /= Void end
			l_result.copy (Current)
			Result := l_result
			l_temp := {ISE_RUNTIME}.check_assert (l_temp)
		end

	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		do
			{ISE_RUNTIME}.standard_copy (Current, other)
		end

	frozen standard_copy (other: like Current) is
			-- Copy every field of `other' onto corresponding field
			-- of current object.
		do
			{ISE_RUNTIME}.standard_copy (Current, other)
		end

	frozen standard_twin: like Current is
			-- New object field-by-field identical to `other'.
			-- Always uses default copying semantics.
		local
			l_result: ?like Current
		do
			check l_result_not_void: l_result /= Void end
			Result := l_result
		end

	frozen deep_twin: like Current is
			-- New object structure recursively duplicated from Current.
		local
			l_result: ?like Current
		do
			l_result ?= {ISE_RUNTIME}.deep_twin (Current)
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

feature -- Output

	frozen tagged_out: STRING is
			-- New string containing terse printable representation
			-- of current object
		do
			Result := generating_type
		end

end
