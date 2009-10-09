class
	ANY

feature -- Access

	generator: STRING
			-- Name of current object's generating class
			-- (base class of the type of which it is a direct instance)
		do
			if attached {ISE_RUNTIME}.generator (Current) as l_string then
				Result := l_string
			else
				Result := "Unable to get class name"
			end
		end

 	generating_type: STRING
			-- Name of current object's generating type
			-- (type of which it is a direct instance)
		do
			if attached {ISE_RUNTIME}.generating_type (Current) as l_string then
				Result := l_string
			else
				Result := "Unable to get type name"
			end
 		end

feature -- Status report

	conforms_to (other: ANY): BOOLEAN
			-- Does type of current object conform to type
			-- of `other' (as per Eiffel: The Language, chapter 13)?
		local
			l_cur: SYSTEM_OBJECT
		do
			l_cur := Current
			if attached l_cur.get_type as l_cur_type then
				Result := l_cur_type.is_instance_of_type (other)
			end
		end

	same_type (other: ANY): BOOLEAN
			-- Is type of current object identical to type of `other'?
		local
			l_cur, l_other: SYSTEM_OBJECT
		do
			l_cur := Current
			l_other := other
			if attached l_cur.get_type as l_cur_type and attached l_other.get_type as l_other_type then
				Result := l_cur_type.is_instance_of_type (other) and then
					l_other_type.is_instance_of_type (Current)
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object, and field-by-field identical to it?
		do
			Result := standard_is_equal (other)
		end

	frozen standard_is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object, and field-by-field identical to it?
		do
			Result := Current = other
			if not Result then
				Result := {ISE_RUNTIME}.standard_is_equal (Current, other)
			end
		end

	frozen is_deep_equal (other: like Current): BOOLEAN
			-- Are `Current' and `other' attached to isomorphic object structures?
		do
			Result := {ISE_RUNTIME}.deep_equal (Current, Current, other)
		end

feature -- Duplication

	frozen twin: like Current
			-- New object equal to `Current'
			-- `twin' calls `copy'; to change copying/twining semantics, redefine `copy'.
		local
			l_temp: BOOLEAN
			l_result: detachable like Current
		do
			l_temp := {ISE_RUNTIME}.check_assert (False)
			l_result ?= {ISE_RUNTIME}.standard_clone (Current)
			check l_result_attached: l_result /= Void end
			l_result.copy (Current)
			Result := l_result
			l_temp := {ISE_RUNTIME}.check_assert (l_temp)
		end

	copy (other: like Current)
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		do
			{ISE_RUNTIME}.standard_copy (Current, other)
		end

	frozen standard_copy (other: like Current)
			-- Copy every field of `other' onto corresponding field
			-- of current object.
		do
			{ISE_RUNTIME}.standard_copy (Current, other)
		end

	frozen standard_twin: like Current
			-- New object field-by-field identical to `other'.
			-- Always uses default copying semantics.
		local
			l_result: detachable like Current
		do
			check l_result_not_void: l_result /= Void end
			Result := l_result
		end

	frozen deep_twin: like Current
			-- New object structure recursively duplicated from Current.
		local
			l_result: detachable like Current
		do
			l_result ?= {ISE_RUNTIME}.deep_twin (Current)
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

feature -- Output

	frozen tagged_out: STRING
			-- New string containing terse printable representation
			-- of current object
		do
			Result := generating_type
		end

end
