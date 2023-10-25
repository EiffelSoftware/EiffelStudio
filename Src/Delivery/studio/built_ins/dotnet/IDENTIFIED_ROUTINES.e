class
	IDENTIFIED_ROUTINES

feature -- Basic operations

	eif_id_object (an_id: INTEGER): detachable ANY
			-- Object associated with `an_id'
		local
			unused: POINTER
		do
			Result := {ISE_RUNTIME}.builtin_IDENTIFIED_ROUTINES_eif_id_object (unused, an_id)
		end

	eif_object_id (an_object: ANY): INTEGER
			-- New identifier for `an_object'
		local
			unused: POINTER
		do
			Result := {ISE_RUNTIME}.builtin_IDENTIFIED_ROUTINES_eif_object_id (unused, an_object)
		end

	eif_object_id_free (an_id: INTEGER)
			-- Free the entry `an_id'
		local
			unused: POINTER
		do
			{ISE_RUNTIME}.builtin_IDENTIFIED_ROUTINES_eif_object_id_free (unused, an_id)
		end

end
