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
--|#line 41
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
			    0,   32,    7,   32,    8,    8,    9,   10,   17,   18,
			   17,   18,   11,   19,   22,   26,   16,   28,   11,    7,
			   22,    8,    8,    9,   10,   32,   27,   30,   31,   11,
			   24,   29,   27,   30,   31,   11,   12,    7,   12,    8,
			    8,    9,   10,   12,   12,   13,   13,   13,   13,   13,
			   12,   13,   13,   13,   13,   13,   19,   29,    6,    6,
			    6,    6,    6,    6,    6,    6,   14,   23,   23,   23,
			   28,   14,   16,   25,   16,   16,   16,   16,   16,   16,
			   19,   15,   19,   21,   19,   19,   19,   19,   21,   20,
			   21,   21,   21,   21,   21,   21,   15,   32,    5,   32,

			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32>>)
		end

	yy_chk_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    1,    0,    1,    1,    1,    1,    8,    8,
			   16,   16,    1,   20,   11,   20,   28,   28,    1,    2,
			   11,    2,    2,    2,    2,   18,   22,   27,   30,    2,
			   18,   26,   22,   27,   30,    2,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,   29,   29,   33,   33,
			   33,   33,   33,   33,   33,   33,   34,   37,   37,   37,
			   24,   34,   35,   19,   35,   35,   35,   35,   35,   35,
			   36,   15,   36,   10,   36,   36,   36,   36,   38,    9,
			   38,   38,   38,   38,   38,   38,    7,    5,   32,   32,

			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,   17,   35,    0,   97,    0,   94,    4,   84,
			   76,    1,   98,    0,    0,   79,    6,   98,   22,   67,
			    7,    0,   16,    0,   61,   98,   22,   13,    8,   48,
			   14,   98,   98,   57,   65,   71,   79,   61,   87>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,   33,   33,   32,    3,   32,   34,   32,   35,   36,
			   32,   32,   32,   37,   34,   32,   35,   32,   35,   32,
			   36,   38,   32,   37,   32,   32,   32,   32,   32,   32,
			   32,   32,    0,   32,   32,   32,   32,   32,   32>>)
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
			    0,    3,    3,    0,    0,   10,    3,    7,    8,    8,
			    8,    8,    8,    2,    3,    7,    0,    4,    4,    0,
			    0,    6,    0,    2,    0,    5,    0,    0,    0,    0,
			    0,    1,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 98
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 32
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 33
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

	yyNb_rules: INTEGER is 9
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 10
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
