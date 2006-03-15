indexing
	description: "WEL way to identify objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDENTIFIED

feature {NONE} -- For weak references

	frozen eif_id_object (an_id: INTEGER): WEL_WINDOW is
			-- Object associated with `an_id'
		external
			"C | %"eif_object_id.h%""
		end

	frozen eif_id_any_object (an_id: INTEGER): ANY is
			-- Object associated with `an_id'
		external
			"C | %"eif_object_id.h%""
		alias
			"eif_id_object"
		end

	frozen eif_object_id (an_object: ANY): INTEGER is
			-- New identifier for `an_object'
		external
			"C | %"eif_object_id.h%""
		end

	frozen eif_object_id_free (an_id: INTEGER) is
			-- Free the entry `an_id'
		external
			"C | %"eif_object_id.h%""
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_IDENTIFIED

