indexing
	description	: "Ancestor for every class using a 'Object vs Id' conversion in WEL."
	status		: "See notice at end of class."
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

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

