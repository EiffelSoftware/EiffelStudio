note

	description:

		"Scanners implemented with compressed tables"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999-2013, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_COMPRESSED_SCANNER

inherit

	LX_SCANNER
		rename
			yy_ec as yy_ec_template,
			yy_accept as yy_accept_template
		undefine
			reset,
			yy_set_content,
			yy_initialize
		end

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_scanner_skeleton,
			make_with_file as make_scanner_with_file_skeleton,
			make_with_buffer as make_scanner_with_buffer_skeleton
		redefine
			yy_initialize
		end

	LX_COMPRESSED_TABLES
		rename
			yy_nxt as yy_nxt_template,
			yy_chk as yy_chk_template,
			yy_base as yy_base_template,
			yy_def as yy_def_template,
			yy_ec as yy_ec_template,
			yy_meta as yy_meta_template,
			yy_accept as yy_accept_template,
			yy_acclist as yy_acclist_template
		export
			{LX_COMPRESSED_TABLES} all
			{ANY}
				to_tables,
				from_tables
		end

create

	make,
	make_with_file,
	make_with_buffer

feature {NONE} -- Initialization

	yy_initialize
			-- Initialize lexical analyzer.
		do
			yyReject_or_variable_trail_context := yyReject_used or yyVariable_trail_context
				-- The parent part is there only to work around
				-- a bug in ISE 5.5.
			precursor {YY_COMPRESSED_SCANNER_SKELETON}
		end

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		local
			an_array: detachable ARRAY [INTEGER]
		do
			yy_nxt := yy_fixed_array (yy_nxt_template)
			yy_chk := yy_fixed_array (yy_chk_template)
			yy_base := yy_fixed_array (yy_base_template)
			yy_def := yy_fixed_array (yy_def_template)
			an_array := yy_ec_template
			if an_array /= Void then
				yy_ec := yy_fixed_array (an_array)
			end
			an_array := yy_meta_template
			if an_array /= Void then
				yy_meta := yy_fixed_array (an_array)
			end
			yy_accept := yy_fixed_array (yy_accept_template)
			an_array := yy_acclist_template
			if an_array /= Void then
				yy_acclist := yy_fixed_array (an_array)
			end
		end

feature {NONE} -- Constants

	yyReject_or_variable_trail_context: BOOLEAN
			-- Is `reject' called or is there a regular expression with
			-- both leading and trailing parts having variable length?

end
