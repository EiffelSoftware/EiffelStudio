indexing

	description: "Shared Lace parser"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_LACE_PARSER

feature -- Access

	Parser: LACE_PARSER is
			-- Lace parser
		once
			!! Result.make
		ensure
			lace_parser_not_void: Result /= Void
		end

	Classname_finder: CLASSNAME_FINDER is
			-- Classname finder
		once
			!! Result.make
		ensure
			classname_finder_not_void: Result /= Void
		end

end -- class SHARED_LACE_PARSER


--|----------------------------------------------------------------
--| Copyright (C) 1999, Interactive Software Engineering Inc.
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
