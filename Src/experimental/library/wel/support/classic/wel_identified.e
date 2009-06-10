note
	description: "WEL way to identify objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDENTIFIED

inherit
	ANY

	IDENTIFIED_ROUTINES
		rename
			eif_id_object as eif_id_any_object
		export
			{NONE} all
		end

feature {NONE} -- For weak references

	eif_is_object_id_of_current (an_id: INTEGER): BOOLEAN
			-- Is `an_id' the associated object ID of `Current'.
		obsolete
			"Use `eif_id_object (an_id) = Current' instead."
		require
			an_id_non_negative: an_id >= 0
		external
			"built_in"
		end

	eif_current_object_id: INTEGER
			-- New identifier for Current
		obsolete
			"Use `eif_object_id (Current)' instead."
		external
			"built_in"
		ensure
			eif_current_object_id: Result > 0
			inserted: eif_is_object_id_of_current (Result)
		end

	frozen eif_id_object (an_id: INTEGER): detachable WEL_WINDOW
			-- Object associated with `an_id'
		require
			an_id_non_negative: an_id >= 0
		do
			Result ?= eif_id_any_object (an_id)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

