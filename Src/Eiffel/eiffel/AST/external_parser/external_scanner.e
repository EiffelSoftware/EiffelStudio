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
--|#line 37 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 37")
end

when 2 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 38 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 38")
end

when 3 then
	yy_position := yy_position + 1
--|#line 42 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 42")
end

				last_token := TE_COLON
			
when 4 then
	yy_position := yy_position + 1
--|#line 45 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 45")
end

				last_token := TE_LPARAN
			
when 5 then
	yy_position := yy_position + 1
--|#line 48 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 48")
end

				last_token := TE_RPARAN
			
when 6 then
	yy_position := yy_position + 1
--|#line 51 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 51")
end

				last_token := TE_COMMA
			
when 7 then
	yy_position := yy_position + 1
--|#line 54 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 54")
end

				last_token := TE_STAR
			
when 8 then
	yy_position := yy_position + 1
--|#line 57 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 57")
end

				last_token := TE_ADDRESS
			
when 9 then
	yy_position := yy_position + 1
--|#line 60 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 60")
end

				last_token := TE_LT
			
when 10 then
	yy_position := yy_position + 1
--|#line 63 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 63")
end

				last_token := TE_GT
			
when 11 then
	yy_position := yy_position + 1
--|#line 66 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 66")
end

				last_token := TE_DQUOTE
			
when 12 then
	yy_position := yy_position + 6
--|#line 71 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 71")
end

				last_token := TE_ACCESS
			
when 13 then
	yy_position := yy_position + 8
--|#line 74 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 74")
end

				last_token := TE_BLOCKING
			
when 14 then
	yy_position := yy_position + 8
--|#line 77 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 77")
end

				last_token := TE_BUILT_IN
			
when 15 then
	yy_position := yy_position + 1
--|#line 80 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 80")
end

				last_token := TE_C_LANGUAGE
			
when 16 then
	yy_position := yy_position + 16
--|#line 83 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 83")
end

				last_token := TE_C_LANGUAGE
			
when 17 then
	yy_position := yy_position + 22
--|#line 86 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 86")
end

				last_token := TE_C_LANGUAGE
			
when 18 then
	yy_position := yy_position + 3
--|#line 89 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 89")
end

				last_token := TE_CPP_LANGUAGE
			
when 19 then
	yy_position := yy_position + 5
--|#line 92 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 92")
end

				last_token := TE_CONST
			
when 20 then
	yy_position := yy_position + 7
--|#line 95 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 95")
end

				last_token := TE_CREATOR
			
when 21 then
	yy_position := yy_position + 8
--|#line 98 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 98")
end

				last_token := TE_DEFERRED
			
when 22 then
	yy_position := yy_position + 6
--|#line 101 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 101")
end

				last_token := TE_DELETE
			
when 23 then
	yy_position := yy_position + 3
--|#line 104 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 104")
end

				last_token := TE_DLL_LANGUAGE
			
when 24 then
	yy_position := yy_position + 6
--|#line 107 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 107")
end

				last_token := TE_DLLWIN_LANGUAGE
			
when 25 then
	yy_position := yy_position + 4
--|#line 110 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 110")
end

				last_token := TE_ENUM
			
when 26 then
	yy_position := yy_position + 5
--|#line 113 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 113")
end

				last_token := TE_FIELD
			
when 27 then
	yy_position := yy_position + 12
--|#line 116 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 116")
end

				last_token := TE_GET_PROPERTY
			
when 28 then
	yy_position := yy_position + 2
--|#line 119 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 119")
end

				last_token := TE_IL_LANGUAGE
			
when 29 then
	yy_position := yy_position + 6
--|#line 122 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 122")
end

				last_token := TE_INLINE
			
when 30 then
	yy_position := yy_position + 3
--|#line 125 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 125")
end

				last_token := TE_JAVA_LANGUAGE
			
when 31 then
	yy_position := yy_position + 5
--|#line 128 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 128")
end

				last_token := TE_MACRO
			
when 32 then
	yy_position := yy_position + 8
--|#line 131 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 131")
end

				last_token := TE_OPERATOR
			
when 33 then
	yy_position := yy_position + 9
--|#line 134 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 134")
end

				last_token := TE_SET_FIELD
			
when 34 then
	yy_position := yy_position + 12
--|#line 137 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 137")
end

				last_token := TE_SET_PROPERTY
			
when 35 then
	yy_position := yy_position + 16
--|#line 140 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 140")
end

				last_token := TE_SET_STATIC_FIELD
			
when 36 then
	yy_position := yy_position + 9
--|#line 143 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 143")
end

				last_token := TE_SIGNATURE
			
when 37 then
	yy_position := yy_position + 6
--|#line 146 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 146")
end

				last_token := TE_SIGNED
			
when 38 then
	yy_position := yy_position + 6
--|#line 149 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 149")
end

				last_token := TE_STATIC
			
when 39 then
	yy_position := yy_position + 12
--|#line 152 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 152")
end

				last_token := TE_STATIC_FIELD
			
when 40 then
	yy_position := yy_position + 6
--|#line 155 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 155")
end

				last_token := TE_STRUCT
			
when 41 then
	yy_position := yy_position + 4
--|#line 158 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 158")
end

				last_token := TE_TYPE
			
when 42 then
	yy_position := yy_position + 8
--|#line 161 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 161")
end

				last_token := TE_UNSIGNED
			
when 43 then
	yy_position := yy_position + 3
--|#line 164 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 164")
end

				last_token := TE_USE
			
when 44 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 169 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 169")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_INTEGER
			
when 45 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 176 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 176")
end

					-- To escape external keywords.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_ID
			
when 46 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 184 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 184")
end

					-- Traditional identifier
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_ID
			
when 47 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 190 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 190")
end

					-- Special identifier for include files that specifies
					-- a path, e.g. <sys/timeb.h>, or path that includes an hyphenation.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INCLUDE_ID
			
when 48 then
	yy_position := yy_position + 1
--|#line 198 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 198")
end

when 49 then
	yy_position := yy_position + 1
--|#line 0 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 0")
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
		once
			Result := yy_fixed_array (<<
			    0,    4,    5,    6,    5,    7,    8,    9,   10,   11,
			   12,   13,   14,   13,   13,   13,   15,   16,   17,   13,
			   18,   19,   20,   21,   22,   23,   24,   25,   26,   15,
			   27,   28,   15,   15,   29,   15,   30,   15,   15,   15,
			   31,   32,   33,   15,   15,   15,   13,   13,   15,   20,
			   21,   34,   23,   24,   25,   26,   15,   27,   28,   15,
			   15,   29,   15,   30,   15,   15,   15,   35,   32,   36,
			   15,   15,   15,   37,   40,   37,   44,   40,   40,   41,
			   41,   42,   40,   42,   42,   42,   42,   42,   40,   42,
			   44,   42,   40,   49,   98,   42,   46,   42,   40,   42,

			   37,   42,   37,   41,   40,   42,   39,   42,   43,   47,
			   70,   42,   52,   42,   42,   40,   42,   42,   48,   53,
			   38,   50,   42,   46,   42,   45,   43,   54,   55,   39,
			   51,   40,   38,  236,   40,   56,   47,  236,   42,   52,
			   42,   42,   40,   42,  236,   48,   53,  236,   50,   42,
			   40,   42,  236,  236,   54,   55,   40,   42,   57,   42,
			   58,  236,   56,   42,  236,   42,   60,  236,  236,  236,
			   40,   59,  236,   61,   40,   40,   62,   42,  236,   42,
			   63,   42,   42,   42,   42,   57,  236,   58,  236,  236,
			   40,   64,  236,   60,  236,   49,  236,   42,   59,   42,

			   61,  236,  236,   62,   40,  236,  236,   63,   66,   65,
			  236,   42,   40,   42,  236,  236,  236,   71,   64,   42,
			   40,   42,   44,   50,   62,   44,  236,   42,   63,   42,
			   44,  236,   51,   40,   40,   66,   65,  236,   72,   64,
			   42,   42,   42,   42,  236,  236,   66,   67,  236,  236,
			   50,   62,  236,  236,   71,   68,  236,   44,   44,   44,
			  236,   81,   44,   73,   45,   72,   64,   44,   69,   40,
			   40,  236,  236,   66,   40,   75,   42,   42,   42,   42,
			   40,   42,  236,   42,  236,  236,  236,   42,   81,   42,
			   73,  236,   40,   74,   44,   44,   40,   40,   77,   42,

			   76,   42,   40,   42,   42,   42,   42,   40,  236,   42,
			  236,   42,   78,   79,   42,   40,   42,   83,  236,   80,
			   74,   40,   42,  236,   42,   77,   40,   76,   42,   40,
			   42,  236,   82,   42,   40,   42,   42,   84,   42,   78,
			   79,   42,   85,   42,   83,  236,   80,   87,   40,   86,
			  236,   40,  236,  236,   88,   42,   40,   42,   42,   82,
			   42,   89,  236,   42,   84,   42,   40,   91,  236,   85,
			   90,   40,  236,   42,   87,   42,   86,  236,   42,  236,
			   42,   88,   40,   40,   92,  236,   94,   93,   89,   42,
			   42,   42,   42,  236,   91,  236,   40,   90,  236,   40,

			   40,  236,  236,   42,   90,   42,   42,   42,   42,   42,
			   40,   92,  236,   94,   93,   40,   99,   42,  100,   42,
			  236,   40,   42,  236,   42,   40,  101,   95,   42,   40,
			   42,   96,   42,   40,   42,  236,   42,  102,   42,  104,
			   42,   40,   42,   99,   97,  100,  236,  236,   42,  105,
			   42,   40,  236,  101,  103,  236,   40,  236,   42,  236,
			   42,  106,  236,   42,  102,   42,  104,  236,   40,  236,
			  236,  107,  236,   40,  236,   42,  105,   42,   40,  108,
			   42,  103,   42,  109,   40,   42,  236,   42,  106,  236,
			   40,   42,  111,   42,   40,   40,  236,   42,  107,   42,

			   40,   42,   42,   42,   42,   40,  108,   42,  236,   42,
			  109,   40,   42,  236,   42,  110,  236,  112,   42,  111,
			   42,   40,  236,  113,  115,   40,  236,  236,   42,  236,
			   42,  118,   42,   40,   42,  116,  114,  236,   40,   40,
			   42,  117,   42,  236,  112,   42,   42,   42,   42,  236,
			  113,  115,   40,  236,  236,  236,   40,   40,  118,   42,
			  236,   42,  116,   42,   42,   42,   42,  115,  117,  236,
			   40,  236,  236,  122,   40,  236,  236,   42,  123,   42,
			   40,   42,  236,   42,  121,  236,  119,   42,  236,   42,
			  236,  124,  125,  236,  120,   40,  236,  126,  236,   40,

			  122,  236,   42,   40,   42,  123,   42,   40,   42,  127,
			   42,  236,   42,  128,   42,  236,   42,  236,  124,  125,
			   40,  236,  236,  130,  126,   40,  131,   42,   40,   42,
			  129,  236,   42,  236,   42,   42,  127,   42,   40,   40,
			  128,  236,  236,  236,  236,   42,   42,   42,   42,  236,
			  130,  132,  236,  131,  133,  135,   40,  129,  134,  136,
			  236,   40,  236,   42,  236,   42,   40,   40,   42,  137,
			   42,  236,  138,   42,   42,   42,   42,  139,  132,  236,
			  140,  133,  135,   40,  141,  134,  136,  236,   40,  236,
			   42,  236,   42,   40,   40,   42,  137,   42,  236,  138,

			   42,   42,   42,   42,  139,   40,   40,  140,  236,  139,
			   40,  141,   42,   42,   42,   42,   40,   42,  236,   42,
			  236,  236,  236,   42,   40,   42,  236,  236,  145,  146,
			  236,   42,   40,   42,  149,  236,  139,  144,  236,   42,
			  143,   42,   40,   40,  236,  142,  148,  150,  147,   42,
			   42,   42,   42,  236,  236,  145,  146,   40,  236,  236,
			   40,  149,  152,  236,   42,  151,   42,   42,   40,   42,
			  236,   40,  153,  148,  150,   42,   40,   42,   42,  236,
			   42,  236,  236,   42,  236,   42,  236,  236,  155,  152,
			  236,   40,  151,  154,   40,   40,  236,  236,   42,  153,

			   42,   42,   42,   42,   42,   40,  236,  236,  236,  236,
			   40,  156,   42,  236,   42,  155,  236,   42,  157,   42,
			  154,  236,   40,  236,  158,   40,   40,  236,  161,   42,
			  159,   42,   42,   42,   42,   42,  236,   40,  156,  236,
			  160,   40,  236,  236,   42,  157,   42,   40,   42,  236,
			   42,  158,  236,  236,   42,  161,   42,  159,  236,   40,
			  162,  236,   40,  236,  236,  236,   42,  160,   42,   42,
			   40,   42,  163,  236,  236,   40,  165,   42,  236,   42,
			  236,   40,   42,  166,   42,   40,  236,  162,   42,   40,
			   42,  236,   42,  164,   42,  167,   42,   40,   42,  168,

			   40,  170,  236,  165,   42,  169,   42,   42,   40,   42,
			  166,   40,   40,  236,  236,   42,   40,   42,   42,   42,
			   42,   42,  167,   42,  236,   42,  168,  171,  170,  236,
			   40,  173,  169,  236,   40,  236,  236,   42,  172,   42,
			   40,   42,  174,   42,   40,  236,  175,   42,   40,   42,
			  236,   42,  176,   42,  171,   42,  236,   42,  173,   40,
			  236,  236,  236,   40,  236,  172,   42,  236,   42,  174,
			   42,   40,   42,  175,  236,  236,  177,   40,   42,  176,
			   42,  179,   40,  236,   42,  236,   42,   40,  236,   42,
			  236,   42,  180,   40,   42,  178,   42,  181,   40,  236,

			   42,  236,   42,   40,   40,   42,  183,   42,  179,  236,
			   42,   42,   42,   42,   40,  236,  236,  236,  182,  180,
			  236,   42,  236,   42,  181,   40,  185,  236,  236,  184,
			  186,   40,   42,  183,   42,  187,  236,   40,   42,  236,
			   42,   40,  236,  236,   42,  182,   42,  236,   42,  188,
			   42,  236,  190,  185,   40,  236,  184,  186,  189,   40,
			   40,   42,  187,   42,   40,   40,   42,   42,   42,   42,
			  236,   42,   42,   42,   42,   40,  188,  236,  236,  190,
			   40,   40,   42,  191,   42,  189,  236,   42,   42,   42,
			   42,  236,  236,  236,  195,  193,   40,  192,  236,   40,

			  194,  196,   40,   42,  236,   42,   42,   40,   42,   42,
			  236,   42,  236,  236,   42,  236,   42,  236,  236,  198,
			  197,  195,  193,  236,  192,   40,  199,  194,  196,   40,
			   40,  236,   42,   40,   42,  236,   42,   42,   42,   42,
			   42,  236,   42,  236,  236,   40,  198,  197,  201,  200,
			   40,   40,   42,  199,   42,  236,  236,   42,   42,   42,
			   42,  236,  202,   40,   40,  236,  236,  236,  204,  236,
			   42,   42,   42,   42,  236,  201,  200,   40,  203,  236,
			  236,   40,  236,  205,   42,   40,   42,  236,   42,  202,
			   42,   40,   42,  236,   42,  204,  236,   40,   42,  206,

			   42,  236,   40,  236,   42,  203,   42,  236,   40,   42,
			  205,   42,  236,  207,   40,   42,  208,   42,  236,  236,
			  209,   42,   40,   42,  211,  212,  206,   40,  236,   42,
			   40,   42,  236,  210,   42,   40,   42,   42,  236,   42,
			  207,  213,   42,  208,   42,  236,  236,  209,  216,  217,
			   40,  211,  212,  214,  236,   40,  236,   42,  236,   42,
			   40,  215,   42,   40,   42,  218,  236,   42,  213,   42,
			   42,  236,   42,  236,  236,  216,  217,   40,  236,  236,
			  214,  236,   40,  219,   42,  236,   42,  220,  215,   42,
			   40,   42,  218,   40,  236,  236,   40,   42,  236,   42,

			   42,  236,   42,   42,  236,   42,  236,  236,   40,  236,
			  219,  236,   40,  222,  220,   42,  223,   42,  221,   42,
			   40,   42,  236,   40,   40,  224,  236,   42,  236,   42,
			   42,   42,   42,   42,  236,   40,  236,  225,  227,  226,
			  222,   40,   42,  223,   42,  221,   40,  236,   42,  236,
			   42,  236,  224,   42,  229,   42,  236,  236,  228,  236,
			  230,   40,   40,  236,  225,  227,  226,   40,   42,   42,
			   42,   42,  236,   40,   42,  236,   42,   40,  236,  236,
			   42,  229,   42,   40,   42,  228,   42,  230,  236,  236,
			   42,  236,   42,  233,  231,  232,  234,  236,  236,  236,

			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  235,  236,  236,  236,  236,  236,  236,  236,
			  233,  231,  232,  234,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  235,
			    3,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,

			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    5,    9,    5,  239,   15,   20,  237,
			  237,    9,   21,    9,   15,   20,   15,   20,   22,   21,
			   98,   21,   23,   22,   71,   22,   20,   22,   24,   23,

			   37,   23,   37,   70,   25,   24,   43,   24,   42,   21,
			   40,   25,   23,   25,   39,   26,  238,  238,   21,   23,
			   38,   22,   26,   20,   26,   19,   13,   24,   25,    8,
			   22,   27,    6,    3,   28,   26,   21,    0,   27,   23,
			   27,   28,   30,   28,    0,   21,   23,    0,   22,   30,
			   29,   30,    0,    0,   24,   25,   31,   29,   27,   29,
			   27,    0,   26,   31,    0,   31,   29,    0,    0,    0,
			   32,   28,    0,   30,   33,   41,   31,   32,    0,   32,
			   31,   33,   41,   33,   41,   27,    0,   27,    0,    0,
			   34,   31,    0,   29,    0,   34,    0,   34,   28,   34,

			   30,    0,    0,   31,   35,    0,    0,   31,   33,   32,
			    0,   35,   36,   35,    0,    0,    0,   44,   31,   36,
			   46,   36,   44,   34,   35,   44,    0,   46,   35,   46,
			   44,    0,   34,   47,   53,   33,   32,    0,   46,   35,
			   47,   53,   47,   53,    0,    0,   36,   34,    0,    0,
			   34,   35,    0,    0,   45,   35,    0,   44,   44,   45,
			    0,   53,   45,   47,   45,   46,   35,   45,   36,   48,
			   49,    0,    0,   36,   51,   49,   48,   49,   48,   49,
			   50,   51,    0,   51,    0,    0,    0,   50,   53,   50,
			   47,    0,   52,   48,   45,   45,   54,   55,   51,   52,

			   50,   52,   56,   54,   55,   54,   55,   57,    0,   56,
			    0,   56,   51,   52,   57,   58,   57,   55,    0,   52,
			   48,   59,   58,    0,   58,   51,   62,   50,   59,   60,
			   59,    0,   54,   62,   61,   62,   60,   56,   60,   51,
			   52,   61,   58,   61,   55,    0,   52,   60,   63,   59,
			    0,   64,    0,    0,   61,   63,   65,   63,   64,   54,
			   64,   62,    0,   65,   56,   65,   66,   64,    0,   58,
			   63,   67,    0,   66,   60,   66,   59,    0,   67,    0,
			   67,   61,   68,   69,   64,    0,   66,   65,   62,   68,
			   69,   68,   69,    0,   64,    0,   72,   63,    0,   74,

			   73,    0,    0,   72,   68,   72,   74,   73,   74,   73,
			   75,   64,    0,   66,   65,   78,   72,   75,   73,   75,
			    0,   76,   78,    0,   78,   77,   74,   67,   76,   79,
			   76,   68,   77,   81,   77,    0,   79,   76,   79,   78,
			   81,   80,   81,   72,   69,   73,    0,    0,   80,   79,
			   80,   82,    0,   74,   77,    0,   83,    0,   82,    0,
			   82,   80,    0,   83,   76,   83,   78,    0,   85,    0,
			    0,   81,    0,   84,    0,   85,   79,   85,   86,   82,
			   84,   77,   84,   83,   87,   86,    0,   86,   80,    0,
			   88,   87,   85,   87,   89,   90,    0,   88,   81,   88,

			   91,   89,   90,   89,   90,   92,   82,   91,    0,   91,
			   83,   93,   92,    0,   92,   84,    0,   87,   93,   85,
			   93,   94,    0,   88,   90,   95,    0,    0,   94,    0,
			   94,   93,   95,   97,   95,   91,   89,    0,   96,   99,
			   97,   92,   97,    0,   87,   96,   99,   96,   99,    0,
			   88,   90,  100,    0,    0,    0,  101,  102,   93,  100,
			    0,  100,   91,  101,  102,  101,  102,   96,   92,    0,
			  103,    0,    0,   99,  104,    0,    0,  103,  100,  103,
			  105,  104,    0,  104,   97,    0,   95,  105,    0,  105,
			    0,  101,  102,    0,   96,  106,    0,  103,    0,  107,

			   99,    0,  106,  108,  106,  100,  107,  109,  107,  104,
			  108,    0,  108,  105,  109,    0,  109,    0,  101,  102,
			  110,    0,    0,  107,  103,  111,  109,  110,  112,  110,
			  106,    0,  111,    0,  111,  112,  104,  112,  114,  113,
			  105,    0,    0,    0,    0,  114,  113,  114,  113,    0,
			  107,  110,    0,  109,  111,  113,  116,  106,  112,  114,
			    0,  115,    0,  116,    0,  116,  117,  118,  115,  114,
			  115,    0,  114,  117,  118,  117,  118,  115,  110,    0,
			  116,  111,  113,  119,  117,  112,  114,    0,  121,    0,
			  119,    0,  119,  120,  122,  121,  114,  121,    0,  114,

			  120,  122,  120,  122,  115,  123,  124,  116,    0,  120,
			  126,  117,  123,  124,  123,  124,  125,  126,    0,  126,
			    0,    0,    0,  125,  127,  125,    0,    0,  122,  123,
			    0,  127,  128,  127,  126,    0,  120,  121,    0,  128,
			  120,  128,  129,  130,    0,  119,  125,  127,  124,  129,
			  130,  129,  130,    0,    0,  122,  123,  131,    0,    0,
			  132,  126,  129,    0,  131,  128,  131,  132,  133,  132,
			    0,  134,  130,  125,  127,  133,  135,  133,  134,    0,
			  134,    0,    0,  135,    0,  135,    0,    0,  133,  129,
			    0,  137,  128,  132,  136,  138,    0,    0,  137,  130,

			  137,  136,  138,  136,  138,  139,    0,    0,    0,    0,
			  140,  135,  139,    0,  139,  133,    0,  140,  136,  140,
			  132,    0,  142,    0,  137,  141,  143,    0,  140,  142,
			  138,  142,  141,  143,  141,  143,    0,  144,  135,    0,
			  139,  145,    0,    0,  144,  136,  144,  146,  145,    0,
			  145,  137,    0,    0,  146,  140,  146,  138,    0,  147,
			  141,    0,  148,    0,    0,    0,  147,  139,  147,  148,
			  149,  148,  143,    0,    0,  150,  146,  149,    0,  149,
			    0,  151,  150,  147,  150,  152,    0,  141,  151,  153,
			  151,    0,  152,  144,  152,  148,  153,  154,  153,  149,

			  155,  151,    0,  146,  154,  150,  154,  155,  156,  155,
			  147,  157,  158,    0,    0,  156,  160,  156,  157,  158,
			  157,  158,  148,  160,    0,  160,  149,  154,  151,    0,
			  159,  157,  150,    0,  161,    0,    0,  159,  156,  159,
			  162,  161,  158,  161,  163,    0,  159,  162,  164,  162,
			    0,  163,  160,  163,  154,  164,    0,  164,  157,  165,
			    0,    0,    0,  166,    0,  156,  165,    0,  165,  158,
			  166,  167,  166,  159,    0,    0,  161,  168,  167,  160,
			  167,  165,  169,    0,  168,    0,  168,  170,    0,  169,
			    0,  169,  166,  172,  170,  164,  170,  168,  171,    0,

			  172,    0,  172,  173,  174,  171,  170,  171,  165,    0,
			  173,  174,  173,  174,  175,    0,    0,    0,  169,  166,
			    0,  175,    0,  175,  168,  176,  172,    0,    0,  171,
			  173,  177,  176,  170,  176,  174,    0,  178,  177,    0,
			  177,  179,    0,    0,  178,  169,  178,    0,  179,  175,
			  179,    0,  177,  172,  180,    0,  171,  173,  176,  181,
			  182,  180,  174,  180,  183,  185,  181,  182,  181,  182,
			    0,  183,  185,  183,  185,  186,  175,    0,    0,  177,
			  184,  187,  186,  178,  186,  176,    0,  184,  187,  184,
			  187,    0,    0,    0,  186,  182,  188,  181,    0,  189,

			  184,  187,  190,  188,    0,  188,  189,  191,  189,  190,
			    0,  190,    0,    0,  191,    0,  191,    0,    0,  189,
			  188,  186,  182,    0,  181,  192,  190,  184,  187,  194,
			  193,    0,  192,  195,  192,    0,  194,  193,  194,  193,
			  195,    0,  195,    0,    0,  196,  189,  188,  193,  192,
			  197,  198,  196,  190,  196,    0,    0,  197,  198,  197,
			  198,    0,  194,  199,  200,    0,    0,    0,  197,    0,
			  199,  200,  199,  200,    0,  193,  192,  201,  196,    0,
			    0,  202,    0,  199,  201,  203,  201,    0,  202,  194,
			  202,  204,  203,    0,  203,  197,    0,  205,  204,  200,

			  204,    0,  206,    0,  205,  196,  205,    0,  207,  206,
			  199,  206,    0,  201,  208,  207,  202,  207,    0,    0,
			  203,  208,  209,  208,  205,  206,  200,  210,    0,  209,
			  211,  209,    0,  204,  210,  212,  210,  211,    0,  211,
			  201,  207,  212,  202,  212,    0,    0,  203,  210,  211,
			  213,  205,  206,  208,    0,  214,    0,  213,    0,  213,
			  215,  209,  214,  216,  214,  212,    0,  215,  207,  215,
			  216,    0,  216,    0,    0,  210,  211,  217,    0,    0,
			  208,    0,  218,  213,  217,    0,  217,  216,  209,  218,
			  221,  218,  212,  219,    0,    0,  220,  221,    0,  221,

			  219,    0,  219,  220,    0,  220,    0,    0,  222,    0,
			  213,    0,  223,  219,  216,  222,  220,  222,  218,  223,
			  224,  223,    0,  225,  227,  221,    0,  224,    0,  224,
			  225,  227,  225,  227,    0,  226,    0,  222,  224,  223,
			  219,  228,  226,  220,  226,  218,  229,    0,  228,    0,
			  228,    0,  221,  229,  226,  229,    0,    0,  225,    0,
			  227,  230,  231,    0,  222,  224,  223,  233,  230,  231,
			  230,  231,    0,  232,  233,    0,  233,  234,    0,    0,
			  232,  226,  232,  235,  234,  225,  234,  227,    0,    0,
			  235,    0,  235,  232,  230,  231,  233,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  234,    0,    0,    0,    0,    0,    0,    0,
			  232,  230,  231,  233,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  234,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,

			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  133, 1440,   71,  129, 1440,  117,   68,
			 1440, 1440, 1440,  120, 1440,   71, 1440, 1440, 1440,  109,
			   72,   76,   82,   86,   92,   98,  109,  125,  128,  144,
			  136,  150,  164,  168,  184,  198,  206,   98,  117,  110,
			   98,  169,  102,   94,  211,  248,  214,  227,  263,  264,
			  274,  268,  286,  228,  290,  291,  296,  301,  309,  315,
			  323,  328,  320,  342,  345,  350,  360,  365,  376,  377,
			   99,   82,  390,  394,  393,  404,  415,  419,  409,  423,
			  435,  427,  445,  450,  467,  462,  472,  478,  484,  488,
			  489,  494,  499,  505,  515,  519,  532,  527,   86,  533,

			  546,  550,  551,  564,  568,  574,  589,  593,  597,  601,
			  614,  619,  622,  633,  632,  655,  650,  660,  661,  677,
			  687,  682,  688,  699,  700,  710,  704,  718,  726,  736,
			  737,  751,  754,  762,  765,  770,  788,  785,  789,  799,
			  804,  819,  816,  820,  831,  835,  841,  853,  856,  864,
			  869,  875,  879,  883,  891,  894,  902,  905,  906,  924,
			  910,  928,  934,  938,  942,  953,  957,  965,  971,  976,
			  981,  992,  987,  997,  998, 1008, 1019, 1025, 1031, 1035,
			 1048, 1053, 1054, 1058, 1074, 1059, 1069, 1075, 1090, 1093,
			 1096, 1101, 1119, 1124, 1123, 1127, 1139, 1144, 1145, 1157,

			 1158, 1171, 1175, 1179, 1185, 1191, 1196, 1202, 1208, 1216,
			 1221, 1224, 1229, 1244, 1249, 1254, 1257, 1271, 1276, 1287,
			 1290, 1284, 1302, 1306, 1314, 1317, 1329, 1318, 1335, 1340,
			 1355, 1356, 1367, 1361, 1371, 1377, 1440,   77,  114,   73, yy_Dummy>>)
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
			   38,   46,    1,   47,    1,   48,    1,   49,   50,   51,

			   52,   53,   54,   55,   56,   57,   58,   59,   60,   61,
			   62,   63,   64,   65,   66,   67,   68,   69,   70,   71,
			   65,   72,   65,    1,    1,    1,    1,    1,    1,    1,
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
			    3,    3,    3,    3,    3,    3,    2,    2,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3, yy_Dummy>>)
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

	yyJam_base: INTEGER is 1440
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
