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
--|#line 36 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 36")
end
current_position.go_to (text_count)
when 2 then
--|#line 37 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 37")
end
current_position.go_to (text_count)
when 3 then
--|#line 41 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 41")
end

				current_position.go_to (1)
				last_token := TE_COLON
			
when 4 then
--|#line 45 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 45")
end

				current_position.go_to (1)
				last_token := TE_LPARAN
			
when 5 then
--|#line 49 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 49")
end

				current_position.go_to (1)
				last_token := TE_RPARAN
			
when 6 then
--|#line 53 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 53")
end

				current_position.go_to (1)
				last_token := TE_COMMA
			
when 7 then
--|#line 57 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 57")
end

				current_position.go_to (1)
				last_token := TE_STAR
			
when 8 then
--|#line 61 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 61")
end

				current_position.go_to (1)
				last_token := TE_ADDRESS
			
when 9 then
--|#line 65 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 65")
end

				current_position.go_to (1)
				last_token := TE_LT
			
when 10 then
--|#line 69 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 69")
end

				current_position.go_to (1)
				last_token := TE_GT
			
when 11 then
--|#line 73 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 73")
end

				current_position.go_to (1)
				last_token := TE_DQUOTE
			
when 12 then
--|#line 79 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 79")
end

				current_position.go_to (6)
				last_token := TE_ACCESS
			
when 13 then
--|#line 83 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 83")
end

				current_position.go_to (8)
				last_token := TE_BLOCKING
			
when 14 then
--|#line 87 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 87")
end

				current_position.go_to (1)
				last_token := TE_C_LANGUAGE
			
when 15 then
--|#line 91 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 91")
end

				current_position.go_to (16)
				last_token := TE_C_LANGUAGE
			
when 16 then
--|#line 95 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 95")
end

				current_position.go_to (22)
				last_token := TE_C_LANGUAGE
			
when 17 then
--|#line 99 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 99")
end

				current_position.go_to (3)
				last_token := TE_CPP_LANGUAGE
			
when 18 then
--|#line 103 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 103")
end

				current_position.go_to (7)
				last_token := TE_CREATOR
			
when 19 then
--|#line 107 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 107")
end

				current_position.go_to (8)
				last_token := TE_DEFERRED
			
when 20 then
--|#line 111 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 111")
end

				current_position.go_to (6)
				last_token := TE_DELETE
			
when 21 then
--|#line 115 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 115")
end

				current_position.go_to (3)
				last_token := TE_DLL_LANGUAGE
			
when 22 then
--|#line 119 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 119")
end

				current_position.go_to (6)
				last_token := TE_DLLWIN_LANGUAGE
			
when 23 then
--|#line 123 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 123")
end

				current_position.go_to (4)
				last_token := TE_ENUM
			
when 24 then
--|#line 127 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 127")
end

				current_position.go_to (5)
				last_token := TE_FIELD
			
when 25 then
--|#line 131 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 131")
end

				current_position.go_to (12)
				last_token := TE_GET_PROPERTY
			
when 26 then
--|#line 135 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 135")
end

				current_position.go_to (2)
				last_token := TE_IL_LANGUAGE
			
when 27 then
--|#line 139 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 139")
end

				current_position.go_to (6)
				last_token := TE_INLINE
			
when 28 then
--|#line 143 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 143")
end

				current_position.go_to (3)
				last_token := TE_JAVA_LANGUAGE
			
when 29 then
--|#line 147 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 147")
end

				current_position.go_to (5)
				last_token := TE_MACRO
			
when 30 then
--|#line 151 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 151")
end

				current_position.go_to (8)
				last_token := TE_OPERATOR
			
when 31 then
--|#line 155 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 155")
end

				current_position.go_to (9)
				last_token := TE_SET_FIELD
			
when 32 then
--|#line 159 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 159")
end

				current_position.go_to (12)
				last_token := TE_SET_PROPERTY
			
when 33 then
--|#line 163 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 163")
end

				current_position.go_to (16)
				last_token := TE_SET_STATIC_FIELD
			
when 34 then
--|#line 167 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 167")
end

				current_position.go_to (9)
				last_token := TE_SIGNATURE
			
when 35 then
--|#line 171 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 171")
end

				current_position.go_to (8)
				last_token := TE_SIGNED
			
when 36 then
--|#line 175 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 175")
end

				current_position.go_to (6)
				last_token := TE_STATIC
			
when 37 then
--|#line 179 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 179")
end

				current_position.go_to (12)
				last_token := TE_STATIC_FIELD
			
when 38 then
--|#line 183 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 183")
end

				current_position.go_to (6)
				last_token := TE_STRUCT
			
when 39 then
--|#line 187 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 187")
end

				current_position.go_to (4)
				last_token := TE_TYPE
			
when 40 then
--|#line 191 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 191")
end

				current_position.go_to (8)
				last_token := TE_UNSIGNED
			
when 41 then
--|#line 195 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 195")
end

				current_position.go_to (3)
				last_token := TE_USE
			
when 42 then
--|#line 201 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 201")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				token_buffer.remove_head (1)
				last_token := TE_INTEGER
			
when 43 then
--|#line 209 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 209")
end

					-- To escape external keywords.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				token_buffer.remove_head (1)
				last_token := TE_ID
			
when 44 then
--|#line 218 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 218")
end

					-- Traditional identifier
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 45 then
--|#line 225 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 225")
end

					-- Special identifier for include files that specifies
					-- a path, e.g. <sys/timeb.h>
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_INCLUDE_ID
			
when 46 then
--|#line 234 "external.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'external.l' at line 234")
end

				current_position.go_to (1)
			
when 47 then
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

	yy_nxt_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    4,    5,    6,    5,    7,    4,    8,    9,   10,
			   11,    4,   12,    4,    4,   13,   14,   15,    4,   16,
			   17,   18,   19,   20,   21,   22,   23,   24,   13,   25,
			   26,   13,   13,   27,   13,   28,   13,   13,   13,   29,
			   30,   31,   13,   13,   13,    4,    4,   13,   18,   19,
			   20,   21,   22,   23,   24,   13,   25,   26,   13,   13,
			   27,   13,   28,   13,   13,   13,   32,   30,   33,   13,
			   13,   13,   34,   36,   34,   36,   36,   36,   36,   64,
			   36,   38,   36,   38,   38,   38,   38,   43,   38,   39,
			   38,   36,   36,   41,   36,   37,   37,   46,   36,   38,

			   38,   36,   38,   42,   47,   34,   38,   34,   48,   38,
			   50,   36,   64,   36,   44,   49,   39,   36,  113,   38,
			   41,   38,   91,   45,   46,   38,   54,   51,   37,   52,
			   42,   47,   59,   63,   53,   48,   56,   50,   36,   36,
			   57,   44,   49,   55,   36,   35,   38,   38,   40,   36,
			   35,   58,   38,   54,   51,  223,   52,   38,   56,   59,
			   36,   53,   57,   56,   36,   68,  223,   57,   38,   65,
			   55,   60,   38,   58,   39,   65,   39,   60,   58,  223,
			   39,   39,   39,   36,   40,   56,   36,   39,   36,   61,
			  223,   38,  223,   67,   38,  223,   38,   36,   60,   62,

			   58,  223,   69,   66,   60,   38,  223,  223,   39,   39,
			   36,   70,  223,   36,   39,   39,   36,   72,   38,   36,
			   67,   38,  223,   73,   38,   71,   36,   38,  223,   69,
			   66,   36,   36,  223,   38,   76,   74,   36,   70,   38,
			   38,   36,  223,   36,   72,   38,  223,   36,   75,   38,
			   73,   38,   71,   77,   80,   38,   36,   78,  223,   79,
			   81,   36,   76,   74,   38,   36,   36,  223,   83,   38,
			   36,   84,  223,   38,   38,   75,  223,   82,   38,  223,
			   77,   80,   36,  223,   78,   87,   79,   81,   85,   90,
			   38,   86,   36,  223,   64,   83,   64,   38,   84,   36,

			   38,   64,   36,   83,   82,   36,  223,   38,  223,  223,
			   38,   92,   87,   38,   36,   85,   93,   94,   86,   36,
			  223,  223,   38,   36,   36,   89,   36,   38,   64,   64,
			   88,   38,   38,   95,   38,  223,  223,   96,   92,   36,
			   36,   36,   97,   93,   94,   98,  223,   38,   38,   38,
			   36,  100,  223,   36,   36,   36,   99,  223,   38,   36,
			   95,   38,   38,   38,   96,  101,   36,   38,   36,   97,
			  223,   36,   98,  103,   38,  223,   38,  223,  100,   38,
			   36,  102,  223,   99,  223,  104,  105,  107,   38,   36,
			  110,   36,  101,  223,  223,   36,  106,   38,   36,   38,

			  103,  109,  108,   38,  223,  223,   38,   36,   36,  223,
			   36,  223,  104,  105,  107,   38,   38,  110,   38,  107,
			  115,  223,   36,  223,   36,   36,  223,   36,  109,  108,
			   38,  114,   38,   38,  117,   38,  223,   36,  223,  112,
			   36,  116,  223,   36,  118,   38,  111,  115,   38,   36,
			  121,   38,   36,  223,  119,  122,  223,   38,  114,  120,
			   38,  117,  223,  223,  126,   36,   36,  223,  116,  223,
			  123,  118,  125,   38,   38,   36,   36,  121,  223,   36,
			  124,  119,  122,   38,   38,  127,  120,   38,   36,  131,
			  130,  126,   36,  132,   36,  128,   38,  123,  129,  125,

			   38,   36,   38,  130,  223,   36,   36,  124,  223,   38,
			   36,   36,  127,   38,   38,  223,  131,  130,   38,   38,
			  132,   36,  128,   36,  136,  129,  223,  135,  138,   38,
			  130,   38,  139,   36,  133,  137,   36,   36,   36,   36,
			  134,   38,  141,  140,   38,   38,   38,   38,  223,  142,
			   36,  136,   36,   36,  135,  138,  144,   36,   38,  139,
			   38,   38,  137,   36,   36,   38,   36,  223,  143,  141,
			  140,   38,   38,  145,   38,  146,  142,   36,   36,  223,
			  150,   36,  147,  144,   36,   38,   38,  148,   36,   38,
			  223,  149,   38,   36,  223,  143,   38,   36,  151,  223,

			  145,   38,  146,  223,  223,   38,  223,  150,  223,  147,
			  223,  152,  154,  155,  148,   36,  156,  223,  149,   36,
			   36,   36,  157,   38,  223,  151,  223,   38,   38,   38,
			   36,  223,  153,   36,  158,  223,   36,  223,   38,  154,
			  155,   38,  223,  156,   38,   36,   36,   36,   36,  157,
			  159,  223,  161,   38,   38,   38,   38,  223,   36,  160,
			  163,  158,   36,   36,   36,  162,   38,   36,  223,  223,
			   38,   38,   38,  223,   36,   38,   36,  159,  223,  161,
			  223,  164,   38,  167,   38,  223,  160,  163,  165,   36,
			   36,   36,  162,  168,  170,   36,   36,   38,   38,   38,

			  223,  223,  169,   38,   38,   36,   36,  223,  164,  166,
			  167,  223,  223,   38,   38,   36,   36,  173,  223,  171,
			  168,  170,  172,   38,   38,  174,  177,   36,   36,  169,
			  175,   36,   36,   36,   36,   38,   38,  176,  223,   38,
			   38,   38,   38,  223,  173,  223,  171,   36,   36,  172,
			   36,  181,  174,  177,   36,   38,   38,  175,   38,   36,
			  178,  180,   38,   36,  176,  179,  182,   38,   36,  183,
			  184,   38,   36,  185,  223,   36,   38,  223,  181,   36,
			   38,   36,  186,   38,  223,  188,  187,   38,  180,   38,
			  223,   36,  179,  182,   36,   36,  183,  184,  191,   38,

			  185,  223,   38,   38,  189,  223,  223,   36,  223,  186,
			   36,  190,  188,  187,  192,   38,   36,  223,   38,   36,
			  223,   36,   36,  223,   38,  191,   36,   38,  193,   38,
			   38,  189,   36,  223,   38,   36,  223,   36,  190,  223,
			   38,  192,  194,   38,  195,   38,  223,  198,  199,  223,
			  196,   36,  223,   36,  200,  193,   36,  203,   36,   38,
			  197,   38,  223,  223,   38,  223,   38,  223,  223,  194,
			  201,  195,  223,  202,  198,  199,  204,  196,   36,   36,
			  205,  200,   36,   36,  203,  206,   38,   38,  223,  223,
			   38,   38,  223,   36,  223,  223,   36,  201,   36,  223,

			  202,   38,  207,  204,   38,   36,   38,  205,   36,  223,
			  223,   36,  206,   38,   36,  209,   38,  210,  208,   38,
			  223,  223,   38,   36,   36,  223,  223,  211,  214,  207,
			   36,   38,   38,  212,  213,   36,  223,  223,   38,   36,
			  223,  216,  209,   38,  210,  208,  223,   38,  215,   36,
			   36,  223,  223,  223,  211,  214,   36,   38,   38,  217,
			  212,  213,   36,  223,   38,   36,  223,  223,  216,  220,
			   38,  218,  223,   38,  223,  215,  223,  223,  223,  223,
			  223,  219,  223,  223,  221,  223,  217,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  220,  223,  218,  222,

			  223,  223,  223,  223,  223,  223,  223,  223,  219,  223,
			  223,  221,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  222,    3,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223>>)
		end

	yy_chk_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    8,    5,   13,   18,   19,   21,  226,
			   22,    8,   20,   13,   18,   19,   21,   20,   22,  225,
			   20,   24,   23,   18,   30,  224,  224,   21,   26,   24,

			   23,   25,   30,   19,   21,   34,   26,   34,   22,   25,
			   24,   27,  113,   28,   20,   23,   91,   29,   90,   27,
			   18,   28,   65,   20,   21,   29,   27,   25,   63,   25,
			   19,   21,   30,   36,   26,   22,   29,   24,   31,   32,
			   29,   20,   23,   28,   33,   35,   31,   32,   17,   37,
			    6,   29,   33,   27,   25,    3,   25,   37,   32,   30,
			   43,   26,   32,   29,   42,   43,    0,   29,   43,   39,
			   28,   31,   42,   32,   39,   40,   39,   33,   29,    0,
			   40,   39,   40,   44,   40,   32,   41,   40,   45,   32,
			    0,   44,    0,   42,   41,    0,   45,   46,   31,   33,

			   32,    0,   44,   41,   33,   46,    0,    0,   39,   39,
			   47,   45,    0,   48,   40,   40,   49,   46,   47,   50,
			   42,   48,    0,   46,   49,   45,   51,   50,    0,   44,
			   41,   52,   53,    0,   51,   49,   47,   54,   45,   52,
			   53,   55,    0,   56,   46,   54,    0,   57,   48,   55,
			   46,   56,   45,   50,   54,   57,   58,   52,    0,   53,
			   55,   59,   49,   47,   58,   62,   60,    0,   57,   59,
			   68,   58,    0,   62,   60,   48,    0,   56,   68,    0,
			   50,   54,   61,    0,   52,   60,   53,   55,   58,   64,
			   61,   59,   66,    0,   64,   57,   64,   64,   58,   67,

			   66,   64,   69,   61,   56,   70,    0,   67,    0,    0,
			   69,   66,   60,   70,   71,   58,   67,   69,   59,   74,
			    0,    0,   71,   72,   75,   62,   73,   74,   64,   64,
			   61,   72,   75,   70,   73,    0,    0,   71,   66,   76,
			   77,   79,   72,   67,   69,   73,    0,   76,   77,   79,
			   78,   75,    0,   80,   81,   82,   74,    0,   78,   83,
			   70,   80,   81,   82,   71,   76,   85,   83,   84,   72,
			    0,   86,   73,   78,   85,    0,   84,    0,   75,   86,
			   87,   77,    0,   74,    0,   80,   81,   83,   87,   89,
			   86,   88,   76,    0,    0,   93,   82,   89,   92,   88,

			   78,   85,   84,   93,    0,    0,   92,   94,   95,    0,
			   96,    0,   80,   81,   83,   94,   95,   86,   96,   88,
			   93,    0,   97,    0,  100,   98,    0,   99,   85,   84,
			   97,   92,  100,   98,   95,   99,    0,  101,    0,   89,
			  102,   94,    0,  104,   96,  101,   88,   93,  102,  105,
			   99,  104,  103,    0,   97,  101,    0,  105,   92,   98,
			  103,   95,    0,    0,  105,  106,  108,    0,   94,    0,
			  102,   96,  104,  106,  108,  107,  109,   99,    0,  110,
			  103,   97,  101,  107,  109,  106,   98,  110,  111,  108,
			  107,  105,  112,  109,  114,  106,  111,  102,  106,  104,

			  112,  115,  114,  111,    0,  117,  116,  103,    0,  115,
			  118,  119,  106,  117,  116,    0,  108,  107,  118,  119,
			  109,  121,  106,  120,  115,  106,    0,  114,  117,  121,
			  111,  120,  118,  122,  111,  116,  123,  124,  125,  126,
			  112,  122,  120,  119,  123,  124,  125,  126,    0,  121,
			  128,  115,  127,  129,  114,  117,  124,  130,  128,  118,
			  127,  129,  116,  131,  132,  130,  133,    0,  123,  120,
			  119,  131,  132,  126,  133,  127,  121,  134,  135,    0,
			  131,  137,  128,  124,  136,  134,  135,  129,  138,  137,
			    0,  130,  136,  139,    0,  123,  138,  141,  132,    0,

			  126,  139,  127,    0,    0,  141,    0,  131,    0,  128,
			    0,  133,  136,  137,  129,  140,  138,    0,  130,  142,
			  144,  143,  139,  140,    0,  132,    0,  142,  144,  143,
			  145,    0,  134,  146,  140,    0,  147,    0,  145,  136,
			  137,  146,    0,  138,  147,  148,  149,  150,  151,  139,
			  143,    0,  146,  148,  149,  150,  151,    0,  152,  145,
			  148,  140,  154,  153,  155,  147,  152,  157,    0,    0,
			  154,  153,  155,    0,  156,  157,  158,  143,    0,  146,
			    0,  149,  156,  154,  158,    0,  145,  148,  150,  159,
			  160,  161,  147,  156,  158,  162,  163,  159,  160,  161,

			    0,    0,  157,  162,  163,  164,  165,    0,  149,  153,
			  154,    0,    0,  164,  165,  166,  167,  161,    0,  159,
			  156,  158,  160,  166,  167,  162,  165,  169,  168,  157,
			  163,  170,  171,  172,  178,  169,  168,  164,    0,  170,
			  171,  172,  178,    0,  161,    0,  159,  175,  173,  160,
			  174,  171,  162,  165,  176,  175,  173,  163,  174,  177,
			  166,  169,  176,  179,  164,  168,  173,  177,  180,  174,
			  175,  179,  181,  176,    0,  182,  180,    0,  171,  183,
			  181,  184,  177,  182,    0,  180,  179,  183,  169,  184,
			    0,  185,  168,  173,  187,  186,  174,  175,  184,  185,

			  176,    0,  187,  186,  181,    0,    0,  188,    0,  177,
			  189,  183,  180,  179,  186,  188,  190,    0,  189,  191,
			    0,  192,  194,    0,  190,  184,  193,  191,  187,  192,
			  194,  181,  195,    0,  193,  196,    0,  197,  183,    0,
			  195,  186,  188,  196,  189,  197,    0,  192,  193,    0,
			  190,  199,    0,  200,  194,  187,  201,  197,  198,  199,
			  191,  200,    0,    0,  201,    0,  198,    0,    0,  188,
			  195,  189,    0,  196,  192,  193,  198,  190,  202,  203,
			  199,  194,  204,  205,  197,  200,  202,  203,    0,    0,
			  204,  205,    0,  208,    0,    0,  206,  195,  207,    0,

			  196,  208,  203,  198,  206,  209,  207,  199,  210,    0,
			    0,  211,  200,  209,  212,  206,  210,  207,  205,  211,
			    0,    0,  212,  213,  214,    0,    0,  208,  211,  203,
			  215,  213,  214,  209,  210,  216,    0,    0,  215,  217,
			    0,  213,  206,  216,  207,  205,    0,  217,  212,  218,
			  219,    0,    0,    0,  208,  211,  220,  218,  219,  214,
			  209,  210,  222,    0,  220,  221,    0,    0,  213,  219,
			  222,  217,    0,  221,    0,  212,    0,    0,    0,    0,
			    0,  218,    0,    0,  220,    0,  214,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  219,    0,  217,  221,

			    0,    0,    0,    0,    0,    0,    0,    0,  218,    0,
			    0,  220,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  221,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  155, 1027,   70,  147, 1027,   67, 1027,
			 1027, 1027, 1027,   69, 1027, 1027, 1027,  133,   70,   71,
			   76,   72,   74,   86,   85,   95,   92,  105,  107,  111,
			   88,  132,  133,  138,  103,  142,  121,  143,    0,  163,
			  169,  180,  158,  154,  177,  182,  191,  204,  207,  210,
			  213,  220,  225,  226,  231,  235,  237,  241,  250,  255,
			  260,  276,  259,  124,  283,  110,  286,  293,  264,  296,
			  299,  308,  317,  320,  313,  318,  333,  334,  344,  335,
			  347,  348,  349,  353,  362,  360,  365,  374,  385,  383,
			  106,  112,  392,  389,  401,  402,  404,  416,  419,  421,

			  418,  431,  434,  446,  437,  443,  459,  469,  460,  470,
			  473,  482,  486,  108,  488,  495,  500,  499,  504,  505,
			  517,  515,  527,  530,  531,  532,  533,  546,  544,  547,
			  551,  557,  558,  560,  571,  572,  578,  575,  582,  587,
			  609,  591,  613,  615,  614,  624,  627,  630,  639,  640,
			  641,  642,  652,  657,  656,  658,  668,  661,  670,  683,
			  684,  685,  689,  690,  699,  700,  709,  710,  722,  721,
			  725,  726,  727,  742,  744,  741,  748,  753,  728,  757,
			  762,  766,  769,  773,  775,  785,  789,  788,  801,  804,
			  810,  813,  815,  820,  816,  826,  829,  831,  852,  845,

			  847,  850,  872,  873,  876,  877,  890,  892,  887,  899,
			  902,  905,  908,  917,  918,  924,  929,  933,  943,  944,
			  950,  959,  956, 1027,   93,   86,   76>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  223,    1,  223,  223,  223,  223,  223,  224,  223,
			  223,  223,  223,  224,  223,  223,  223,  225,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  223,  223,  223,  224,  226,  225,
			  225,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  223,  226,  223,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  223,  223,  224,  224,  224,  224,  224,  224,  224,  224,

			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  223,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,

			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,    0,  223,  223,  223>>)
		end

	yy_ec_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    1,    5,    1,    1,    6,    7,    1,
			    8,    9,   10,   11,   12,    1,   13,   14,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   16,    1,
			   17,   18,   19,    1,   20,   21,   22,   23,   24,   25,
			   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   37,   44,
			   37,   45,    1,   46,    1,   47,    1,   48,   49,   50,

			   51,   52,   53,   54,   55,   56,   57,   58,   59,   60,
			   61,   62,   63,   64,   65,   66,   67,   68,   69,   70,
			   64,   71,   64,    1,    1,    1,    1,    1,    1,    1,
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
			    0,    1,    1,    1,    1,    1,    2,    3,    1,    1,
			    1,    2,    1,    2,    2,    3,    1,    1,    2,    1,
			    1,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    2,    2,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   48,   46,    1,    2,   11,    8,    4,
			    5,    7,    6,   44,    3,    9,   10,   42,   44,   44,
			   14,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,    1,    2,    0,   44,    0,   43,
			   42,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   26,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,    0,   45,    0,   44,   44,   17,   44,
			   44,   44,   44,   44,   21,   44,   44,   44,   44,   28,
			   44,   44,   44,   44,   44,   44,   44,   41,   44,   44,
			    0,    0,   44,   44,   44,   44,   44,   44,   44,   44,

			   23,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   39,   44,   44,    0,   44,   44,   44,   44,   44,   44,
			   44,   44,   24,   44,   44,   29,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   12,   44,   44,   44,   44,
			   44,   20,   22,   44,   27,   44,   44,   44,   44,   44,
			   36,   38,   35,   44,   44,   18,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   13,   44,   44,
			   19,   44,   30,   44,   44,   44,   44,   44,   40,   44,
			   44,   44,   31,   44,   44,   34,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   44,

			   44,   25,   32,   44,   37,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   15,   33,   44,   44,   44,
			   44,   44,   16,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1027
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 223
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 224
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

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Initialization

	make is
			-- Create a new external scanner.
		do
			make_with_buffer (Empty_buffer)
			!! token_buffer.make (Initial_buffer_size)
			!! current_position.reset
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			token_buffer.clear_all
			current_position.reset
		end

feature -- Access

	token_buffer: STRING
			-- Buffer for lexial tokens

	current_position: TOKEN_LOCATION
			-- Position of last token read
	
	last_value: ANY
			-- Semantic value to be passed to the parser

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER is 1024 
				-- Initial size for `token_buffer'

invariant
	token_buffer_not_void: token_buffer /= Void
	current_position_not_void: current_position /= Void

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
