indexing
	description: "Scanners for external parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_SCANNER

inherit

    YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			reset
		end

	EXTERNAL_TOKENS
		export {NONE} all end

create
    make

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (sc = INITIAL)
		end

feature {NONE} -- Implementation

	yy_build_tables is
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
		end

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

when 2 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

when 3 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_COLON
			
when 4 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_LPARAN
			
when 5 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_RPARAN
			
when 6 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_COMMA
			
when 7 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_STAR
			
when 8 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_ADDRESS
			
when 9 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_LT
			
when 10 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_GT
			
when 11 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_DQUOTE
			
when 12 then
	yy_position := yy_position + 6
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_ACCESS
			
when 13 then
	yy_position := yy_position + 8
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_BLOCKING
			
when 14 then
	yy_position := yy_position + 8
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_BUILT_IN
			
when 15 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_C_LANGUAGE
			
when 16 then
	yy_position := yy_position + 16
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_C_LANGUAGE
			
when 17 then
	yy_position := yy_position + 22
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_C_LANGUAGE
			
when 18 then
	yy_position := yy_position + 3
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_CPP_LANGUAGE
			
when 19 then
	yy_position := yy_position + 5
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_CONST
			
when 20 then
	yy_position := yy_position + 7
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_CREATOR
			
when 21 then
	yy_position := yy_position + 8
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_DEFERRED
			
when 22 then
	yy_position := yy_position + 6
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_DELETE
			
when 23 then
	yy_position := yy_position + 3
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_DLL_LANGUAGE
			
when 24 then
	yy_position := yy_position + 6
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_DLLWIN_LANGUAGE
			
when 25 then
	yy_position := yy_position + 4
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_ENUM
			
when 26 then
	yy_position := yy_position + 5
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_FIELD
			
when 27 then
	yy_position := yy_position + 12
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_GET_PROPERTY
			
when 28 then
	yy_position := yy_position + 2
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_IL_LANGUAGE
			
when 29 then
	yy_position := yy_position + 6
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_INLINE
			
when 30 then
	yy_position := yy_position + 3
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_JAVA_LANGUAGE
			
when 31 then
	yy_position := yy_position + 5
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_MACRO
			
when 32 then
	yy_position := yy_position + 8
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_OPERATOR
			
when 33 then
	yy_position := yy_position + 9
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_SET_FIELD
			
when 34 then
	yy_position := yy_position + 12
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_SET_PROPERTY
			
when 35 then
	yy_position := yy_position + 16
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_SET_STATIC_FIELD
			
when 36 then
	yy_position := yy_position + 9
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_SIGNATURE
			
when 37 then
	yy_position := yy_position + 6
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_SIGNED
			
when 38 then
	yy_position := yy_position + 6
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_STATIC
			
when 39 then
	yy_position := yy_position + 12
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_STATIC_FIELD
			
when 40 then
	yy_position := yy_position + 6
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_STRUCT
			
when 41 then
	yy_position := yy_position + 4
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_TYPE
			
when 42 then
	yy_position := yy_position + 8
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_UNSIGNED
			
when 43 then
	yy_position := yy_position + 3
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				last_token := TE_USE
			
when 44 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_INTEGER
			
when 45 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

					-- To escape external keywords.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_ID
			
when 46 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

					-- Traditional identifier
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_ID
			
when 47 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

					-- Special identifier for include files that specifies
					-- a path, e.g. <sys/timeb.h>, <windows\file.h>, or path
					-- that includes an hyphenation.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_FILE_ID
			
when 48 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end

when 49 then
	yy_position := yy_position + 1
--|#line <not available> "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line <not available>")
end
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
			terminate
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1919)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,    4,    5,    6,    5,    7,    8,    9,   10,   11,
			   12,   13,   14,   13,   13,   13,   15,   16,   17,   13,
			   18,   19,   20,   21,   22,   23,   24,   25,   26,   15,
			   27,   28,   15,   15,   29,   15,   30,   15,   15,   15,
			   31,   32,   33,   15,   15,   15,   13,   13,   13,   15,
			   20,   21,   34,   23,   24,   25,   26,   15,   27,   28,
			   15,   15,   29,   15,   30,   15,   15,   15,   35,   32,
			   36,   15,   15,   15,   37,   40,   37,   44,   40,   40,
			   41,   41,   42,   40,   42,   42,   42,   42,   42,   44,
			   42,   40,   42,   42,   42,   40,   40,   46,   42,   98,

			   42,   49,   42,   42,   42,   42,   37,   41,   37,   39,
			   43,   70,   54,   42,   38,   52,   42,   45,   47,   42,
			   42,   40,   53,   43,   42,   46,   40,   48,   42,   50,
			   42,   39,   42,   42,   38,   42,   42,   42,  236,   51,
			   54,  236,  236,   52,   40,   55,   47,   40,  236,  236,
			   53,   42,   40,   42,   42,   48,   42,   50,  236,   42,
			  236,   42,   42,   59,   56,  236,  236,   42,   60,  236,
			   40,  236,  236,   55,   57,   40,   58,   42,  236,   42,
			   40,  236,   42,  236,   42,   42,  236,   42,   42,   42,
			  236,   59,   56,   42,  236,   62,   60,  236,   40,   63,

			  236,   61,   57,  236,   58,   42,  236,   42,   40,  236,
			   64,   42,  236,   49,  236,   42,   42,   42,  236,   65,
			  236,   42,  236,   62,   40,  236,  236,   63,  236,   61,
			  236,   42,   66,   42,  236,  236,   40,  236,   64,   42,
			  236,   50,  236,   42,   62,   42,  236,   65,   63,   42,
			  236,   51,  236,  236,   40,  236,  236,  236,  236,   64,
			   66,   42,  236,   42,  236,   42,   67,  236,  236,   50,
			   66,  236,   62,   71,  236,  236,   68,   42,   44,  236,
			  236,   44,  236,  236,   71,  236,   44,   64,  236,   44,
			  236,  236,   44,   69,   45,   42,   40,   44,   66,   40,

			  236,  236,  236,   42,  236,   42,   42,  236,   42,   40,
			  236,  236,   40,   44,   72,   44,   42,   75,   42,   42,
			  236,   42,  236,   40,   44,  236,   44,   40,  236,   73,
			   42,  236,   42,   74,   42,  236,   42,   42,  236,   40,
			   42,  236,   72,   76,  236,   40,   42,  236,   42,   40,
			   42,   77,   42,   42,   42,  236,   42,   73,   42,  236,
			   79,   74,  236,  236,   42,   78,   80,   40,   42,  236,
			  236,   76,   81,  236,   42,   40,   42,  236,  236,   77,
			   42,  236,   42,  236,   42,   82,   42,   83,   79,   40,
			   42,  236,   40,   78,   80,   40,   42,  236,   42,   42,

			   81,   42,   42,  236,   42,   40,  236,  236,   42,  236,
			   84,   40,   42,   82,   42,   83,   42,   40,   42,   85,
			   42,  236,  236,   86,   42,   88,   42,  236,   40,   87,
			   42,  236,  236,   42,   40,   42,   42,   42,   84,   90,
			  236,   42,  236,   42,  236,  236,   42,   85,  236,  236,
			  236,   86,   42,   88,  236,   40,  236,   87,   42,   40,
			  236,  236,   42,   89,   42,   93,   42,   90,   42,   42,
			  236,   91,  236,   40,  236,   42,   40,   40,  236,   94,
			   42,  236,   42,   42,   42,   42,   42,  236,   92,  236,
			  236,   89,  236,   93,   40,   40,   42,  236,   90,   91,

			   42,   42,   42,   42,   42,  236,  236,   94,  236,  236,
			  236,  236,  100,  236,   42,   99,   92,   42,   42,  236,
			   40,  236,  236,  236,   40,   40,   96,   42,  236,   42,
			   95,   42,   42,   42,   42,   42,   42,  236,  236,   97,
			  100,  102,   40,   99,  236,  236,   40,  101,  236,   42,
			   40,   42,  236,   42,  236,   42,  236,   42,  236,   42,
			  236,   42,  236,  236,  236,   42,   42,   40,  236,  102,
			  104,  103,   40,   40,   42,  101,   42,   40,  236,   42,
			   42,   42,   42,   42,   42,  236,   42,   42,  107,  236,
			  236,   42,  105,  106,   40,  108,  236,  236,  104,  103,

			   40,   42,  236,   42,  109,  236,  236,   42,   42,   42,
			   40,  236,  236,   42,   42,  236,  107,   42,   42,   42,
			  105,  106,   40,  108,  111,  236,  236,   40,  236,   42,
			  236,   42,  109,   40,   42,   42,   42,  110,   40,   40,
			   42,   42,   42,  236,  236,   42,   42,   42,   42,   40,
			   40,   42,  111,  236,  236,  112,   42,   42,   42,   42,
			  113,  236,  236,   42,   40,  236,  236,  115,   42,  236,
			  118,   42,  236,   42,   42,  117,  114,  236,   40,   42,
			   42,  236,  236,  112,  116,   42,  236,   42,  113,  236,
			   42,   42,   40,   40,  236,  115,  236,   40,  118,   42,

			   42,   42,   42,  117,   42,   42,   42,  236,  236,   40,
			  236,  236,  116,   40,  236,  236,   42,   40,   42,   42,
			   42,  115,   42,  236,   42,  236,   42,  236,  236,  236,
			   40,  122,  236,   42,   42,  123,  236,   42,   42,   42,
			  119,  236,  236,  236,  236,  121,   40,  236,  124,  120,
			   42,  236,  125,   42,   42,   42,  236,  126,   42,  122,
			   40,   40,  236,  123,  236,   40,   40,   42,   42,   42,
			   42,   42,   42,   42,   42,   42,  124,  236,  236,   40,
			  125,  127,  236,  236,  236,  126,   42,   42,   42,  130,
			   40,  236,  236,  128,  236,  236,  129,   42,  131,   42,

			  236,   42,   42,   40,  236,  236,   42,   42,  236,  127,
			   42,  236,   42,  236,  236,  236,   40,  130,  236,  133,
			   42,  128,  236,   42,  129,   42,  131,  236,  236,   40,
			   40,   42,  236,  236,  132,  236,   42,   42,   42,   42,
			  236,  236,  236,   40,   42,  135,  134,  133,  236,  236,
			   42,  136,   42,  236,  236,  236,   40,   42,  236,  139,
			   40,  137,  132,   42,  138,   42,  236,   42,   40,   42,
			   42,   42,  236,  135,  134,   42,   40,   42,  141,  136,
			  140,   40,  236,   42,   42,   42,   40,  139,   42,  137,
			   42,   40,  138,   42,  236,   42,   40,   42,   42,  236,

			   42,   42,  139,   42,   40,   42,  141,  236,  140,   42,
			  236,   42,  236,   42,   40,  236,  236,   42,  236,   40,
			  146,   42,   42,   42,  236,  145,   42,   42,   42,   40,
			  139,  144,   42,   40,  143,  236,   42,   42,   42,  142,
			   42,  236,   42,  149,  148,   42,  236,  147,  146,   40,
			   40,  236,  150,  145,   40,   42,   42,   42,   42,   42,
			   42,   42,  236,   42,  236,  236,  151,  236,   40,  152,
			   42,  149,  148,  236,   42,   42,   40,   42,  236,  153,
			  150,  236,  236,   42,  236,   42,  236,  236,  236,  236,
			   42,   42,  236,   40,  151,   42,  155,  152,  236,   40, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   42,  154,   42,   40,   40,  236,   42,  153,   42,   42,
			   42,   42,   42,   42,  236,  236,  236,   42,   40,   40,
			  236,  236,  236,  157,  155,   42,   42,   42,   42,  154,
			  236,  236,   40,  236,   42,  236,  236,  158,  156,   42,
			   42,   42,  236,  236,   42,   42,  236,  236,   40,   40,
			  161,  157,  236,  159,  160,   42,   42,   42,   42,   42,
			   42,   40,   40,  236,  236,  158,  156,  236,   42,   42,
			   42,   42,  236,   42,  236,  236,  236,   40,  161,  236,
			  236,  159,  160,  162,   42,   40,   42,  236,   40,   42,
			   42,   40,   42,  236,   42,   42,  236,   42,   42,  236,

			   42,  236,   42,   42,  236,  236,   40,  236,  163,  236,
			  236,  162,  166,   42,  165,   42,   40,  236,   42,  164,
			  236,   40,  236,   42,  167,   42,   42,   40,   42,   42,
			   42,  236,   42,  236,   42,  168,   42,  236,  236,  236,
			  166,  170,  165,  236,   40,  236,  169,   42,  236,   40,
			  236,   42,  167,   42,  236,  236,   42,   42,   42,  236,
			  236,  236,   42,  168,   40,  236,  236,  236,   42,  170,
			  236,   42,  236,   42,  169,   40,  236,  236,  236,  171,
			   40,  236,   42,  236,   42,   42,  236,   42,  236,   42,
			   42,  236,   40,   40,  236,  173,  236,  236,  236,   42,

			   42,   42,   42,  236,   40,   42,  236,  171,   40,  175,
			  172,   42,  236,   42,  236,   42,   42,   42,   40,   40,
			  236,   42,  174,  173,  236,   42,   42,   42,   42,  236,
			  236,  236,   40,   42,   42,   40,  236,  175,  172,   42,
			  176,   42,   42,  236,   42,   42,   40,   40,  236,   42,
			  174,  177,  236,   42,   42,   42,   42,  179,   40,   42,
			   42,  236,  236,  236,  236,   42,  236,   42,  176,  236,
			  236,  236,   40,   42,  236,  180,   42,   40,  181,   42,
			  178,   42,  236,  236,   42,  179,   42,   42,   42,  236,
			  236,   40,  236,  236,  236,  236,  183,  236,   42,   42,

			   42,  236,   40,  180,  236,  236,  181,   40,  182,   42,
			   40,   42,  236,   42,   42,  236,   42,   42,   42,   42,
			   40,  236,  184,  236,  183,  236,  236,   42,  236,   42,
			  236,   40,   42,  236,  186,  185,  182,   40,   42,  236,
			   42,  187,  236,   42,   42,  236,   42,   40,   42,  236,
			  184,   42,  236,  236,   42,  188,   42,  236,  190,   40,
			  236,   42,  186,  185,  189,  236,   42,   40,   42,  187,
			  236,  236,   42,   40,   42,  236,   42,  236,   42,  236,
			   42,  236,   42,  188,   40,  236,  190,  236,   42,   40,
			   40,   42,  189,   42,  191,   40,   42,   42,   42,   42,

			   42,  236,   42,  236,   42,  236,  236,  236,   42,   40,
			  194,  192,  236,   40,   42,  236,   42,   40,   42,  193,
			   42,  236,   42,  236,   42,   42,   42,  236,  195,  236,
			   42,   42,  236,  196,  236,   40,   42,  236,  194,  192,
			  236,  197,   42,  236,   42,  236,  236,  193,  236,  236,
			   42,  236,  236,   40,   42,  198,  195,   40,   42,  236,
			   42,  196,   42,   40,   42,  236,   42,  236,  236,  197,
			   42,   40,   42,  236,  236,   40,   42,  199,   42,   40,
			   42,  236,   42,  198,   42,  236,   42,  200,   42,  201,
			   40,  236,  236,   40,   42,  236,  236,   42,   42,   42,

			   42,  236,   42,  236,   42,  199,  236,  236,  202,  236,
			  236,  204,   42,  236,  236,  200,   42,  201,   40,  236,
			   42,   40,  236,  203,  236,   42,   40,   42,   42,  236,
			   42,   42,  236,   42,   42,   42,  202,   40,  236,  204,
			   40,  205,  236,  236,   42,   40,   42,   42,  236,   42,
			  236,  203,   42,  236,   42,  236,   40,   40,  236,   42,
			  236,  206,   42,   42,   42,   42,   42,   42,  236,  205,
			   40,  236,  236,  207,  236,  208,   40,   42,   42,   42,
			  209,   42,  236,   42,  211,   42,   42,   40,  236,  206,
			  236,  236,  236,  212,   42,   40,   42,   42,   42,  210,

			  236,  207,   42,  208,   42,  236,   40,  236,  209,  213,
			  236,   42,  211,   42,  236,   42,   40,   42,  236,  236,
			  236,  212,  236,   42,  236,   42,  214,  216,   42,  236,
			  236,   40,   40,  236,  215,  217,   42,  213,   42,   42,
			   42,   42,   40,   40,  236,  236,  236,   42,  236,   42,
			   42,   42,   42,  236,  214,  216,  236,   42,  236,   40,
			  236,  218,  215,  217,  236,  219,   42,   40,   42,  236,
			   40,  236,   42,   42,   42,  236,   42,   42,  236,   42,
			  236,   40,  236,   42,   42,   40,  236,  236,   42,  218,
			   42,  220,   42,  219,   42,   40,  236,  236,  236,  236,

			   42,  222,   42,   40,   42,  223,  221,  236,   42,  236,
			   42,   42,   42,  236,   40,  236,  236,  236,   40,  220,
			  236,   42,   42,   42,  236,   42,   42,   42,  236,  222,
			  224,   40,  225,  223,  221,  236,   42,  236,   42,   40,
			   42,  226,  236,   40,   42,  236,   42,   40,   42,  227,
			   42,  236,   42,  228,   42,   42,   42,   40,  224,   42,
			  225,   40,  229,  236,   42,  236,   42,   40,   42,  226,
			   42,  236,   42,  236,   42,  230,   42,  227,   40,  236,
			   42,  228,   40,  236,   42,   42,   40,   42,   42,   42,
			  229,   42,   40,   42,  231,   42,  236,  236,   42,   42,

			  232,   42,   42,  230,  236,  236,  233,  234,   42,  236,
			  236,  236,  236,  236,  236,  236,  236,  235,  236,   42,
			  236,  236,  231,   42,  236,  236,  236,   42,  232,  236,
			  236,  236,  236,   42,  233,  234,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  235,    3,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,

			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236, yy_Dummy>>,
			1, 920, 1000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1919)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    5,    9,    5,  239,   15,   20,
			  237,  237,    9,   24,    9,   15,   20,   15,   20,   98,
			   24,   21,   24,  238,  238,   23,   22,   20,   21,   71,

			   21,   22,   23,   22,   23,   22,   37,   70,   37,   43,
			   42,   40,   24,   39,   38,   23,    9,   19,   21,   15,
			   20,   25,   23,   13,   24,   20,   28,   21,   25,   22,
			   25,    8,   21,   28,    6,   28,   23,   22,    3,   22,
			   24,    0,    0,   23,   26,   25,   21,   27,    0,    0,
			   23,   26,   29,   26,   27,   21,   27,   22,    0,   29,
			    0,   29,   25,   28,   26,    0,    0,   28,   29,    0,
			   30,    0,    0,   25,   27,   31,   27,   30,    0,   30,
			   32,    0,   31,    0,   31,   26,    0,   32,   27,   32,
			    0,   28,   26,   29,    0,   31,   29,    0,   33,   31,

			    0,   30,   27,    0,   27,   33,    0,   33,   34,    0,
			   31,   30,    0,   34,    0,   34,   31,   34,    0,   32,
			    0,   32,    0,   31,   35,    0,    0,   31,    0,   30,
			    0,   35,   33,   35,    0,    0,   36,    0,   31,   33,
			    0,   34,    0,   36,   35,   36,    0,   32,   35,   34,
			    0,   34,    0,    0,   41,    0,    0,    0,    0,   35,
			   33,   41,    0,   41,    0,   35,   34,    0,    0,   34,
			   36,    0,   35,   44,    0,    0,   35,   36,   44,    0,
			    0,   44,    0,    0,   45,    0,   44,   35,    0,   45,
			    0,    0,   45,   36,   45,   41,   46,   45,   36,   47,

			    0,    0,    0,   46,    0,   46,   47,    0,   47,   48,
			    0,    0,   49,   44,   46,   44,   48,   49,   48,   49,
			    0,   49,    0,   50,   45,    0,   45,   51,    0,   47,
			   50,    0,   50,   48,   51,    0,   51,   46,    0,   52,
			   47,    0,   46,   50,    0,   53,   52,    0,   52,   54,
			   48,   51,   53,   49,   53,    0,   54,   47,   54,    0,
			   52,   48,    0,    0,   50,   51,   52,   55,   51,    0,
			    0,   50,   53,    0,   55,   56,   55,    0,    0,   51,
			   52,    0,   56,    0,   56,   54,   53,   55,   52,   57,
			   54,    0,   58,   51,   52,   59,   57,    0,   57,   58,

			   53,   58,   59,    0,   59,   61,    0,    0,   55,    0,
			   56,   60,   61,   54,   61,   55,   56,   63,   60,   58,
			   60,    0,    0,   59,   63,   61,   63,    0,   62,   60,
			   57,    0,    0,   58,   65,   62,   59,   62,   56,   63,
			    0,   65,    0,   65,    0,    0,   61,   58,    0,    0,
			    0,   59,   60,   61,    0,   64,    0,   60,   63,   66,
			    0,    0,   64,   62,   64,   65,   66,   63,   66,   62,
			    0,   64,    0,   67,    0,   65,   68,   69,    0,   66,
			   67,    0,   67,   68,   69,   68,   69,    0,   64,    0,
			    0,   62,    0,   65,   73,   72,   64,    0,   68,   64,

			   66,   73,   72,   73,   72,    0,    0,   66,    0,    0,
			    0,    0,   73,    0,   67,   72,   64,   68,   69,    0,
			   74,    0,    0,    0,   75,   76,   68,   74,    0,   74,
			   67,   75,   76,   75,   76,   73,   72,    0,    0,   69,
			   73,   76,   77,   72,    0,    0,   78,   74,    0,   77,
			   81,   77,    0,   78,    0,   78,    0,   81,    0,   81,
			    0,   74,    0,    0,    0,   75,   76,   82,    0,   76,
			   78,   77,   79,   80,   82,   74,   82,   83,    0,   79,
			   80,   79,   80,   77,   83,    0,   83,   78,   81,    0,
			    0,   81,   79,   80,   84,   82,    0,    0,   78,   77,

			   85,   84,    0,   84,   83,    0,    0,   85,   82,   85,
			   86,    0,    0,   79,   80,    0,   81,   86,   83,   86,
			   79,   80,   87,   82,   85,    0,    0,   88,    0,   87,
			    0,   87,   83,   89,   88,   84,   88,   84,   90,   92,
			   89,   85,   89,    0,    0,   90,   92,   90,   92,   91,
			   93,   86,   85,    0,    0,   87,   91,   93,   91,   93,
			   88,    0,    0,   87,   94,    0,    0,   90,   88,    0,
			   93,   94,    0,   94,   89,   92,   89,    0,   95,   90,
			   92,    0,    0,   87,   91,   95,    0,   95,   88,    0,
			   91,   93,   96,   97,    0,   90,    0,   99,   93,   96,

			   97,   96,   97,   92,   99,   94,   99,    0,    0,  100,
			    0,    0,   91,  101,    0,    0,  100,  102,  100,   95,
			  101,   96,  101,    0,  102,    0,  102,    0,    0,    0,
			  103,   99,    0,   96,   97,  100,    0,  103,   99,  103,
			   95,    0,    0,    0,    0,   97,  104,    0,  101,   96,
			  100,    0,  102,  104,  101,  104,    0,  103,  102,   99,
			  105,  106,    0,  100,    0,  107,  108,  105,  106,  105,
			  106,  103,  107,  108,  107,  108,  101,    0,    0,  109,
			  102,  104,    0,    0,    0,  103,  109,  104,  109,  107,
			  111,    0,    0,  105,    0,    0,  106,  111,  109,  111,

			    0,  105,  106,  110,    0,    0,  107,  108,    0,  104,
			  110,    0,  110,    0,    0,    0,  112,  107,    0,  111,
			  109,  105,    0,  112,  106,  112,  109,    0,    0,  113,
			  114,  111,    0,    0,  110,    0,  113,  114,  113,  114,
			    0,    0,    0,  115,  110,  113,  112,  111,    0,    0,
			  115,  114,  115,    0,    0,    0,  116,  112,    0,  115,
			  117,  114,  110,  116,  114,  116,    0,  117,  118,  117,
			  113,  114,    0,  113,  112,  118,  119,  118,  117,  114,
			  116,  121,    0,  119,  115,  119,  120,  115,  121,  114,
			  121,  122,  114,  120,    0,  120,  123,  116,  122,    0,

			  122,  117,  120,  123,  124,  123,  117,    0,  116,  118,
			    0,  124,    0,  124,  125,    0,    0,  119,    0,  126,
			  123,  125,  121,  125,    0,  122,  126,  120,  126,  127,
			  120,  121,  122,  128,  120,    0,  127,  123,  127,  119,
			  128,    0,  128,  126,  125,  124,    0,  124,  123,  129,
			  130,    0,  127,  122,  131,  125,  129,  130,  129,  130,
			  126,  131,    0,  131,    0,    0,  128,    0,  132,  129,
			  127,  126,  125,    0,  128,  132,  133,  132,    0,  130,
			  127,    0,    0,  133,    0,  133,    0,    0,    0,    0,
			  129,  130,    0,  134,  128,  131,  133,  129,    0,  136, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  134,  132,  134,  135,  137,    0,  136,  130,  136,  132,
			  135,  137,  135,  137,    0,    0,    0,  133,  138,  139,
			    0,    0,    0,  136,  133,  138,  139,  138,  139,  132,
			    0,    0,  140,    0,  134,    0,    0,  137,  135,  140,
			  136,  140,    0,    0,  135,  137,    0,    0,  141,  142,
			  140,  136,    0,  138,  139,  141,  142,  141,  142,  138,
			  139,  143,  144,    0,    0,  137,  135,    0,  143,  144,
			  143,  144,    0,  140,    0,    0,    0,  145,  140,    0,
			    0,  138,  139,  141,  145,  146,  145,    0,  147,  141,
			  142,  148,  146,    0,  146,  147,    0,  147,  148,    0,

			  148,    0,  143,  144,    0,    0,  149,    0,  143,    0,
			    0,  141,  147,  149,  146,  149,  150,    0,  145,  144,
			    0,  151,    0,  150,  148,  150,  146,  152,  151,  147,
			  151,    0,  148,    0,  152,  149,  152,    0,    0,    0,
			  147,  151,  146,    0,  153,    0,  150,  149,    0,  154,
			    0,  153,  148,  153,    0,    0,  154,  150,  154,    0,
			    0,    0,  151,  149,  155,    0,    0,    0,  152,  151,
			    0,  155,    0,  155,  150,  157,    0,    0,    0,  154,
			  156,    0,  157,    0,  157,  153,    0,  156,    0,  156,
			  154,    0,  158,  159,    0,  157,    0,    0,    0,  158,

			  159,  158,  159,    0,  160,  155,    0,  154,  161,  159,
			  156,  160,    0,  160,    0,  161,  157,  161,  162,  163,
			    0,  156,  158,  157,    0,  162,  163,  162,  163,    0,
			    0,    0,  164,  158,  159,  165,    0,  159,  156,  164,
			  160,  164,  165,    0,  165,  160,  166,  167,    0,  161,
			  158,  161,    0,  166,  167,  166,  167,  165,  168,  162,
			  163,    0,    0,    0,    0,  168,    0,  168,  160,    0,
			    0,    0,  169,  164,    0,  166,  165,  170,  168,  169,
			  164,  169,    0,    0,  170,  165,  170,  166,  167,    0,
			    0,  171,    0,    0,    0,    0,  170,    0,  171,  168,

			  171,    0,  172,  166,    0,    0,  168,  173,  169,  172,
			  174,  172,    0,  169,  173,    0,  173,  174,  170,  174,
			  175,    0,  171,    0,  170,    0,    0,  175,    0,  175,
			    0,  176,  171,    0,  173,  172,  169,  177,  176,    0,
			  176,  174,    0,  172,  177,    0,  177,  178,  173,    0,
			  171,  174,    0,    0,  178,  175,  178,    0,  177,  179,
			    0,  175,  173,  172,  176,    0,  179,  180,  179,  174,
			    0,    0,  176,  181,  180,    0,  180,    0,  177,    0,
			  181,    0,  181,  175,  182,    0,  177,    0,  178,  183,
			  184,  182,  176,  182,  178,  185,  183,  184,  183,  184,

			  179,    0,  185,    0,  185,    0,    0,    0,  180,  186,
			  184,  181,    0,  187,  181,    0,  186,  188,  186,  182,
			  187,    0,  187,    0,  188,  182,  188,    0,  186,    0,
			  183,  184,    0,  187,    0,  189,  185,    0,  184,  181,
			    0,  188,  189,    0,  189,    0,    0,  182,    0,    0,
			  186,    0,    0,  190,  187,  189,  186,  191,  188,    0,
			  190,  187,  190,  192,  191,    0,  191,    0,    0,  188,
			  192,  193,  192,    0,    0,  194,  189,  190,  193,  195,
			  193,    0,  194,  189,  194,    0,  195,  192,  195,  193,
			  196,    0,    0,  197,  190,    0,    0,  196,  191,  196,

			  197,    0,  197,    0,  192,  190,    0,    0,  194,    0,
			    0,  197,  193,    0,    0,  192,  194,  193,  198,    0,
			  195,  199,    0,  196,    0,  198,  200,  198,  199,    0,
			  199,  196,    0,  200,  197,  200,  194,  201,    0,  197,
			  202,  199,    0,    0,  201,  203,  201,  202,    0,  202,
			    0,  196,  203,    0,  203,    0,  204,  205,    0,  198,
			    0,  200,  199,  204,  205,  204,  205,  200,    0,  199,
			  206,    0,    0,  201,    0,  202,  207,  206,  201,  206,
			  203,  202,    0,  207,  205,  207,  203,  208,    0,  200,
			    0,    0,    0,  206,  208,  209,  208,  204,  205,  204,

			    0,  201,  209,  202,  209,    0,  210,    0,  203,  207,
			    0,  206,  205,  210,    0,  210,  211,  207,    0,    0,
			    0,  206,    0,  211,    0,  211,  208,  210,  208,    0,
			    0,  212,  213,    0,  209,  211,  209,  207,  212,  213,
			  212,  213,  214,  215,    0,    0,    0,  210,    0,  214,
			  215,  214,  215,    0,  208,  210,    0,  211,    0,  217,
			    0,  212,  209,  211,    0,  213,  217,  216,  217,    0,
			  218,    0,  212,  213,  216,    0,  216,  218,    0,  218,
			    0,  219,    0,  214,  215,  220,    0,    0,  219,  212,
			  219,  216,  220,  213,  220,  221,    0,    0,    0,    0,

			  217,  219,  221,  222,  221,  220,  218,    0,  216,    0,
			  222,  218,  222,    0,  223,    0,    0,    0,  225,  216,
			    0,  223,  219,  223,    0,  225,  220,  225,    0,  219,
			  221,  224,  222,  220,  218,    0,  221,    0,  224,  227,
			  224,  223,    0,  226,  222,    0,  227,  228,  227,  224,
			  226,    0,  226,  225,  228,  223,  228,  229,  221,  225,
			  222,  230,  226,    0,  229,    0,  229,  231,  230,  223,
			  230,    0,  224,    0,  231,  227,  231,  224,  233,    0,
			  227,  225,  234,    0,  226,  233,  232,  233,  228,  234,
			  226,  234,  235,  232,  230,  232,    0,    0,  229,  235,

			  231,  235,  230,  227,    0,    0,  232,  233,  231,    0,
			    0,    0,    0,    0,    0,    0,    0,  234,    0,  233,
			    0,    0,  230,  234,    0,    0,    0,  232,  231,    0,
			    0,    0,    0,  235,  232,  233,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  234,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,

			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236, yy_Dummy>>,
			1, 920, 1000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  138, 1846,   72,  131, 1846,  119,   69,
			 1846, 1846, 1846,  117, 1846,   72, 1846, 1846, 1846,  101,
			   73,   85,   90,   89,   77,  115,  138,  141,  120,  146,
			  164,  169,  174,  192,  202,  218,  230,  104,  111,  109,
			   99,  248,  104,   97,  267,  278,  290,  293,  303,  306,
			  317,  321,  333,  339,  343,  361,  369,  383,  386,  389,
			  405,  399,  422,  411,  449,  428,  453,  467,  470,  471,
			  103,   87,  489,  488,  514,  518,  519,  536,  540,  566,
			  567,  544,  561,  571,  588,  594,  604,  616,  621,  627,
			  632,  643,  633,  644,  658,  672,  686,  687,   85,  691,

			  703,  707,  711,  724,  740,  754,  755,  759,  760,  773,
			  797,  784,  810,  823,  824,  837,  850,  854,  862,  870,
			  880,  875,  885,  890,  898,  908,  913,  923,  927,  943,
			  944,  948,  962,  970,  987,  997,  993,  998, 1012, 1013,
			 1026, 1042, 1043, 1055, 1056, 1071, 1079, 1082, 1085, 1100,
			 1110, 1115, 1121, 1138, 1143, 1158, 1174, 1169, 1186, 1187,
			 1198, 1202, 1212, 1213, 1226, 1229, 1240, 1241, 1252, 1266,
			 1271, 1285, 1296, 1301, 1304, 1314, 1325, 1331, 1341, 1353,
			 1361, 1367, 1378, 1383, 1384, 1389, 1403, 1407, 1411, 1429,
			 1447, 1451, 1457, 1465, 1469, 1473, 1484, 1487, 1512, 1515,

			 1520, 1531, 1534, 1539, 1550, 1551, 1564, 1570, 1581, 1589,
			 1600, 1610, 1625, 1626, 1636, 1637, 1661, 1653, 1664, 1675,
			 1679, 1689, 1697, 1708, 1725, 1712, 1737, 1733, 1741, 1751,
			 1755, 1761, 1780, 1772, 1776, 1786, 1846,   78,   91,   74, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  236,    1,  236,  236,  236,  236,  236,  236,  237,
			  236,  236,  236,  238,  236,  237,  236,  236,  236,  239,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  236,  236,  236,
			  236,  237,  238,  236,  239,  239,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  236,  236,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  236,  237,

			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,

			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,    0,  236,  236,  236, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    1,    5,    1,    1,    6,    7,    1,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   17,    1,
			   18,   19,   20,    1,   21,   22,   23,   24,   25,   26,
			   27,   28,   29,   30,   31,   32,   33,   34,   35,   36,
			   37,   38,   39,   40,   41,   42,   43,   44,   38,   45,
			   38,   46,   47,   48,    1,   49,    1,   50,   51,   52,

			   53,   54,   55,   56,   57,   58,   59,   60,   61,   62,
			   63,   64,   65,   66,   67,   68,   69,   70,   71,   72,
			   66,   73,   66,    1,    1,    1,    1,    1,    1,    1,
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
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    2,    3,    1,    1,
			    1,    2,    1,    2,    2,    2,    3,    1,    1,    2,
			    1,    1,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    2,    2,    2,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   50,   48,    1,    2,   11,   48,    8,
			    4,    5,    7,   47,    6,   46,    3,    9,   10,   44,
			   46,   46,   15,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   15,   46,   46,    1,    2,    0,
			    0,   46,   47,    0,   45,   44,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   28,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			    0,    0,   46,   46,   46,   18,   46,   46,   46,   46,
			   46,   23,   46,   46,   46,   46,   30,   46,   46,   46,
			   46,   46,   46,   46,   43,   46,   46,   46,    0,   46,

			   46,   46,   46,   46,   46,   46,   46,   46,   25,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   41,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   26,   46,   46,   31,   46,   46,   46,   46,   46,
			   46,   46,   19,   46,   46,   12,   46,   46,   46,   46,
			   46,   46,   22,   24,   46,   29,   46,   46,   46,   46,
			   46,   38,   40,   37,   46,   46,   46,   20,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   13,
			   14,   46,   46,   21,   46,   32,   46,   46,   46,   46,
			   46,   42,   46,   46,   46,   33,   46,   46,   36,   46,

			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   27,   34,   46,   39,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   16,   35,
			   46,   46,   46,   46,   46,   17,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1846
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 236
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 237
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

	yyNb_rules: INTEGER is 49
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 50
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is true
			-- Is `position' used?

	INITIAL: INTEGER is 0
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Initialization

	make is
			-- Create a new external scanner.
		do
			make_with_buffer (Empty_buffer)
			create token_buffer.make (Initial_buffer_size)
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			token_buffer.clear_all
		end

feature -- Access

	token_buffer: STRING
			-- Buffer for lexial tokens

	last_value: ANY
			-- Semantic value to be passed to the parser

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER is 1024 
				-- Initial size for `token_buffer'

invariant
	token_buffer_not_void: token_buffer /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EXTERNAL_SCANNER
