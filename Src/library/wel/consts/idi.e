indexing
	description: "Icon (IDI) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDI_CONSTANTS

feature -- Access

	Idi_application: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"IDI_APPLICATION"
		end

	Idi_hand: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"IDI_HAND"
		end

	Idi_question: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"IDI_QUESTION"
		end

	Idi_exclamation: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"IDI_EXCLAMATION"
		end

	Idi_asterisk: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"IDI_ASTERISK"
		end

end -- class WEL_IDI_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
