indexing
	description: "Scanners for external parsers"
	status: "See notice at end of class"
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
--|#line 36 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 36")
end

when 2 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 37 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 37")
end

when 3 then
	yy_position := yy_position + 1
--|#line 41 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 41")
end

				last_token := TE_COLON
			
when 4 then
	yy_position := yy_position + 1
--|#line 44 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 44")
end

				last_token := TE_LPARAN
			
when 5 then
	yy_position := yy_position + 1
--|#line 47 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 47")
end

				last_token := TE_RPARAN
			
when 6 then
	yy_position := yy_position + 1
--|#line 50 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 50")
end

				last_token := TE_COMMA
			
when 7 then
	yy_position := yy_position + 1
--|#line 53 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 53")
end

				last_token := TE_STAR
			
when 8 then
	yy_position := yy_position + 1
--|#line 56 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 56")
end

				last_token := TE_ADDRESS
			
when 9 then
	yy_position := yy_position + 1
--|#line 59 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 59")
end

				last_token := TE_LT
			
when 10 then
	yy_position := yy_position + 1
--|#line 62 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 62")
end

				last_token := TE_GT
			
when 11 then
	yy_position := yy_position + 1
--|#line 65 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 65")
end

				last_token := TE_DQUOTE
			
when 12 then
	yy_position := yy_position + 6
--|#line 70 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 70")
end

				last_token := TE_ACCESS
			
when 13 then
	yy_position := yy_position + 8
--|#line 73 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 73")
end

				last_token := TE_BLOCKING
			
when 14 then
	yy_position := yy_position + 1
--|#line 76 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 76")
end

				last_token := TE_C_LANGUAGE
			
when 15 then
	yy_position := yy_position + 16
--|#line 79 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 79")
end

				last_token := TE_C_LANGUAGE
			
when 16 then
	yy_position := yy_position + 22
--|#line 82 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 82")
end

				last_token := TE_C_LANGUAGE
			
when 17 then
	yy_position := yy_position + 3
--|#line 85 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 85")
end

				last_token := TE_CPP_LANGUAGE
			
when 18 then
	yy_position := yy_position + 7
--|#line 88 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 88")
end

				last_token := TE_CREATOR
			
when 19 then
	yy_position := yy_position + 8
--|#line 91 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 91")
end

				last_token := TE_DEFERRED
			
when 20 then
	yy_position := yy_position + 6
--|#line 94 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 94")
end

				last_token := TE_DELETE
			
when 21 then
	yy_position := yy_position + 3
--|#line 97 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 97")
end

				last_token := TE_DLL_LANGUAGE
			
when 22 then
	yy_position := yy_position + 6
--|#line 100 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 100")
end

				last_token := TE_DLLWIN_LANGUAGE
			
when 23 then
	yy_position := yy_position + 4
--|#line 103 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 103")
end

				last_token := TE_ENUM
			
when 24 then
	yy_position := yy_position + 5
--|#line 106 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 106")
end

				last_token := TE_FIELD
			
when 25 then
	yy_position := yy_position + 12
--|#line 109 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 109")
end

				last_token := TE_GET_PROPERTY
			
when 26 then
	yy_position := yy_position + 2
--|#line 112 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 112")
end

				last_token := TE_IL_LANGUAGE
			
when 27 then
	yy_position := yy_position + 6
--|#line 115 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 115")
end

				last_token := TE_INLINE
			
when 28 then
	yy_position := yy_position + 3
--|#line 118 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 118")
end

				last_token := TE_JAVA_LANGUAGE
			
when 29 then
	yy_position := yy_position + 5
--|#line 121 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 121")
end

				last_token := TE_MACRO
			
when 30 then
	yy_position := yy_position + 8
--|#line 124 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 124")
end

				last_token := TE_OPERATOR
			
when 31 then
	yy_position := yy_position + 9
--|#line 127 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 127")
end

				last_token := TE_SET_FIELD
			
when 32 then
	yy_position := yy_position + 12
--|#line 130 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 130")
end

				last_token := TE_SET_PROPERTY
			
when 33 then
	yy_position := yy_position + 16
--|#line 133 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 133")
end

				last_token := TE_SET_STATIC_FIELD
			
when 34 then
	yy_position := yy_position + 9
--|#line 136 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 136")
end

				last_token := TE_SIGNATURE
			
when 35 then
	yy_position := yy_position + 6
--|#line 139 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 139")
end

				last_token := TE_SIGNED
			
when 36 then
	yy_position := yy_position + 6
--|#line 142 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 142")
end

				last_token := TE_STATIC
			
when 37 then
	yy_position := yy_position + 12
--|#line 145 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 145")
end

				last_token := TE_STATIC_FIELD
			
when 38 then
	yy_position := yy_position + 6
--|#line 148 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 148")
end

				last_token := TE_STRUCT
			
when 39 then
	yy_position := yy_position + 4
--|#line 151 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 151")
end

				last_token := TE_TYPE
			
when 40 then
	yy_position := yy_position + 8
--|#line 154 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 154")
end

				last_token := TE_UNSIGNED
			
when 41 then
	yy_position := yy_position + 3
--|#line 157 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 157")
end

				last_token := TE_USE
			
when 42 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 162 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 162")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_INTEGER
			
when 43 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 169 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 169")
end

					-- To escape external keywords.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_ID
			
when 44 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 177 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 177")
end

					-- Traditional identifier
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_ID
			
when 45 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 183 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 183")
end

					-- Special identifier for include files that specifies
					-- a path, e.g. <sys/timeb.h>, or path that includes an hyphenation.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INCLUDE_ID
			
when 46 then
	yy_position := yy_position + 1
--|#line 191 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 191")
end

when 47 then
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
			   21,   22,   23,   24,   25,   26,   15,   27,   28,   15,
			   15,   29,   15,   30,   15,   15,   15,   34,   32,   35,
			   15,   15,   15,   36,   39,   36,   43,   39,   39,   40,
			   40,   41,   39,   41,   41,   41,   41,   41,   39,   41,
			   43,   41,   39,   47,   93,   41,   45,   41,   39,   41,

			   36,   41,   36,   40,   39,   41,   38,   41,   42,   46,
			   67,   41,   50,   41,   41,   39,   41,   41,   37,   51,
			   44,   48,   41,   45,   41,   42,   38,   52,   53,   37,
			   49,   39,  224,  224,   39,   54,   46,  224,   41,   50,
			   41,   41,   39,   41,  224,  224,   51,  224,   48,   41,
			   39,   41,  224,  224,   52,   53,   39,   41,   55,   41,
			   56,  224,   54,   41,  224,   41,   58,  224,  224,  224,
			   39,   57,  224,   59,   39,   39,   60,   41,  224,   41,
			   61,   41,   41,   41,   41,   55,  224,   56,  224,  224,
			  224,   62,  224,   58,  224,   60,  224,   39,   57,   61,

			   59,  224,  224,   60,   41,   39,   41,   61,   64,   63,
			   62,   68,   41,  224,   41,   68,   43,  224,   62,   43,
			   43,  224,   60,   43,   43,   44,   65,  224,   43,  224,
			  224,   64,   39,   39,  224,   64,   63,   62,   39,   41,
			   41,   41,   41,   71,  224,   41,  224,   41,  224,  224,
			   69,   43,   43,   66,  224,   43,   43,  224,   64,   39,
			   39,  224,  224,   70,   39,   39,   41,   41,   41,   41,
			  224,   41,   41,   41,   41,  224,  224,   69,  224,   72,
			   39,  224,  224,  224,   73,   75,  224,   41,   39,   41,
			   70,   76,   77,   39,   39,   41,  224,   41,   74,  224,

			   41,   41,   41,   41,  224,  224,   72,  224,   79,  224,
			  224,   73,   75,   39,   39,  224,   78,   39,   76,   77,
			   41,   41,   41,   41,   41,   74,   41,   39,   80,  224,
			  224,  224,  224,  224,   41,   79,   41,   84,  224,   39,
			   81,  224,   82,   78,   39,   83,   41,   39,   41,  224,
			   39,   41,  224,   41,   41,   80,   41,   41,  224,   41,
			  224,  224,  224,   87,   84,  224,   86,   81,   39,   82,
			  224,  224,   83,  224,   85,   41,   39,   41,  224,  224,
			   88,   89,   39,   41,  224,   41,  224,   39,   90,   41,
			   87,   41,  224,   86,   41,  224,   41,   39,   86,  224,

			  224,   85,   39,   39,   41,   95,   41,   88,   89,   41,
			   41,   41,   41,   39,   39,   90,  224,   94,  224,   96,
			   41,   41,   41,   41,   39,   91,  224,   39,   39,  224,
			  224,   41,   95,   41,   41,   41,   41,   41,   98,  224,
			  224,  224,   97,   92,   94,   39,   96,   99,  100,   39,
			   39,  224,   41,  224,   41,  224,   41,   41,   41,   41,
			  224,   39,  101,  224,  224,   98,  224,  224,   41,   97,
			   41,   39,   39,  102,   99,  100,  103,   39,   41,   41,
			   41,   41,  224,  224,   41,  105,   41,   39,   39,  101,
			  224,  224,  104,  224,   41,   41,   41,   41,  224,   39,

			  102,  224,   39,  103,  224,  106,   41,   39,   41,   41,
			  107,   41,  105,   39,   41,  224,   41,  109,  224,   39,
			   41,  224,   41,  224,  224,  224,   41,  112,   41,  108,
			  224,  224,  106,   39,  110,  224,   39,  107,  111,  224,
			   41,  224,   41,   41,  109,   41,   39,  224,  109,   39,
			   39,  224,  224,   41,  112,   41,   41,   41,   41,   41,
			   39,  110,  224,  224,  224,  111,  224,   41,  224,   41,
			  115,   39,  116,  224,   39,  113,  118,  224,   41,   39,
			   41,   41,   39,   41,  114,  117,   41,   39,   41,   41,
			  224,   41,  224,   39,   41,  119,   41,  115,   39,  116,

			   41,   39,   41,  118,  120,   41,  122,   41,   41,  121,
			   41,  224,  117,  224,  224,  224,  224,  123,  124,   39,
			   39,  224,  119,  126,  224,   39,   41,   41,   41,   41,
			  125,  120,   41,  122,   41,  127,  121,  224,  224,   39,
			  224,  128,  224,  224,  123,  124,   41,  224,   41,  132,
			  126,  129,   39,  224,  130,  131,   39,  125,  224,   41,
			   39,   41,  127,   41,   39,   41,  224,   41,  128,   41,
			  133,   41,  224,   41,  224,  224,  132,  224,  129,   39,
			  131,  130,  131,  224,   39,   39,   41,  224,   41,   39,
			  224,   41,   41,   41,   41,   39,   41,  133,   41,  224,

			  224,  224,   41,  224,   41,  224,  224,  131,  137,  135,
			  224,  134,  140,  136,   39,  138,  224,   39,  224,  139,
			   39,   41,  224,   41,   41,   39,   41,   41,  224,   41,
			  224,  224,   41,  224,   41,  137,   39,  142,  224,  140,
			  136,   39,  138,   41,   39,   41,  139,  141,   41,  143,
			   41,   41,  224,   41,  224,  224,   39,  224,  224,   39,
			  224,  145,  224,   41,  142,   41,   41,  224,   41,  144,
			   39,   39,  224,  224,  141,   39,  143,   41,   41,   41,
			   41,  224,   41,  147,   41,   39,   39,  224,  145,  224,
			   39,  146,   41,   41,   41,   41,  144,   41,   39,   41,

			  224,  224,   39,  148,  151,   41,  149,   41,   39,   41,
			  147,   41,  224,  224,  224,   41,  224,   41,  146,   39,
			  150,  153,  224,  224,  224,  152,   41,   39,   41,  224,
			  148,  151,   39,  149,   41,   39,   41,  155,  224,   41,
			  224,   41,   41,  224,   41,  224,  224,  150,  157,   39,
			   39,  224,  152,  224,  154,  159,   41,   41,   41,   41,
			  156,   39,  158,  224,  155,   39,  224,  224,   41,   39,
			   41,  224,   41,  224,   41,  157,   41,   39,   41,  224,
			  224,   39,  159,  224,   41,   39,   41,  156,   41,  158,
			   41,  160,   41,   39,   41,  224,  224,  162,   39,  161,

			   41,  164,   41,   39,  224,   41,   39,   41,  224,  224,
			   41,  163,   41,   41,   39,   41,  224,  224,  160,  224,
			  224,   41,  224,   41,  162,   39,  161,  224,  164,  165,
			   39,  224,   41,  224,   41,   39,   39,   41,  163,   41,
			  166,   39,   41,   41,   41,   41,  224,  168,   41,  224,
			   41,  224,  224,  224,  224,  169,  165,   39,   39,  224,
			  171,  167,   39,  224,   41,   41,   41,   41,  224,   41,
			   39,   41,  170,  224,  168,  224,   39,   41,  224,   41,
			  224,  224,  169,   41,  224,   41,   39,  171,  172,  174,
			  224,  173,  224,   41,  224,   41,   39,   39,  224,  170,

			   39,  175,  224,   41,   41,   41,   41,   41,  224,   41,
			  224,  176,  224,   39,   39,  172,  174,  178,  173,  177,
			   41,   41,   41,   41,   39,   39,  224,  224,  175,  224,
			   39,   41,   41,   41,   41,  224,  224,   41,  176,   41,
			  224,   39,  224,  179,  178,  182,  177,   39,   41,  181,
			   41,  180,  224,  224,   41,   39,   41,  224,  224,  224,
			  183,   39,   41,  224,   41,  224,   39,  184,   41,  224,
			   41,  224,  182,   41,  224,   41,  181,   39,  180,  185,
			  224,  186,   39,  224,   41,  224,   41,  183,   39,   41,
			  187,   41,   39,  224,  184,   41,   39,   41,  224,   41,

			  189,   41,   39,   41,  224,   41,  185,   39,  186,   41,
			  224,   41,  188,   39,   41,  224,   41,  187,  224,  224,
			   41,   39,   41,  224,  224,  190,  224,  189,   41,   39,
			   41,  192,  224,   39,  224,  191,   41,   39,   41,  188,
			   41,  193,   41,  224,   41,  224,   41,   39,   39,  224,
			  224,  224,  190,  224,   41,   41,   41,   41,  192,  224,
			  224,  224,  191,  224,  194,  224,   39,   39,  193,  195,
			  224,   39,  196,   41,   41,   41,   41,   39,   41,  224,
			   41,  224,  197,  224,   41,  224,   41,  224,  224,  224,
			  198,  194,  224,  199,  200,   39,  195,  224,   39,  196,

			  201,  224,   41,   39,   41,   41,   39,   41,  224,  197,
			   41,  224,   41,   41,  224,   41,  202,   39,  224,  204,
			  199,  200,  205,   39,   41,  224,   41,  201,   39,  224,
			   41,   39,   41,  224,  203,   41,  206,   41,   41,  224,
			   41,  224,  224,  202,   39,   39,  204,  224,  224,  205,
			  207,   41,   41,   41,   41,  208,  224,  224,   39,   39,
			  224,  203,   39,  206,  224,   41,   41,   41,   41,   41,
			  224,   41,  224,  224,  224,  224,   39,  207,  210,  211,
			   39,  209,  208,   41,   39,   41,  224,   41,  224,   41,
			  224,   41,   39,   41,  224,  224,  224,  212,  224,   41,

			  224,   41,  215,  214,   39,  210,  211,   39,  209,  213,
			   39,   41,  224,   41,   41,  224,   41,   41,  224,   41,
			  224,  224,  224,  217,  212,   39,   39,  216,  224,  215,
			  214,   39,   41,   41,   41,   41,  213,   39,   41,  224,
			   41,  224,   39,  218,   41,  224,   41,  224,  224,   41,
			  217,   41,  224,   39,  216,  224,   39,  221,  224,  219,
			   41,  224,   41,   41,  220,   41,  224,  224,  224,  224,
			  218,  222,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  221,  224,  219,  224,  223,  224,
			  224,  220,  224,  224,  224,  224,  224,  224,  222,  224,

			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  223,    3,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224, yy_Dummy>>)
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
			    1,    1,    1,    5,    9,    5,  227,   15,   20,  225,
			  225,    9,   21,    9,   15,   20,   15,   20,   22,   21,
			   93,   21,   23,   22,   68,   22,   20,   22,   24,   23,

			   36,   23,   36,   67,   25,   24,   42,   24,   41,   21,
			   39,   25,   23,   25,   38,   26,  226,  226,   37,   23,
			   19,   22,   26,   20,   26,   13,    8,   24,   25,    6,
			   22,   27,    3,    0,   28,   26,   21,    0,   27,   23,
			   27,   28,   30,   28,    0,    0,   23,    0,   22,   30,
			   29,   30,    0,    0,   24,   25,   31,   29,   27,   29,
			   27,    0,   26,   31,    0,   31,   29,    0,    0,    0,
			   32,   28,    0,   30,   33,   34,   31,   32,    0,   32,
			   31,   33,   34,   33,   34,   27,    0,   27,    0,    0,
			    0,   31,    0,   29,    0,   34,    0,   35,   28,   34,

			   30,    0,    0,   31,   35,   40,   35,   31,   33,   32,
			   34,   43,   40,    0,   40,   44,   43,    0,   31,   43,
			   44,    0,   34,   44,   43,   44,   34,    0,   44,    0,
			    0,   35,   45,   46,    0,   33,   32,   34,   47,   45,
			   46,   45,   46,   47,    0,   47,    0,   47,    0,    0,
			   45,   43,   43,   35,    0,   44,   44,    0,   35,   48,
			   49,    0,    0,   46,   50,   51,   48,   49,   48,   49,
			    0,   50,   51,   50,   51,    0,    0,   45,    0,   48,
			   52,    0,    0,    0,   49,   50,    0,   52,   53,   52,
			   46,   50,   51,   54,   55,   53,    0,   53,   49,    0,

			   54,   55,   54,   55,    0,    0,   48,    0,   53,    0,
			    0,   49,   50,   56,   57,    0,   52,   59,   50,   51,
			   56,   57,   56,   57,   59,   49,   59,   58,   54,    0,
			    0,    0,    0,    0,   58,   53,   58,   59,    0,   60,
			   56,    0,   57,   52,   61,   58,   60,   62,   60,    0,
			   63,   61,    0,   61,   62,   54,   62,   63,    0,   63,
			    0,    0,    0,   62,   59,    0,   61,   56,   64,   57,
			    0,    0,   58,    0,   60,   64,   65,   64,    0,    0,
			   62,   63,   66,   65,    0,   65,    0,   70,   64,   66,
			   62,   66,    0,   61,   70,    0,   70,   69,   65,    0,

			    0,   60,   71,   72,   69,   70,   69,   62,   63,   71,
			   72,   71,   72,   73,   74,   64,    0,   69,    0,   72,
			   73,   74,   73,   74,   77,   65,    0,   75,   76,    0,
			    0,   77,   70,   77,   75,   76,   75,   76,   74,    0,
			    0,    0,   73,   66,   69,   78,   72,   75,   76,   79,
			   80,    0,   78,    0,   78,    0,   79,   80,   79,   80,
			    0,   81,   77,    0,    0,   74,    0,    0,   81,   73,
			   81,   82,   83,   78,   75,   76,   79,   84,   82,   83,
			   82,   83,    0,    0,   84,   81,   84,   85,   86,   77,
			    0,    0,   80,    0,   85,   86,   85,   86,    0,   87,

			   78,    0,   88,   79,    0,   83,   87,   89,   87,   88,
			   84,   88,   81,   90,   89,    0,   89,   86,    0,   91,
			   90,    0,   90,    0,    0,    0,   91,   89,   91,   85,
			    0,    0,   83,   92,   87,    0,   94,   84,   88,    0,
			   92,    0,   92,   94,   86,   94,   95,    0,   91,   97,
			   96,    0,    0,   95,   89,   95,   97,   96,   97,   96,
			   98,   87,    0,    0,    0,   88,    0,   98,    0,   98,
			   94,   99,   95,    0,  100,   91,   97,    0,   99,  102,
			   99,  100,  101,  100,   92,   96,  102,  104,  102,  101,
			    0,  101,    0,  106,  104,   98,  104,   94,  103,   95,

			  106,  105,  106,   97,   99,  103,  101,  103,  105,  100,
			  105,    0,   96,    0,    0,    0,    0,  103,  104,  107,
			  108,    0,   98,  106,    0,  110,  107,  108,  107,  108,
			  105,   99,  110,  101,  110,  107,  100,    0,    0,  109,
			    0,  108,    0,    0,  103,  104,  109,    0,  109,  110,
			  106,  108,  111,    0,  108,  109,  112,  105,    0,  111,
			  114,  111,  107,  112,  113,  112,    0,  114,  108,  114,
			  111,  113,    0,  113,    0,    0,  110,    0,  108,  115,
			  113,  108,  109,    0,  116,  117,  115,    0,  115,  119,
			    0,  116,  117,  116,  117,  118,  119,  111,  119,    0,

			    0,    0,  118,    0,  118,    0,    0,  113,  116,  114,
			    0,  113,  119,  115,  120,  117,    0,  121,    0,  118,
			  122,  120,    0,  120,  121,  123,  121,  122,    0,  122,
			    0,    0,  123,    0,  123,  116,  124,  121,    0,  119,
			  115,  125,  117,  124,  126,  124,  118,  120,  125,  122,
			  125,  126,    0,  126,    0,    0,  127,    0,    0,  128,
			    0,  125,    0,  127,  121,  127,  128,    0,  128,  124,
			  129,  130,    0,    0,  120,  134,  122,  129,  130,  129,
			  130,    0,  134,  128,  134,  131,  132,    0,  125,    0,
			  133,  127,  131,  132,  131,  132,  124,  133,  135,  133,

			    0,    0,  136,  129,  132,  135,  130,  135,  137,  136,
			  128,  136,    0,    0,    0,  137,    0,  137,  127,  139,
			  131,  134,    0,    0,    0,  133,  139,  138,  139,    0,
			  129,  132,  140,  130,  138,  141,  138,  137,    0,  140,
			    0,  140,  141,    0,  141,    0,    0,  131,  139,  142,
			  143,    0,  133,    0,  135,  141,  142,  143,  142,  143,
			  138,  144,  140,    0,  137,  145,    0,    0,  144,  146,
			  144,    0,  145,    0,  145,  139,  146,  147,  146,    0,
			    0,  148,  141,    0,  147,  149,  147,  138,  148,  140,
			  148,  144,  149,  150,  149,    0,    0,  147,  151,  146,

			  150,  149,  150,  152,    0,  151,  153,  151,    0,    0,
			  152,  148,  152,  153,  154,  153,    0,    0,  144,    0,
			    0,  154,    0,  154,  147,  155,  146,    0,  149,  150,
			  156,    0,  155,    0,  155,  157,  158,  156,  148,  156,
			  151,  159,  157,  158,  157,  158,    0,  155,  159,    0,
			  159,    0,    0,    0,    0,  157,  150,  160,  161,    0,
			  159,  154,  162,    0,  160,  161,  160,  161,    0,  162,
			  163,  162,  158,    0,  155,    0,  164,  163,    0,  163,
			    0,    0,  157,  164,    0,  164,  165,  159,  160,  162,
			    0,  161,    0,  165,    0,  165,  166,  167,    0,  158,

			  168,  163,    0,  166,  167,  166,  167,  168,    0,  168,
			    0,  164,    0,  169,  170,  160,  162,  166,  161,  165,
			  169,  170,  169,  170,  171,  172,    0,    0,  163,    0,
			  173,  171,  172,  171,  172,    0,    0,  173,  164,  173,
			    0,  174,    0,  167,  166,  172,  165,  175,  174,  170,
			  174,  169,    0,    0,  175,  176,  175,    0,    0,    0,
			  174,  177,  176,    0,  176,    0,  178,  175,  177,    0,
			  177,    0,  172,  178,    0,  178,  170,  179,  169,  176,
			    0,  177,  181,    0,  179,    0,  179,  174,  180,  181,
			  178,  181,  182,    0,  175,  180,  183,  180,    0,  182,

			  181,  182,  184,  183,    0,  183,  176,  186,  177,  184,
			    0,  184,  180,  185,  186,    0,  186,  178,    0,    0,
			  185,  187,  185,    0,    0,  182,    0,  181,  187,  188,
			  187,  185,    0,  189,    0,  184,  188,  190,  188,  180,
			  189,  187,  189,    0,  190,    0,  190,  191,  192,    0,
			    0,    0,  182,    0,  191,  192,  191,  192,  185,    0,
			    0,    0,  184,    0,  188,    0,  193,  195,  187,  189,
			    0,  194,  190,  193,  195,  193,  195,  196,  194,    0,
			  194,    0,  191,    0,  196,    0,  196,    0,    0,    0,
			  192,  188,    0,  193,  194,  197,  189,    0,  198,  190,

			  195,    0,  197,  199,  197,  198,  200,  198,    0,  191,
			  199,    0,  199,  200,    0,  200,  196,  201,    0,  198,
			  193,  194,  199,  202,  201,    0,  201,  195,  203,    0,
			  202,  204,  202,    0,  197,  203,  200,  203,  204,    0,
			  204,    0,    0,  196,  205,  206,  198,    0,    0,  199,
			  201,  205,  206,  205,  206,  204,    0,    0,  207,  208,
			    0,  197,  209,  200,    0,  207,  208,  207,  208,  209,
			    0,  209,    0,    0,    0,    0,  211,  201,  207,  208,
			  210,  206,  204,  211,  212,  211,    0,  210,    0,  210,
			    0,  212,  213,  212,    0,    0,    0,  209,    0,  213,

			    0,  213,  212,  211,  214,  207,  208,  215,  206,  210,
			  216,  214,    0,  214,  215,    0,  215,  216,    0,  216,
			    0,    0,    0,  214,  209,  217,  218,  213,    0,  212,
			  211,  219,  217,  218,  217,  218,  210,  220,  219,    0,
			  219,    0,  221,  215,  220,    0,  220,    0,    0,  221,
			  214,  221,    0,  222,  213,    0,  223,  220,    0,  218,
			  222,    0,  222,  223,  219,  223,    0,    0,    0,    0,
			  215,  221,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  220,    0,  218,    0,  222,    0,
			    0,  219,    0,    0,    0,    0,    0,    0,  221,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  222,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  132, 1416,   71,  126, 1416,  114,   68,
			 1416, 1416, 1416,  119, 1416,   71, 1416, 1416, 1416,  104,
			   72,   76,   82,   86,   92,   98,  109,  125,  128,  144,
			  136,  150,  164,  168,  169,  191,   98,  115,  110,   98,
			  199,  102,   94,  205,  209,  226,  227,  232,  253,  254,
			  258,  259,  274,  282,  287,  288,  307,  308,  321,  311,
			  333,  338,  341,  344,  362,  370,  376,   99,   82,  391,
			  381,  396,  397,  407,  408,  421,  422,  418,  439,  443,
			  444,  455,  465,  466,  471,  481,  482,  493,  496,  501,
			  507,  513,  527,   86,  530,  540,  544,  543,  554,  565,

			  568,  576,  573,  592,  581,  595,  587,  613,  614,  633,
			  619,  646,  650,  658,  654,  673,  678,  679,  689,  683,
			  708,  711,  714,  719,  730,  735,  738,  750,  753,  764,
			  765,  779,  780,  784,  769,  792,  796,  802,  821,  813,
			  826,  829,  843,  844,  855,  859,  863,  871,  875,  879,
			  887,  892,  897,  900,  908,  919,  924,  929,  930,  935,
			  951,  952,  956,  964,  970,  980,  990,  991,  994, 1007,
			 1008, 1018, 1019, 1024, 1035, 1041, 1049, 1055, 1060, 1071,
			 1082, 1076, 1086, 1090, 1096, 1107, 1101, 1115, 1123, 1127,
			 1131, 1141, 1142, 1160, 1165, 1161, 1171, 1189, 1192, 1197,

			 1200, 1211, 1217, 1222, 1225, 1238, 1239, 1252, 1253, 1256,
			 1274, 1270, 1278, 1286, 1298, 1301, 1304, 1319, 1320, 1325,
			 1331, 1336, 1347, 1350, 1416,   77,  114,   73, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  224,    1,  224,  224,  224,  224,  224,  224,  225,
			  224,  224,  224,  226,  224,  225,  224,  224,  224,  227,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  224,  224,  224,  224,
			  225,  226,  224,  227,  227,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  224,  224,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  224,  225,  225,  225,  225,  225,  225,

			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,

			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,    0,  224,  224,  224, yy_Dummy>>)
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
			    0,    0,    0,   48,   46,    1,    2,   11,   46,    8,
			    4,    5,    7,   45,    6,   44,    3,    9,   10,   42,
			   44,   44,   14,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,    1,    2,    0,    0,
			   44,   45,    0,   43,   42,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   26,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,    0,    0,   44,
			   44,   17,   44,   44,   44,   44,   44,   21,   44,   44,
			   44,   44,   28,   44,   44,   44,   44,   44,   44,   44,
			   41,   44,   44,    0,   44,   44,   44,   44,   44,   44,

			   44,   44,   23,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   39,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,   24,   44,   44,   29,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   12,   44,   44,   44,
			   44,   44,   20,   22,   44,   27,   44,   44,   44,   44,
			   44,   36,   38,   35,   44,   44,   18,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   13,   44,
			   44,   19,   44,   30,   44,   44,   44,   44,   44,   40,
			   44,   44,   44,   31,   44,   44,   34,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   44,

			   44,   44,   25,   32,   44,   37,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   15,   33,   44,   44,
			   44,   44,   44,   16,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1416
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 224
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 225
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

	yyNb_rules: INTEGER is 47
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 48
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

end -- class EXTERNAL_SCANNER


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
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
