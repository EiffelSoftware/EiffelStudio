indexing
	description: "Icon (IDI) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	WEL_IDI_CONSTANTS

feature -- Access

	Idi_application: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_APPLICATION"
		end

	Idi_hand, Idi_error: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_HAND"
		end

	Idi_question: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_QUESTION"
		end

	Idi_exclamation, Idi_warning: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_EXCLAMATION"
		end

	Idi_asterisk, Idi_information: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_ASTERISK"
		end

end -- class WEL_IDI_CONSTANTS

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

