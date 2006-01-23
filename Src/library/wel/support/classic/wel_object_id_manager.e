indexing
	description	: "Ancestor for every class using a 'Object vs Id' conversion in WEL."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_OBJECT_ID_MANAGER

feature {NONE} -- External

	eif_id_object (an_id: INTEGER): ANY is
			-- Object associated with `an_id'
		external
			"C | %"eif_object_id.h%""
		end

	eif_object_id (an_object: ANY): INTEGER is
			-- New identifier for `an_object'
		external
			"C | %"eif_object_id.h%""
		end

	eif_object_id_free (an_id: INTEGER) is
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




end -- class WEL_OBJECT_ID_MANAGER

