indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDK_OBJECT_I

inherit
	DISPOSABLE

feature {NONE} -- Implementation

	property_flags: NATURAL_8
			-- Used for storing boolean flags to save on memory space.

	property_1_mask: NATURAL_8 = 0x1
	property_2_mask: NATURAL_8 = 0x2
	property_3_mask: NATURAL_8 = 0x4
	property_4_mask: NATURAL_8 = 0x8
	property_5_mask: NATURAL_8 = 0x10
	property_6_mask: NATURAL_8 = 0x20
	property_7_mask: NATURAL_8 = 0x40
	property_8_mask: NATURAL_8 = 0x80
		-- Masks used for boolean property retrieval

feature {NONE} -- Implementation

	is_underlying_implementation_initialized: BOOLEAN
			-- Has the underlying implementation for `Current' been initialized?
		do
			Result := session_id_internal /= default_pointer
		end

	create_underlying_implementation
			-- Create underlying implementation.
		do
			if not is_underlying_implementation_initialized then
				session_id_internal := session_id_internal + identified_routines.eif_object_id (Current)
				-- Create native handle by sending CREATE_WINDOW event to display.
				-- Initialize handle with respect to current registered properties.

				-- When properties and events have been registered we fire a EDK
			end
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
