indexing

	description: "Syntax error for verbatim string: Verbatim_string_closer missing"
	date: "$Date$"
	revision: "$Revision$"

class VERBATIM_STRING_UNCOMPLETED

inherit

	SYNTAX_ERROR
		redefine
			syntax_message
		end

creation {ERROR_HANDLER}

	init

creation

	make

feature -- Access

	syntax_message: STRING is
			-- Specific syntax message
		do
			Result := "incomplete verbatim string: missing Verbatim_string_closer"
		end

end -- class VERBATIM_STRING_UNCOMPLETED


--|----------------------------------------------------------------
--| Copyright (C) 2000, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
