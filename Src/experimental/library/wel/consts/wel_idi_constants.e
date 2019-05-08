note
	description: "Icon (IDI) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDI_CONSTANTS

feature -- Access

	frozen Idi_application: POINTER
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_APPLICATION"
		ensure
			is_class: class
		end

	frozen Idi_hand, frozen Idi_error: POINTER
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_HAND"
		ensure
			is_class: class
		end

	frozen Idi_question: POINTER
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_QUESTION"
		ensure
			is_class: class
		end

	frozen Idi_exclamation, frozen Idi_warning: POINTER
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_EXCLAMATION"
		ensure
			is_class: class
		end

	frozen Idi_asterisk, frozen Idi_information: POINTER
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDI_ASTERISK"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
