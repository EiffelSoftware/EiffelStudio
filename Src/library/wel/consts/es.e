indexing
	description: "Edit control style (ES) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ES_CONSTANTS

feature -- Access

	Es_left: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_LEFT"
		end

	Es_center: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_CENTER"
		end

	Es_right: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_RIGHT"
		end

	Es_multiline: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_MULTILINE"
		end

	Es_uppercase: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_UPPERCASE"
		end

	Es_lowercase: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_LOWERCASE"
		end

	Es_password: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_PASSWORD"
		end

	Es_autovscroll: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_AUTOVSCROLL"
		end

	Es_autohscroll: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_AUTOHSCROLL"
		end

	Es_nohidesel: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_NOHIDESEL"
		end

	Es_oemconvert: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_OEMCONVERT"
		end

	Es_readonly: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_READONLY"
		end

	Es_wantreturn: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ES_WANTRETURN"
		end

end -- class WEL_ES_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
