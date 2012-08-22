note

	description:

		"Full tables for scanners"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_FULL_TABLES

inherit

	LX_TABLES

create

	make_from_tables

feature -- Tables

	yy_nxt: ARRAY [INTEGER]
			-- States to enter upon reading symbol;
			-- indexed by (current_state_id * yyNb_rows + symbol)

feature -- Constants

	yyNb_rows: INTEGER
			-- Number of rows in `yy_nxt'

	yyBacking_up: BOOLEAN
			-- Does the scanner back up?
			-- (i.e. does it have non-accepting states)

feature -- Conversion

	from_tables (other: like to_tables)
			-- Set current tables with those of `other'.
		do
			yy_nxt := other.yy_nxt
			yy_accept := other.yy_accept
			yy_ec := other.yy_ec
			yy_rules := other.yy_rules
			yy_eof_rules := other.yy_eof_rules
			yy_start_conditions := other.yy_start_conditions
			yyNull_equiv_class := other.yyNull_equiv_class
			yyNb_rules := other.yyNb_rules
			yyEnd_of_buffer := other.yyEnd_of_buffer
			yyNb_rows := other.yyNb_rows
			yyBacking_up := other.yyBacking_up
			yyLine_used := other.yyLine_used
			yyPosition_used := other.yyPosition_used
		end

	to_tables: LX_FULL_TABLES
			-- New full tables made from current tables
		do
			create Result.make_from_tables (Current)
		end

invariant

	yy_nxt_not_void: yy_nxt /= Void

end
