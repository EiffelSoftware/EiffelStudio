indexing
	description: "Help context, contains path to .chm file"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_HELP_CONTEXT

inherit
	EV_HELP_CONTEXT
		undefine
			out,
			copy,
			is_equal
		end

	STRING

create
	make_from_string

convert
	to_cil: {SYSTEM_STRING}

end -- class CODE_HELP_CONTEXT

--+--------------------------------------------------------------------
--| CodeDom Tools Library
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------