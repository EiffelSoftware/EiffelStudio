indexing

	description: "Eiffel classname finders"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CLASSNAME_FINDER

inherit

	CLASSNAME_FINDER_SKELETON

creation

	make


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= IN_CLASS)
		end

feature {NONE} -- Implementation

	yy_build_tables is
			-- Build scanner tables.
		do
			yy_nxt ?= yy_nxt_template
			yy_chk ?= yy_chk_template
			yy_base ?= yy_base_template
			yy_def ?= yy_def_template
			yy_ec ?= yy_ec_template
			yy_meta ?= yy_meta_template
			yy_accept ?= yy_accept_template
		end

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line 29

				set_start_condition (IN_CLASS)
			
when 2 then
--|#line 33

				classname := text
				last_token := TE_ID
			
when 3 then
--|#line 38
-- Ignore
when 4 then
--|#line 39
-- Ignore
when 5 then
--|#line 42
-- Ignore
when 6 then
--|#line 43
-- Ignore
when 7 then
--|#line 44
-- Ignore
when 8 then
--|#line 45
-- Ignore
when 9 then
--|#line 46
-- Ignore
when 10 then
--|#line 0
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    6,    7,    6,    8,    8,    9,   10,    6,    6,
			   11,   11,   12,   11,   11,    6,   11,   11,   12,   11,
			   11,   13,    7,   13,    8,    8,    9,   10,   13,   13,
			   14,   14,   14,   14,   14,   13,   14,   14,   14,   14,
			   14,   18,   19,   15,   35,   15,   25,   18,   19,   27,
			   15,   20,   25,   29,   24,   32,   30,   31,   33,   28,
			   24,   15,   30,   15,   33,   17,   31,   34,   15,   20,
			   32,   15,   24,   34,   16,   22,   15,   21,   24,   17,
			   16,   17,   17,   17,   17,   17,   17,   20,   35,   20,
			   35,   20,   20,   20,   20,   23,   24,   24,   24,   35,

			   23,   23,   23,   26,   26,   26,   22,   35,   22,   22,
			   22,   22,   22,   22,    5,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35>>)
		end

	yy_chk_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    8,    8,   11,   19,   11,   12,   17,   17,   19,
			   11,   21,   12,   21,   11,   29,   25,   27,   30,   20,
			   11,   23,   25,   23,   30,   31,   31,   33,   23,   32,
			   32,   36,   23,   33,   16,   10,   36,    9,   23,   37,
			    7,   37,   37,   37,   37,   37,   37,   38,    5,   38,
			    0,   38,   38,   38,   38,   39,   40,   40,   40,    0,

			   39,   39,   39,   41,   41,   41,   42,    0,   42,   42,
			   42,   42,   42,   42,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   20,    0,   88,    0,   78,   37,   72,
			   68,   42,   33,  114,    0,    0,   72,   43,  114,   41,
			   53,   45,    0,   60,    0,   46,    0,   48,  114,   46,
			   44,   57,   61,   53,    0,  114,   70,   78,   86,   94,
			   90,   97,  105>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,   35,    1,   35,    3,   35,   36,   35,   37,   38,
			   35,   39,   40,   35,   41,   36,   35,   37,   35,   37,
			   35,   38,   42,   39,   40,   40,   41,   35,   35,   35,
			   40,   35,   35,   40,   40,    0,   35,   35,   35,   35,
			   35,   35,   35>>)
		end

	yy_ec_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    2,    1,    1,    3,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    4,    1,    1,    5,    1,    6,
			    1,    1,    1,    1,    1,    7,    1,    8,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    1,    1,
			    1,    1,    1,    1,    1,   10,   11,   12,   11,   11,
			   11,   11,   11,   11,   11,   11,   13,   11,   11,   11,
			   11,   11,   11,   14,   11,   11,   11,   11,   11,   11,
			   11,    1,    1,    1,    1,   15,    1,   16,   17,   18,

			   17,   17,   17,   17,   17,   17,   17,   17,   19,   17,
			   17,   17,   17,   17,   17,   20,   17,   17,   17,   17,
			   17,   17,   17,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1>>)
		end

	yy_meta_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    1,    3,    3,    4,    5,    1,    6,
			    6,    6,    7,    6,    6,    6,    6,    6,    8,    6,
			    6>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    3,    3,    0,    0,   11,    3,    8,    9,    9,
			    9,    3,    4,    9,    2,    3,    8,    0,    5,    5,
			    0,    0,    7,    3,    4,    4,    2,    0,    6,    0,
			    4,    0,    0,    4,    1,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 114
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 35
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 36
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is false
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is false
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 10
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 11
			-- End of buffer rule code

	INITIAL: INTEGER is 0
	IN_CLASS: INTEGER is 1
			-- Start condition codes

feature -- User-defined features



end -- class CLASSNAME_FINDER


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
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
