indexing
	description: "Icon (IDI) constants."
	legal: "See notice at end of class."
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




end -- class WEL_IDI_CONSTANTS

