class IDENTIFIED_ROUTINES

feature -- Basic operations

	eif_id_object (an_id: INTEGER): ANY
			-- Object associated with `an_id'
		external
			"C use %"eif_object_id.h%""
		end

	eif_object_id (an_object: ANY): INTEGER
			-- New identifier for `an_object'
		external
			"C use %"eif_object_id.h%""
		end

	eif_object_id_free (an_id: INTEGER)
			-- Free the entry `an_id'
		external
			"C use %"eif_object_id.h%""
		end

end
