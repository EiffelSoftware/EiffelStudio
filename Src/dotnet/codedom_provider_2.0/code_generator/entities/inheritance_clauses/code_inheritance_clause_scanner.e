note
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

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (sc = INITIAL)
		end

feature {NONE} -- Implementation

	yy_build_tables
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

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

when 2 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

when 3 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_COMMA
			
when 4 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_SEMICOLON
			
when 5 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_LCURLY
			
when 6 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_RCURLY
			
when 7 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_LSQURE
			
when 8 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_RSQURE
			
when 9 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_PLUS
			
when 10 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_MINUS
			
when 11 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_ALL
			
when 12 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_AS
			
when 13 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_BIT
			
when 14 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_CURRENT
			
when 15 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_END
			
when 16 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_EXPORT
			
when 17 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_INFIX
			
when 18 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_INHERIT
			
when 19 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_LIKE
			
when 20 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_PREFIX
			
when 21 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_REDEFINE
			
when 22 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_RENAME
			
when 23 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_SELECT
			
when 24 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_SEPARATE
			
when 25 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_UNDEFINE
			
when 26 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_ID
			
when 27 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_LT
			
when 28 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_GT
			
when 29 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_LE
			
when 30 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_GE
			
when 31 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_PLUS
			
when 32 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_MINUS
			
when 33 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_STAR
			
when 34 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_SLASH
			
when 35 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_POWER
			
when 36 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_DIV
			
when 37 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				last_token := TE_STR_MOD
			
when 38 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_AND
			
when 39 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				last_token := TE_STR_AND_THEN
			
when 40 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_IMPLIES
			
when 41 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_NOT
			
when 42 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				last_token := TE_STR_OR
			
when 43 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_OR_ELSE
			
when 44 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_XOR
			
when 45 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STR_FREE
			
when 46 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end

			
when 47 then
--|#line <not available> "inheritance_clause.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'inheritance_clause.l' at line <not available>")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			terminate
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 362)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			an_array.area.fill_with (154, 296, 362)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,    5,    6,    5,    4,    7,    4,    4,    4,    8,
			    9,   10,    4,    4,   11,    4,    4,    4,    4,   12,
			   13,   14,   15,   16,   15,   15,   15,   17,   15,   18,
			   15,   15,   15,   19,   20,   21,   15,   22,   15,   23,
			    4,   24,    4,    4,   12,   13,   14,   15,   16,   15,
			   15,   15,   17,   15,   18,   15,   15,   15,   19,   20,
			   21,   15,   22,   15,   25,    4,   26,    4,   27,   44,
			   27,   29,   29,   30,   31,   45,   32,   33,   43,   46,
			   34,   47,   35,   29,   36,   50,   48,   51,   52,   53,
			   54,   55,   37,   49,   44,   60,   38,   39,   66,   27,

			   45,   27,   61,   40,   46,   41,   47,   42,   62,   36,
			   50,   48,   51,   52,   53,   54,   55,   37,   49,   63,
			   64,   38,   39,   66,   67,   68,   69,   70,   40,   73,
			   29,   65,   74,   75,   76,   77,   78,   80,   79,   81,
			   86,   84,   90,   91,   82,   85,   92,  153,   95,   67,
			   68,   69,   70,   83,   73,   97,   98,   74,   75,   76,
			   77,   78,   80,   79,   81,   86,   84,   90,   91,   82,
			   85,   92,   93,   95,   94,   99,  100,  101,   83,  102,
			   97,   98,  103,  104,  105,  106,  107,  108,  110,  109,
			  112,  114,  115,  116,  117,  118,  119,  120,  121,  122, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   99,  100,  101,  123,  102,  124,  125,  103,  104,  105,
			  106,  107,  126,  110,  127,  112,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  128,  129,  130,  123,  131,
			  124,  125,  132,  133,  134,  135,  136,  126,  137,  127,
			  138,  139,  140,  141,  142,  143,  144,  145,  146,  147,
			  128,  129,  130,  148,  131,  149,  150,  132,  133,  134,
			  135,  136,  152,  137,  151,  138,  139,  140,  141,  142,
			  143,  144,  145,  146,  147,   29,   29,  113,  148,  111,
			  149,  150,   96,   89,   88,   87,   72,   71,   59,   58,
			   57,   56,   28,   28,  154,    3, yy_Dummy>>,
			1, 96, 200)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 362)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 67)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			an_array.area.fill_with (154, 295, 362)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    5,   12,    5,    7,    7,    7,    7,   12,    7,    7,
			  155,   13,    7,   14,    7,    7,    7,   17,   16,   18,
			   19,   20,   21,   22,    7,   16,   12,   33,    7,    7,
			   36,   27,   12,   27,   33,    7,   13,    7,   14,    7,
			   34,    7,   17,   16,   18,   19,   20,   21,   22,    7,
			   16,   34,   35,    7,    7,   36,   37,   38,   39,   40,
			    7,   44,    7,   35,   46,   47,   48,   49,   50,   51,
			   50,   52,   55,   54,   66,   67,   53,   54,   68,  150,
			   70,   37,   38,   39,   40,   53,   44,   75,   77,   46,
			   47,   48,   49,   50,   51,   50,   52,   55,   54,   66,

			   67,   53,   54,   68,   69,   70,   69,   78,   79,   80,
			   53,   81,   75,   77,   82,   83,   84,   85,   86,   90,
			   91,   90,   93,   97,   98,   99,  100,  102,  103,  104,
			  105,  106,   78,   79,   80,  107,   81,  108,  110,   82,
			   83,   84,   85,   86,  112,   91,  114,   93,   97,   98,
			   99,  100,  102,  103,  104,  105,  106,  115,  117,  118,
			  107,  119,  108,  110,  120,  121,  122,  123,  124,  112,
			  125,  114,  126,  127,  129,  131,  134,  135,  136,  137,
			  138,  141,  115,  117,  118,  142,  119,  143,  144,  120,
			  121,  122,  123,  124,  146,  125,  145,  126,  127,  129, yy_Dummy>>,
			1, 200, 68)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  131,  134,  135,  136,  137,  138,  141,  156,  156,   95,
			  142,   92,  143,  144,   71,   65,   63,   61,   42,   41,
			   32,   31,   30,   29,   28,    6,    3, yy_Dummy>>,
			1, 27, 268)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  294,  295,   67,  291,   65,  295,  295,
			  295,  295,   40,   52,   44,    0,   55,   54,   60,   54,
			   66,   67,   60,  295,  295,  295,  295,   98,  290,  286,
			  285,  284,  283,   90,  103,  115,   67,   94,   93,   92,
			   95,  247,  281,    0,  100,    0,   96,   99,  112,  102,
			  112,  109,  116,  122,  112,  118,  295,  295,  295,  295,
			  295,  280,  295,  279,  295,  278,  120,  110,  110,  169,
			  114,  277,  295,    0,    0,  121,    0,  124,  148,  153,
			  154,  155,  159,  164,  161,  166,  163,  295,  295,  295,
			  184,  159,  274,  167,  295,  272,  295,  168,  158,  155,

			  160,    0,  168,  172,  167,  177,  165,  179,  169,  295,
			  179,  295,  183,  295,  183,  189,    0,  199,  189,  202,
			  209,  197,  215,  208,  210,  215,  205,  205,    0,  206,
			    0,  212,    0,    0,  208,  214,  223,  212,  225,    0,
			    0,  226,  230,  232,  225,  259,  257,    0,    0,    0,
			  142,  295,  295,  295,  295,   76,  274, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
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
			  154,  154,  154,  154,    0,  154,  154, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 257)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (67, 127, 257)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,   67,   67,   67,   67,   67,   67,   67,   67,    1,
			    2,   67,   67,    1,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,    3,    4,    5,    6,    4,   67,    7,    4,
			    4,    4,    8,    9,   10,   11,    4,   12,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,    4,   14,
			   15,   16,   17,    4,   18,   19,   20,   21,   22,   23,
			   24,   25,   26,   27,   25,   28,   29,   30,   31,   32,
			   33,   25,   34,   35,   36,   37,   25,   25,   38,   25,
			   25,   39,   40,   41,   42,   43,    4,   44,   45,   46,

			   47,   48,   49,   50,   51,   52,   50,   53,   54,   55,
			   56,   57,   58,   50,   59,   60,   61,   62,   50,   50,
			   63,   50,   50,   64,   65,   66,    4, yy_Dummy>>,
			1, 127, 0)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    3,    3,    3,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    1,    1,    1,    1,    1,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    1,
			    1,    1,    1,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    1,    1,    1,    3, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
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
			    0,   40,   43,   39,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 295
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 154
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 155
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 67
			-- Equivalence code for NULL character

	yyMax_symbol_equiv_class: INTEGER = 256
			-- All symbols greater than this symbol will have
			-- the same equivalence class as this symbol

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = false
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = false
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 47
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 48
			-- End of buffer rule code

	yyLine_used: BOOLEAN = false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Initialization

	make
			-- Create a new external scanner.
		do
			make_with_buffer (Empty_buffer)
			create token_buffer.make (Initial_buffer_size)
		end

feature -- Initialization

	reset
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

	Initial_buffer_size: INTEGER = 1024 
				-- Initial size for `token_buffer'

invariant
	token_buffer_not_void: token_buffer /= Void

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
