note

	description:

		"Scanners implemented with full tables"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999-2013, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_FULL_SCANNER

inherit

	LX_SCANNER
		rename
			yy_ec as yy_ec_template,
			yy_accept as yy_accept_template
		undefine
			reset
		end

	YY_FULL_SCANNER_SKELETON
		rename
			make as make_scanner_skeleton,
			make_with_file as make_scanner_with_file_skeleton,
			make_with_buffer as make_scanner_with_buffer_skeleton
		end

	LX_FULL_TABLES
		rename
			yy_nxt as yy_nxt_template,
			yy_ec as yy_ec_template,
			yy_accept as yy_accept_template
		export
			{LX_FULL_TABLES} all
			{ANY}
				to_tables,
				from_tables
		end

create

	make,
	make_with_file,
	make_with_buffer

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		local
			an_array: detachable ARRAY [INTEGER]
		do
			yy_nxt := yy_fixed_array (yy_nxt_template)
			an_array := yy_ec_template
			if an_array /= Void then
				yy_ec := yy_fixed_array (an_array)
			end
			yy_accept := yy_fixed_array (yy_accept_template)
		end

end
