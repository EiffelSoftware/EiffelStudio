indexing
	description: "WEL way to identify objects"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDENTIFIED

feature -- For weak references

	eif_id_object (an_id: INTEGER): WEL_WINDOW is
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

end -- class WEL_IDENTIFIED
