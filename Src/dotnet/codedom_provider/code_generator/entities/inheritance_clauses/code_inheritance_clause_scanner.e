indexing
	description: "Scanners for snippet inheritance clauses"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_INHERITANCE_CLAUSE_SCANNER

inherit
	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			reset
		end

	CODE_INHERITANCE_CLAUSE_TOKENS
		export
			{NONE} all
		end

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
if yy_act <= 24 then
if yy_act <= 12 then
if yy_act <= 6 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 35 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 35")
end
current_position.go_to (text_count)
else
--|#line 36 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 36")
end
current_position.go_to (text_count)
end
else
--|#line 40 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 40")
end

				current_position.go_to (1)
				last_token := TE_COMMA
			
end
else
if yy_act <= 5 then
if yy_act = 4 then
--|#line 44 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 44")
end

				current_position.go_to (1)
				last_token := TE_SEMICOLON
			
else
--|#line 48 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 48")
end

				current_position.go_to (1)
				last_token := TE_LCURLY
			
end
else
--|#line 52 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 52")
end

				current_position.go_to (1)
				last_token := TE_RCURLY
			
end
end
else
if yy_act <= 9 then
if yy_act <= 8 then
if yy_act = 7 then
--|#line 56 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 56")
end

				current_position.go_to (1)
				last_token := TE_LSQURE
			
else
--|#line 60 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 60")
end

				current_position.go_to (1)
				last_token := TE_RSQURE
			
end
else
--|#line 64 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 64")
end

				current_position.go_to (1)
				last_token := TE_PLUS
			
end
else
if yy_act <= 11 then
if yy_act = 10 then
--|#line 68 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 68")
end

				current_position.go_to (1)
				last_token := TE_MINUS
			
else
--|#line 74 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 74")
end

				current_position.go_to (3)
				last_token := TE_ALL
			
end
else
--|#line 78 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 78")
end

				current_position.go_to (2)
				last_token := TE_AS
			
end
end
end
else
if yy_act <= 18 then
if yy_act <= 15 then
if yy_act <= 14 then
if yy_act = 13 then
--|#line 82 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 82")
end

				current_position.go_to (3)
				last_token := TE_BIT
			
else
--|#line 86 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 86")
end

				current_position.go_to (7)
				last_token := TE_CURRENT
			
end
else
--|#line 90 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 90")
end

				current_position.go_to (3)
				last_token := TE_END
			
end
else
if yy_act <= 17 then
if yy_act = 16 then
--|#line 94 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 94")
end

				current_position.go_to (6)
				last_token := TE_EXPORT
			
else
--|#line 98 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 98")
end

				current_position.go_to (5)
				last_token := TE_INFIX
			
end
else
--|#line 102 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 102")
end

				current_position.go_to (7)
				last_token := TE_INHERIT
			
end
end
else
if yy_act <= 21 then
if yy_act <= 20 then
if yy_act = 19 then
--|#line 106 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 106")
end

				current_position.go_to (4)
				last_token := TE_LIKE
			
else
--|#line 110 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 110")
end

				current_position.go_to (6)
				last_token := TE_PREFIX
			
end
else
--|#line 114 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 114")
end

				current_position.go_to (8)
				last_token := TE_REDEFINE
			
end
else
if yy_act <= 23 then
if yy_act = 22 then
--|#line 118 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 118")
end

				current_position.go_to (6)
				last_token := TE_RENAME
			
else
--|#line 122 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 122")
end

				current_position.go_to (6)
				last_token := TE_SELECT
			
end
else
--|#line 126 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 126")
end

				current_position.go_to (8)
				last_token := TE_SEPARATE
			
end
end
end
end
else
if yy_act <= 36 then
if yy_act <= 30 then
if yy_act <= 27 then
if yy_act <= 26 then
if yy_act = 25 then
--|#line 130 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 130")
end

				current_position.go_to (8)
				last_token := TE_UNDEFINE
			
else
--|#line 137 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 137")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
end
else
--|#line 147 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 147")
end

				current_position.go_to (3)
				last_token := TE_STR_LT
			
end
else
if yy_act <= 29 then
if yy_act = 28 then
--|#line 151 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 151")
end

				current_position.go_to (3)
				last_token := TE_STR_GT
			
else
--|#line 155 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 155")
end

				current_position.go_to (4)
				last_token := TE_STR_LE
			
end
else
--|#line 159 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 159")
end

				current_position.go_to (4)
				last_token := TE_STR_GE
			
end
end
else
if yy_act <= 33 then
if yy_act <= 32 then
if yy_act = 31 then
--|#line 163 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 163")
end

				current_position.go_to (3)
				last_token := TE_STR_PLUS
			
else
--|#line 167 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 167")
end

				current_position.go_to (3)
				last_token := TE_STR_MINUS
			
end
else
--|#line 171 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 171")
end

				current_position.go_to (3)
				last_token := TE_STR_STAR
			
end
else
if yy_act <= 35 then
if yy_act = 34 then
--|#line 175 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 175")
end

				current_position.go_to (3)
				last_token := TE_STR_SLASH
			
else
--|#line 179 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 179")
end

				current_position.go_to (3)
				last_token := TE_STR_POWER
			
end
else
--|#line 183 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 183")
end

				current_position.go_to (4)
				last_token := TE_STR_DIV
			
end
end
end
else
if yy_act <= 42 then
if yy_act <= 39 then
if yy_act <= 38 then
if yy_act = 37 then
--|#line 187 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 187")
end

				current_position.go_to (4)
				last_token := TE_STR_MOD
			
else
--|#line 191 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 191")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_AND
			
end
else
--|#line 197 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 197")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				current_position.go_to (10)
				last_token := TE_STR_AND_THEN
			
end
else
if yy_act <= 41 then
if yy_act = 40 then
--|#line 203 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 203")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_IMPLIES
			
else
--|#line 209 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 209")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_NOT
			
end
else
--|#line 215 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 215")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				current_position.go_to (4)
				last_token := TE_STR_OR
			
end
end
else
if yy_act <= 45 then
if yy_act <= 44 then
if yy_act = 43 then
--|#line 221 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 221")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_OR_ELSE
			
else
--|#line 227 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 227")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_XOR
			
end
else
--|#line 233 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 233")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STR_FREE
			
end
else
if yy_act = 46 then
--|#line 240 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 240")
end

				current_position.go_to (1)
			
else
--|#line 0 "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
end
end
end
end
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
			    0,    4,    5,    6,    5,    4,    7,    4,    4,    4,
			    8,    9,   10,    4,    4,   11,    4,    4,    4,    4,
			   12,   13,   14,   15,   16,   15,   15,   15,   17,   15,
			   18,   15,   15,   15,   19,   20,   21,   15,   22,   15,
			   23,    4,   24,    4,    4,   12,   13,   14,   15,   16,
			   15,   15,   15,   17,   15,   18,   15,   15,   15,   19,
			   20,   21,   15,   22,   15,   25,    4,   26,   27,   44,
			   27,   29,   29,   30,   31,   45,   32,   33,  153,   46,
			   34,   47,   35,   29,   36,   50,   48,   51,   52,   53,
			   54,   55,   37,   49,   44,   60,   38,   39,   66,   27,

			   45,   27,   61,   40,   46,   41,   47,   42,   62,   36,
			   50,   48,   51,   52,   53,   54,   55,   37,   49,   63,
			   64,   38,   39,   66,   67,   68,   69,   70,   40,   73,
			   29,   65,   74,   75,   76,   77,   78,   80,   79,   81,
			   86,   84,   90,   91,   82,   85,   92,  152,   95,   67,
			   68,   69,   70,   83,   73,   97,   98,   74,   75,   76,
			   77,   78,   80,   79,   81,   86,   84,   90,   91,   82,
			   85,   92,   93,   95,   94,   99,  100,  101,   83,  102,
			   97,   98,  103,  104,  105,  106,  107,  108,  110,  109,
			  112,  114,  115,  116,  117,  118,  119,  120,  121,  122,

			   99,  100,  101,  123,  102,  124,  125,  103,  104,  105,
			  106,  107,  126,  110,  127,  112,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  128,  129,  130,  123,  131,
			  124,  125,  132,  133,  134,  135,  136,  126,  137,  127,
			  138,  139,  140,  141,  142,  143,  144,  145,  146,  147,
			  128,  129,  130,  148,  131,  149,  150,  132,  133,  134,
			  135,  136,  151,  137,  113,  138,  139,  140,  141,  142,
			  143,  144,  145,  146,  147,  111,   96,   89,  148,   88,
			  149,  150,   43,   43,   43,   43,   43,   43,   43,   43,
			   29,   29,   29,   29,   29,   29,   29,   29,   29,   87,

			   72,   71,   59,   58,   57,   56,   28,   28,  154,    3,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154>>)
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
			    1,    1,    1,    1,    1,    1,    1,    1,    5,   12,
			    5,    7,    7,    7,    7,   12,    7,    7,  150,   13,
			    7,   14,    7,    7,    7,   17,   16,   18,   19,   20,
			   21,   22,    7,   16,   12,   33,    7,    7,   36,   27,

			   12,   27,   33,    7,   13,    7,   14,    7,   34,    7,
			   17,   16,   18,   19,   20,   21,   22,    7,   16,   34,
			   35,    7,    7,   36,   37,   38,   39,   40,    7,   44,
			    7,   35,   46,   47,   48,   49,   50,   51,   50,   52,
			   55,   54,   66,   67,   53,   54,   68,  146,   70,   37,
			   38,   39,   40,   53,   44,   75,   77,   46,   47,   48,
			   49,   50,   51,   50,   52,   55,   54,   66,   67,   53,
			   54,   68,   69,   70,   69,   78,   79,   80,   53,   81,
			   75,   77,   82,   83,   84,   85,   86,   90,   91,   90,
			   93,   97,   98,   99,  100,  102,  103,  104,  105,  106,

			   78,   79,   80,  107,   81,  108,  110,   82,   83,   84,
			   85,   86,  112,   91,  114,   93,   97,   98,   99,  100,
			  102,  103,  104,  105,  106,  115,  117,  118,  107,  119,
			  108,  110,  120,  121,  122,  123,  124,  112,  125,  114,
			  126,  127,  129,  131,  134,  135,  136,  137,  138,  141,
			  115,  117,  118,  142,  119,  143,  144,  120,  121,  122,
			  123,  124,  145,  125,   95,  126,  127,  129,  131,  134,
			  135,  136,  137,  138,  141,   92,   71,   65,  142,   63,
			  143,  144,  155,  155,  155,  155,  155,  155,  155,  155,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,   61,

			   42,   41,   32,   31,   30,   29,   28,    6,    3,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  308,  309,   66,  304,   64,  309,  309,
			  309,  309,   39,   51,   43,    0,   54,   53,   59,   53,
			   65,   66,   59,  309,  309,  309,  309,   97,  303,  299,
			  298,  297,  296,   89,  102,  114,   66,   93,   92,   91,
			   94,  260,  294,    0,   99,    0,   95,   98,  111,  101,
			  111,  108,  115,  121,  111,  117,  309,  309,  309,  309,
			  309,  293,  309,  273,  309,  271,  119,  109,  109,  168,
			  113,  270,  309,    0,    0,  120,    0,  123,  147,  152,
			  153,  154,  158,  163,  160,  165,  162,  309,  309,  309,
			  183,  158,  269,  166,  309,  258,  309,  167,  157,  154,

			  159,    0,  167,  171,  166,  176,  164,  178,  168,  309,
			  178,  309,  182,  309,  182,  188,    0,  198,  188,  201,
			  208,  196,  214,  207,  209,  214,  204,  204,    0,  205,
			    0,  211,    0,    0,  207,  213,  222,  211,  224,    0,
			    0,  225,  229,  231,  224,  256,  141,    0,    0,    0,
			   72,  309,  309,  309,  309,  279,  288>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  154,    1,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  155,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  154,  154,  154,  154,  154,  154,  156,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  155,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  155,  155,  155,

			  155,  155,  155,  155,  155,  155,  155,  155,  154,  154,
			  154,  154,  154,  154,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  154,  154,  154,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  154,  154,  154,  155,
			  155,  155,  155,  155,  154,  154,  154,  155,  155,  155,
			  154,  154,  154,  154,    0,  154,  154>>)
		end

	yy_ec_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    5,    6,    7,    5,    1,    8,    5,
			    5,    5,    9,   10,   11,   12,    5,   13,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,    5,   15,
			   16,   17,   18,    5,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   26,   29,   30,   31,   32,   33,
			   34,   26,   35,   36,   37,   38,   26,   26,   39,   26,
			   26,   40,   41,   42,   43,   44,    5,   45,   46,   47,

			   48,   49,   50,   51,   52,   53,   51,   54,   55,   56,
			   57,   58,   59,   51,   60,   61,   62,   63,   51,   51,
			   64,   51,   51,   65,   66,   67,    5,    1,    1,    1,
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
			    0,    1,    1,    1,    1,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    3,    2,    2,    2,    2,    2,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    4,    5,    6,    7,
			    2,    2,    2,    2,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    8,    9,   10,    3,    2,    2,    2>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   48,   46,    1,    2,   46,    9,    3,
			   10,    4,   26,   26,   26,   26,   26,   26,   26,   26,
			   26,   26,   26,    7,    8,    5,    6,    1,    2,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   26,   26,   12,   26,   26,   26,   26,
			   26,   26,   26,   26,   26,   26,   45,   33,   31,   32,
			   34,    0,   27,    0,   28,    0,    0,    0,    0,    0,
			    0,    0,   35,   11,   13,   26,   15,   26,   26,   26,
			   26,   26,   26,   26,   26,   26,   26,   36,   29,   30,
			    0,    0,    0,    0,   42,    0,   37,   26,   26,   26,

			   26,   19,   26,   26,   26,   26,   26,   26,    0,   38,
			    0,   41,    0,   44,   26,   26,   17,   26,   26,   26,
			   26,   26,   26,   26,    0,    0,    0,   26,   16,   26,
			   20,   26,   22,   23,   26,   26,    0,    0,    0,   14,
			   18,   26,   26,   26,    0,    0,    0,   21,   24,   25,
			    0,   40,   43,   39,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 309
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 154
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 155
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

end -- class CODE_INHERITANCE_CLAUSE_SCANNER


--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------