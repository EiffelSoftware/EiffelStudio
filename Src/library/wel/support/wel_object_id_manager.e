indexing
	description	: "Ancestor for every class using a 'Object vs Id' conversion in WEL."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
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

end -- class WEL_OBJECT_ID_MANAGER
