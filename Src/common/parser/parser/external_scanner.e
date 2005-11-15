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
	yy_position := yy_position + 8
--|#line 76 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 76")
end

				last_token := TE_BUILT_IN
			
when 15 then
	yy_position := yy_position + 1
--|#line 79 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 79")
end

				last_token := TE_C_LANGUAGE
			
when 16 then
	yy_position := yy_position + 16
--|#line 82 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 82")
end

				last_token := TE_C_LANGUAGE
			
when 17 then
	yy_position := yy_position + 22
--|#line 85 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 85")
end

				last_token := TE_C_LANGUAGE
			
when 18 then
	yy_position := yy_position + 3
--|#line 88 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 88")
end

				last_token := TE_CPP_LANGUAGE
			
when 19 then
	yy_position := yy_position + 7
--|#line 91 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 91")
end

				last_token := TE_CREATOR
			
when 20 then
	yy_position := yy_position + 8
--|#line 94 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 94")
end

				last_token := TE_DEFERRED
			
when 21 then
	yy_position := yy_position + 6
--|#line 97 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 97")
end

				last_token := TE_DELETE
			
when 22 then
	yy_position := yy_position + 3
--|#line 100 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 100")
end

				last_token := TE_DLL_LANGUAGE
			
when 23 then
	yy_position := yy_position + 6
--|#line 103 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 103")
end

				last_token := TE_DLLWIN_LANGUAGE
			
when 24 then
	yy_position := yy_position + 4
--|#line 106 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 106")
end

				last_token := TE_ENUM
			
when 25 then
	yy_position := yy_position + 5
--|#line 109 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 109")
end

				last_token := TE_FIELD
			
when 26 then
	yy_position := yy_position + 12
--|#line 112 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 112")
end

				last_token := TE_GET_PROPERTY
			
when 27 then
	yy_position := yy_position + 2
--|#line 115 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 115")
end

				last_token := TE_IL_LANGUAGE
			
when 28 then
	yy_position := yy_position + 6
--|#line 118 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 118")
end

				last_token := TE_INLINE
			
when 29 then
	yy_position := yy_position + 3
--|#line 121 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 121")
end

				last_token := TE_JAVA_LANGUAGE
			
when 30 then
	yy_position := yy_position + 5
--|#line 124 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 124")
end

				last_token := TE_MACRO
			
when 31 then
	yy_position := yy_position + 8
--|#line 127 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 127")
end

				last_token := TE_OPERATOR
			
when 32 then
	yy_position := yy_position + 9
--|#line 130 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 130")
end

				last_token := TE_SET_FIELD
			
when 33 then
	yy_position := yy_position + 12
--|#line 133 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 133")
end

				last_token := TE_SET_PROPERTY
			
when 34 then
	yy_position := yy_position + 16
--|#line 136 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 136")
end

				last_token := TE_SET_STATIC_FIELD
			
when 35 then
	yy_position := yy_position + 9
--|#line 139 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 139")
end

				last_token := TE_SIGNATURE
			
when 36 then
	yy_position := yy_position + 6
--|#line 142 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 142")
end

				last_token := TE_SIGNED
			
when 37 then
	yy_position := yy_position + 6
--|#line 145 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 145")
end

				last_token := TE_STATIC
			
when 38 then
	yy_position := yy_position + 12
--|#line 148 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 148")
end

				last_token := TE_STATIC_FIELD
			
when 39 then
	yy_position := yy_position + 6
--|#line 151 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 151")
end

				last_token := TE_STRUCT
			
when 40 then
	yy_position := yy_position + 4
--|#line 154 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 154")
end

				last_token := TE_TYPE
			
when 41 then
	yy_position := yy_position + 8
--|#line 157 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 157")
end

				last_token := TE_UNSIGNED
			
when 42 then
	yy_position := yy_position + 3
--|#line 160 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 160")
end

				last_token := TE_USE
			
when 43 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 165 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 165")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_INTEGER
			
when 44 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 172 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 172")
end

					-- To escape external keywords.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_ID
			
when 45 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 180 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 180")
end

					-- Traditional identifier
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_ID
			
when 46 then
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 186 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 186")
end

					-- Special identifier for include files that specifies
					-- a path, e.g. <sys/timeb.h>, or path that includes an hyphenation.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INCLUDE_ID
			
when 47 then
	yy_position := yy_position + 1
--|#line 194 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 194")
end

when 48 then
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
			   43,   41,   39,   48,   95,   41,   45,   41,   39,   41,

			   36,   41,   36,   40,   39,   41,   38,   41,   42,   46,
			   68,   41,   51,   41,   41,   39,   41,   41,   47,   52,
			   37,   49,   41,   45,   41,   44,   42,   53,   54,   38,
			   50,   39,   37,  231,   39,   55,   46,  231,   41,   51,
			   41,   41,   39,   41,  231,   47,   52,  231,   49,   41,
			   39,   41,  231,  231,   53,   54,   39,   41,   56,   41,
			   57,  231,   55,   41,  231,   41,   59,  231,  231,  231,
			   39,   58,  231,   60,   39,   39,   61,   41,  231,   41,
			   62,   41,   41,   41,   41,   56,  231,   57,  231,  231,
			  231,   63,  231,   59,  231,   61,  231,   39,   58,   62,

			   60,  231,  231,   61,   41,   39,   41,   62,   65,   64,
			   63,   69,   41,  231,   41,   69,   43,  231,   63,   43,
			   43,  231,   61,   43,   43,   44,   66,  231,   43,  231,
			  231,   65,   39,   39,  231,   65,   64,   63,   39,   41,
			   41,   41,   41,  231,  231,   41,  231,   41,  231,  231,
			   70,   43,   43,   67,  231,   43,   43,  231,   65,   39,
			   39,  231,   72,   71,   73,  231,   41,   41,   41,   41,
			  231,  231,   39,  231,  231,   39,   39,   70,  231,   41,
			   74,   41,   41,   41,   41,   41,   39,  231,  231,   72,
			   71,   39,   39,   41,  231,   41,   75,   77,   41,   41,

			   41,   41,   79,   78,  231,   39,   39,   74,  231,   39,
			   76,   81,   41,   41,   41,   41,   41,  231,   41,   39,
			  231,  231,   80,   75,   77,   39,   41,   82,   41,   79,
			   78,   88,   41,   83,   41,   39,  231,   76,   81,  231,
			  231,   39,   41,   85,   41,  231,  231,   84,   41,   80,
			   41,  231,   39,  231,   82,   86,   39,   39,   88,   41,
			   83,   41,   39,   41,   41,   41,   41,  231,   89,   41,
			   85,   41,   39,  231,   84,  231,   87,   92,  231,   41,
			  231,   41,   86,   39,   88,   90,  231,   91,  231,   39,
			   41,  231,   41,   39,  231,   89,   41,  231,   41,   39,

			   41,   97,   41,   87,   92,  231,   41,  231,   41,   96,
			   39,   93,   90,  231,   91,   39,   39,   41,  231,   41,
			   98,  231,   41,   41,   41,   41,   99,  231,   97,  231,
			   39,  231,  231,   94,   39,  231,   96,   41,  231,   41,
			  101,   41,   39,   41,  100,  231,  231,   98,   39,   41,
			  102,   41,   39,   99,  103,   41,   39,   41,  231,   41,
			  231,   41,  231,   41,  231,   41,   39,  101,  231,  231,
			  231,  100,  231,   41,  231,   41,  105,  102,   39,  106,
			  104,  103,   39,  231,  231,   41,   39,   41,  231,   41,
			  108,   41,   39,   41,  231,   41,  231,  231,  107,   41,

			  231,   41,   39,  105,  231,   39,  106,  104,  231,   41,
			  231,   41,   41,   39,   41,  109,   39,  108,  231,  110,
			   41,   39,   41,   41,  231,   41,   39,  231,   41,  231,
			   41,  112,   39,   41,  111,   41,  115,  231,   39,   41,
			  113,   41,  109,   39,   39,   41,  110,   41,  231,  114,
			   41,   41,   41,   41,  231,  112,  231,   39,  112,  231,
			  231,   39,  231,  115,   41,  231,   41,  113,   41,  119,
			   41,   39,  118,  231,  231,  231,  114,   39,   41,  120,
			   41,  231,  116,  117,   41,  231,   41,  231,  122,  231,
			  231,   39,  121,  231,   39,  231,  119,  231,   41,  118,

			   41,   41,   39,   41,  124,  231,  120,   39,  231,   41,
			  231,   41,  123,   39,   41,  122,   41,  231,  126,  121,
			   41,   39,   41,  231,  231,  231,  125,   39,   41,  231,
			   41,  124,  127,   39,   41,  231,   41,   39,  128,  123,
			   41,  231,   41,  231,   41,  126,   41,   39,  231,  131,
			  129,  231,  231,  125,   41,   39,   41,  130,  132,  127,
			   39,  231,   41,  135,   41,  128,   39,   41,  133,   41,
			  231,  134,  231,   41,   39,   41,  131,  129,  137,  136,
			   39,   41,  231,   41,  130,  132,  231,   41,  231,   41,
			  135,  231,   39,   39,  231,  133,  135,  231,  134,   41,

			   41,   41,   41,   39,   39,  137,  136,   39,  140,  231,
			   41,   41,   41,   41,   41,   39,   41,  141,  231,   39,
			  231,  231,   41,  135,   41,  231,   41,  138,   41,  231,
			   39,  144,  231,   39,  143,  140,  231,   41,  145,   41,
			   41,  139,   41,  231,  141,  142,   39,   39,  231,  231,
			  147,  231,  146,   41,   41,   41,   41,   39,  144,  231,
			   39,  143,  148,   39,   41,  145,   41,   41,  231,   41,
			   41,  231,   41,  231,  231,   39,  231,  147,   39,  146,
			  149,   39,   41,  150,   41,   41,  231,   41,   41,  148,
			   41,  231,  231,   39,   39,  151,  231,   39,  231,  152,

			   41,   41,   41,   41,   41,  231,   41,  149,   39,  231,
			  150,  153,  156,  231,   39,   41,  154,   41,   39,  231,
			  231,   41,  151,   41,   39,   41,  152,   41,  155,  231,
			  231,   41,  157,   41,  231,  231,  231,   39,  153,  156,
			   39,   39,  231,  154,   41,  231,   41,   41,   41,   41,
			   41,   39,  231,  160,  158,  155,   39,   39,   41,  157,
			   41,  161,  231,   41,   41,   41,   41,   39,  231,  231,
			  159,  164,   39,  162,   41,   39,   41,  165,  231,   41,
			  160,   41,   41,   39,   41,  163,   39,   39,  161,  231,
			   41,  231,   41,   41,   41,   41,   41,  231,  164,  231,

			  162,   39,  166,  231,  165,  231,  168,   39,   41,  231,
			   41,   39,  163,  167,   41,   39,   41,  169,   41,   39,
			   41,  231,   41,  170,   41,   39,   41,  231,   41,  166,
			  231,  231,   41,  168,   41,  231,   39,  171,  231,   39,
			  167,  231,   39,   41,  169,   41,   41,   39,   41,   41,
			  170,   41,   39,  172,   41,  231,   41,  231,  174,   41,
			  231,   41,   39,  231,  171,  231,   39,  176,  175,   41,
			   39,   41,  173,   41,  231,   41,  231,   41,  231,   41,
			   39,  178,  231,   39,   39,  174,  231,   41,  177,   41,
			   41,   41,   41,   41,  176,  175,  231,  179,  231,  231,

			  231,  231,   39,  180,  231,  231,  231,  181,  178,   41,
			  231,   41,  231,   39,  182,  177,   39,  231,  231,  183,
			   41,  231,   41,   41,  179,   41,  231,  231,  231,   39,
			  180,  231,  231,   39,  181,  184,   41,  185,   41,  231,
			   41,  182,   41,   39,   39,  231,  183,   39,   39,  231,
			   41,   41,   41,   41,   41,   41,   41,   41,   39,  186,
			  231,  231,  184,   39,  185,   41,   39,   41,  189,   39,
			   41,  231,   41,   41,  231,   41,   41,  231,   41,  188,
			   39,  187,  190,   39,  231,  231,  191,   41,  231,   41,
			   41,  231,   41,  192,   39,  189,  231,  231,  231,  231,

			  193,   41,  231,   41,  231,   39,  188,  194,  187,  190,
			   39,  231,   41,  191,   41,   39,   39,   41,  231,   41,
			  192,  231,   41,   41,   41,   41,   39,  193,  196,  195,
			   39,   39,  231,   41,  194,   41,  231,   41,   41,   41,
			   41,  231,  231,   39,   39,  231,  231,  231,  197,  199,
			   41,   41,   41,   41,  231,  196,  195,   39,  231,  198,
			   39,   39,  231,  200,   41,   39,   41,   41,   41,   41,
			   41,   39,   41,  231,   41,  197,  199,  231,   41,  201,
			   41,  231,   39,  231,  231,   39,  198,  231,  231,   41,
			  200,   41,   41,  202,   41,  203,  204,  231,  206,  231,

			  231,   39,   39,  231,  231,  207,  201,  205,   41,   41,
			   41,   41,   39,  231,  231,  231,  231,   39,  208,   41,
			  202,   41,  203,  204,   41,  206,   41,  231,   39,  231,
			  231,  231,  207,  211,  231,   41,  212,   41,  231,   39,
			  209,  210,   39,   39,  231,  208,   41,   39,   41,   41,
			   41,   41,   41,  231,   41,   39,   41,  231,  213,  231,
			  211,  231,   41,  212,   41,  231,   39,  209,  210,   39,
			   39,  215,  214,   41,   39,   41,   41,   41,   41,   41,
			  231,   41,  231,   41,   39,  213,  231,   39,   39,  217,
			  218,   41,  231,   41,   41,   41,   41,   41,  215,  214,

			  231,  231,  216,   39,  231,  231,  222,  231,  231,  219,
			   41,   39,   41,  220,  221,   39,  217,  218,   41,   39,
			   41,  231,   41,  231,   41,   39,   41,  231,   41,  216,
			  224,  231,   41,  222,   41,   39,  219,  231,  223,   39,
			  220,  221,   41,   39,   41,  231,   41,   39,   41,  231,
			   41,  225,   41,   39,   41,  231,   41,  224,  231,  231,
			   41,  231,   41,  228,   39,  223,  231,  231,  226,  231,
			  231,   41,  227,   41,  231,  231,  229,  231,  225,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  230,  231,
			  228,  231,  231,  231,  231,  226,  231,  231,  231,  227,

			  231,  231,  231,  229,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  230,    3,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231, yy_Dummy>>)
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
			    1,    1,    1,    5,    9,    5,  234,   15,   20,  232,
			  232,    9,   21,    9,   15,   20,   15,   20,   22,   21,
			   95,   21,   23,   22,   69,   22,   20,   22,   24,   23,

			   36,   23,   36,   68,   25,   24,   42,   24,   41,   21,
			   39,   25,   23,   25,   38,   26,  233,  233,   21,   23,
			   37,   22,   26,   20,   26,   19,   13,   24,   25,    8,
			   22,   27,    6,    3,   28,   26,   21,    0,   27,   23,
			   27,   28,   30,   28,    0,   21,   23,    0,   22,   30,
			   29,   30,    0,    0,   24,   25,   31,   29,   27,   29,
			   27,    0,   26,   31,    0,   31,   29,    0,    0,    0,
			   32,   28,    0,   30,   33,   34,   31,   32,    0,   32,
			   31,   33,   34,   33,   34,   27,    0,   27,    0,    0,
			    0,   31,    0,   29,    0,   34,    0,   35,   28,   34,

			   30,    0,    0,   31,   35,   40,   35,   31,   33,   32,
			   34,   43,   40,    0,   40,   44,   43,    0,   31,   43,
			   44,    0,   34,   44,   43,   44,   34,    0,   44,    0,
			    0,   35,   45,   46,    0,   33,   32,   34,   47,   45,
			   46,   45,   46,    0,    0,   47,    0,   47,    0,    0,
			   45,   43,   43,   35,    0,   44,   44,    0,   35,   48,
			   49,    0,   47,   46,   48,    0,   48,   49,   48,   49,
			    0,    0,   50,    0,    0,   52,   51,   45,    0,   50,
			   49,   50,   52,   51,   52,   51,   53,    0,    0,   47,
			   46,   54,   55,   53,    0,   53,   50,   51,   54,   55,

			   54,   55,   52,   51,    0,   56,   57,   49,    0,   62,
			   50,   54,   56,   57,   56,   57,   62,    0,   62,   58,
			    0,    0,   53,   50,   51,   59,   58,   55,   58,   52,
			   51,   62,   59,   57,   59,   60,    0,   50,   54,    0,
			    0,   61,   60,   59,   60,    0,    0,   58,   61,   53,
			   61,    0,   63,    0,   55,   60,   64,   65,   62,   63,
			   57,   63,   66,   64,   65,   64,   65,    0,   63,   66,
			   59,   66,   67,    0,   58,    0,   61,   65,    0,   67,
			    0,   67,   60,   71,   66,   63,    0,   64,    0,   70,
			   71,    0,   71,   72,    0,   63,   70,    0,   70,   73,

			   72,   71,   72,   61,   65,    0,   73,    0,   73,   70,
			   74,   66,   63,    0,   64,   75,   76,   74,    0,   74,
			   72,    0,   75,   76,   75,   76,   74,    0,   71,    0,
			   77,    0,    0,   67,   78,    0,   70,   77,    0,   77,
			   76,   78,   79,   78,   75,    0,    0,   72,   80,   79,
			   77,   79,   81,   74,   78,   80,   82,   80,    0,   81,
			    0,   81,    0,   82,    0,   82,   83,   76,    0,    0,
			    0,   75,    0,   83,    0,   83,   80,   77,   84,   81,
			   79,   78,   85,    0,    0,   84,   86,   84,    0,   85,
			   83,   85,   87,   86,    0,   86,    0,    0,   82,   87,

			    0,   87,   88,   80,    0,   89,   81,   79,    0,   88,
			    0,   88,   89,   90,   89,   85,   91,   83,    0,   86,
			   90,   92,   90,   91,    0,   91,   93,    0,   92,    0,
			   92,   88,   94,   93,   87,   93,   91,    0,   96,   94,
			   89,   94,   85,   97,   98,   96,   86,   96,    0,   90,
			   97,   98,   97,   98,    0,   93,    0,   99,   88,    0,
			    0,  100,    0,   91,   99,    0,   99,   89,  100,   97,
			  100,  102,   96,    0,    0,    0,   90,  101,  102,   98,
			  102,    0,   93,   94,  101,    0,  101,    0,  100,    0,
			    0,  103,   99,    0,  104,    0,   97,    0,  103,   96,

			  103,  104,  105,  104,  102,    0,   98,  107,    0,  105,
			    0,  105,  101,  106,  107,  100,  107,    0,  104,   99,
			  106,  108,  106,    0,    0,    0,  103,  109,  108,    0,
			  108,  102,  106,  110,  109,    0,  109,  111,  107,  101,
			  110,    0,  110,    0,  111,  104,  111,  112,    0,  110,
			  108,    0,    0,  103,  112,  113,  112,  109,  111,  106,
			  114,    0,  113,  112,  113,  107,  115,  114,  111,  114,
			    0,  111,    0,  115,  118,  115,  110,  108,  114,  113,
			  116,  118,    0,  118,  109,  111,    0,  116,    0,  116,
			  112,    0,  117,  119,    0,  111,  116,    0,  111,  117,

			  119,  117,  119,  120,  121,  114,  113,  122,  118,    0,
			  120,  121,  120,  121,  122,  123,  122,  119,    0,  124,
			    0,    0,  123,  116,  123,    0,  124,  116,  124,    0,
			  125,  122,    0,  126,  121,  118,    0,  125,  123,  125,
			  126,  117,  126,    0,  119,  120,  127,  128,    0,    0,
			  125,    0,  124,  127,  128,  127,  128,  130,  122,    0,
			  131,  121,  126,  129,  130,  123,  130,  131,    0,  131,
			  129,    0,  129,    0,    0,  132,    0,  125,  133,  124,
			  128,  134,  132,  129,  132,  133,    0,  133,  134,  126,
			  134,    0,    0,  135,  136,  131,    0,  137,    0,  132,

			  135,  136,  135,  136,  137,    0,  137,  128,  138,    0,
			  129,  133,  136,    0,  139,  138,  134,  138,  140,    0,
			    0,  139,  131,  139,  141,  140,  132,  140,  135,    0,
			    0,  141,  137,  141,    0,    0,    0,  142,  133,  136,
			  143,  145,    0,  134,  142,    0,  142,  143,  145,  143,
			  145,  147,    0,  141,  138,  135,  144,  146,  147,  137,
			  147,  142,    0,  144,  146,  144,  146,  148,    0,    0,
			  139,  145,  149,  143,  148,  150,  148,  146,    0,  149,
			  141,  149,  150,  151,  150,  144,  152,  153,  142,    0,
			  151,    0,  151,  152,  153,  152,  153,    0,  145,    0,

			  143,  155,  149,    0,  146,    0,  152,  154,  155,    0,
			  155,  156,  144,  151,  154,  157,  154,  153,  156,  158,
			  156,    0,  157,  154,  157,  159,  158,    0,  158,  149,
			    0,    0,  159,  152,  159,    0,  160,  155,    0,  161,
			  151,    0,  162,  160,  153,  160,  161,  163,  161,  162,
			  154,  162,  164,  156,  163,    0,  163,    0,  160,  164,
			    0,  164,  165,    0,  155,    0,  166,  163,  161,  165,
			  167,  165,  159,  166,    0,  166,    0,  167,    0,  167,
			  168,  165,    0,  169,  170,  160,    0,  168,  164,  168,
			  169,  170,  169,  170,  163,  161,    0,  166,    0,    0,

			    0,    0,  171,  167,    0,    0,    0,  168,  165,  171,
			    0,  171,    0,  173,  169,  164,  172,    0,    0,  170,
			  173,    0,  173,  172,  166,  172,    0,    0,    0,  174,
			  167,    0,    0,  175,  168,  171,  174,  172,  174,    0,
			  175,  169,  175,  176,  177,    0,  170,  178,  179,    0,
			  176,  177,  176,  177,  178,  179,  178,  179,  180,  173,
			    0,    0,  171,  181,  172,  180,  182,  180,  179,  183,
			  181,    0,  181,  182,    0,  182,  183,    0,  183,  177,
			  184,  176,  181,  185,    0,    0,  182,  184,    0,  184,
			  185,    0,  185,  183,  186,  179,    0,    0,    0,    0,

			  184,  186,    0,  186,    0,  187,  177,  185,  176,  181,
			  188,    0,  187,  182,  187,  189,  190,  188,    0,  188,
			  183,    0,  189,  190,  189,  190,  191,  184,  188,  187,
			  193,  192,    0,  191,  185,  191,    0,  193,  192,  193,
			  192,    0,    0,  194,  195,    0,    0,    0,  189,  192,
			  194,  195,  194,  195,    0,  188,  187,  196,    0,  191,
			  197,  198,    0,  194,  196,  199,  196,  197,  198,  197,
			  198,  200,  199,    0,  199,  189,  192,    0,  200,  195,
			  200,    0,  201,    0,    0,  202,  191,    0,    0,  201,
			  194,  201,  202,  196,  202,  197,  198,    0,  200,    0,

			    0,  203,  204,    0,    0,  201,  195,  199,  203,  204,
			  203,  204,  205,    0,    0,    0,    0,  206,  202,  205,
			  196,  205,  197,  198,  206,  200,  206,    0,  207,    0,
			    0,    0,  201,  205,    0,  207,  206,  207,    0,  208,
			  203,  204,  209,  210,    0,  202,  208,  211,  208,  209,
			  210,  209,  210,    0,  211,  212,  211,    0,  207,    0,
			  205,    0,  212,  206,  212,    0,  213,  203,  204,  214,
			  215,  211,  208,  213,  216,  213,  214,  215,  214,  215,
			    0,  216,    0,  216,  217,  207,    0,  218,  219,  214,
			  215,  217,    0,  217,  218,  219,  218,  219,  211,  208,

			    0,    0,  213,  220,    0,    0,  219,    0,    0,  216,
			  220,  221,  220,  217,  218,  222,  214,  215,  221,  223,
			  221,    0,  222,    0,  222,  224,  223,    0,  223,  213,
			  221,    0,  224,  219,  224,  225,  216,    0,  220,  226,
			  217,  218,  225,  227,  225,    0,  226,  228,  226,    0,
			  227,  222,  227,  229,  228,    0,  228,  221,    0,    0,
			  229,    0,  229,  227,  230,  220,    0,    0,  225,    0,
			    0,  230,  226,  230,    0,    0,  228,    0,  222,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  229,    0,
			  227,    0,    0,    0,    0,  225,    0,    0,    0,  226,

			    0,    0,    0,  228,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  229,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  133, 1416,   71,  129, 1416,  117,   68,
			 1416, 1416, 1416,  120, 1416,   71, 1416, 1416, 1416,  109,
			   72,   76,   82,   86,   92,   98,  109,  125,  128,  144,
			  136,  150,  164,  168,  169,  191,   98,  117,  110,   98,
			  199,  102,   94,  205,  209,  226,  227,  232,  253,  254,
			  266,  270,  269,  280,  285,  286,  299,  300,  313,  319,
			  329,  335,  303,  346,  350,  351,  356,  366,   99,   82,
			  383,  377,  387,  393,  404,  409,  410,  424,  428,  436,
			  442,  446,  450,  460,  472,  476,  480,  486,  496,  499,
			  507,  510,  515,  520,  526,   86,  532,  537,  538,  551,

			  555,  571,  565,  585,  588,  596,  607,  601,  615,  621,
			  627,  631,  641,  649,  654,  660,  674,  686,  668,  687,
			  697,  698,  701,  709,  713,  724,  727,  740,  741,  757,
			  751,  754,  769,  772,  775,  787,  788,  791,  802,  808,
			  812,  818,  831,  834,  850,  835,  851,  845,  861,  866,
			  869,  877,  880,  881,  901,  895,  905,  909,  913,  919,
			  930,  933,  936,  941,  946,  956,  960,  964,  974,  977,
			  978,  996, 1010, 1007, 1023, 1027, 1037, 1038, 1041, 1042,
			 1052, 1057, 1060, 1063, 1074, 1077, 1088, 1099, 1104, 1109,
			 1110, 1120, 1125, 1124, 1137, 1138, 1151, 1154, 1155, 1159,

			 1165, 1176, 1179, 1195, 1196, 1206, 1211, 1222, 1233, 1236,
			 1237, 1241, 1249, 1260, 1263, 1264, 1268, 1278, 1281, 1282,
			 1297, 1305, 1309, 1313, 1319, 1329, 1333, 1337, 1341, 1347,
			 1358, 1416,   77,  114,   73, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  231,    1,  231,  231,  231,  231,  231,  231,  232,
			  231,  231,  231,  233,  231,  232,  231,  231,  231,  234,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  231,  231,  231,  231,
			  232,  233,  231,  234,  234,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  231,  231,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  231,  232,  232,  232,  232,

			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,

			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,    0,  231,  231,  231, yy_Dummy>>)
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
			    0,    0,    0,   49,   47,    1,    2,   11,   47,    8,
			    4,    5,    7,   46,    6,   45,    3,    9,   10,   43,
			   45,   45,   15,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,    1,    2,    0,    0,
			   45,   46,    0,   44,   43,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   27,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,    0,    0,
			   45,   45,   45,   18,   45,   45,   45,   45,   45,   22,
			   45,   45,   45,   45,   29,   45,   45,   45,   45,   45,
			   45,   45,   42,   45,   45,    0,   45,   45,   45,   45,

			   45,   45,   45,   45,   45,   24,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   40,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   25,   45,   45,
			   30,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   12,   45,   45,   45,   45,   45,   45,   21,   23,   45,
			   28,   45,   45,   45,   45,   45,   37,   39,   36,   45,
			   45,   45,   19,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   13,   14,   45,   45,   20,   45,
			   31,   45,   45,   45,   45,   45,   41,   45,   45,   45,
			   32,   45,   45,   35,   45,   45,   45,   45,   45,   45,

			   45,   45,   45,   45,   45,   45,   45,   45,   45,   26,
			   33,   45,   38,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   16,   34,   45,   45,   45,   45,   45,
			   17,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1416
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 231
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 232
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

	yyNb_rules: INTEGER is 48
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 49
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
