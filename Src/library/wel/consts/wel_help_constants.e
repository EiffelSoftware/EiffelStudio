indexing
	description: "Help constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HELP_CONSTANTS

feature -- Access

	Help_context: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_CONTEXT"
		end

	Help_quit: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_QUIT"
		end

	Help_index: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_INDEX"
		end

	Help_contents: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_CONTENTS"
		end

	Help_helponhelp: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_HELPONHELP"
		end

	Help_setindex: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_SETINDEX"
		end

	Help_setcontents: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_SETCONTENTS"
		end

	Help_contextpopup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_CONTEXTPOPUP"
		end

	Help_forcefile: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_FORCEFILE"
		end

	Help_key: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_KEY"
		end

	Help_command: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_COMMAND"
		end

	Help_partialkey: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_PARTIALKEY"
		end

	Help_multikey: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_MULTIKEY"
		end

	Help_setwinpos: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HELP_SETWINPOS"
		end

end -- class WEL_HELP_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

