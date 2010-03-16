note
	description: "Summary description for {EDK_SESSION_ID_OBJECT_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDK_SESSION_ID_OBJECT_I

inherit
	EDK_MESSAGE_SENDER


feature {NONE} -- Implementation

	is_underlying_implementation_initialized: BOOLEAN
			-- Has the underlying implementation for `Current' been initialized?
		do
			Result := session_id_internal /= default_pointer
		end

	create_underlying_implementation
			-- Create underlying implementation.
		require
			underlying_implementation_uninitialized: not is_underlying_implementation_initialized
		do
			-- Do nothing by default
			--| FIXME Should be deferred.
		end

	session_id: INTEGER_32
			-- Weak reference value for `Current' in this session.
		do
			if session_id_internal = default_pointer then
				session_id_internal := session_id_internal + identified_routines.eif_object_id (Current)
			end
			Result := session_id_internal.to_integer_32
		end

	session_id_internal: POINTER
		-- Object IDENTIFIER for `Current'
		-- Used for session weak-referencing

	identified_routines: IDENTIFIED_ROUTINES
		note
			once_status: global
		once
			create Result
		end

	dispose
			-- <Precursor>
		do
			if session_id > 0 then
					-- Free session id.
				identified_routines.eif_object_id_free (session_id)
				session_id_internal := default_pointer
			end
		end

end
