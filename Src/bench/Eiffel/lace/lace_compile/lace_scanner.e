indexing

	description: "Scanners for Lace parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LACE_SCANNER

inherit

	LACE_SCANNER_SKELETON

creation

	make


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= IN_STR)
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
--|#line 32
current_position.go_to (text_count)
when 2 then
--|#line 37
current_position.go_to (text_count)
when 3 then
--|#line 38

				line_number := line_number + text_count
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 4 then
--|#line 47

				current_position.go_to (1)
				last_token := LAC_SEMICOLON
			
when 5 then
--|#line 51

				current_position.go_to (1)
				last_token := LAC_COLON
			
when 6 then
--|#line 55

				current_position.go_to (1)
				last_token := LAC_COMMA
			
when 7 then
--|#line 59

				current_position.go_to (1)
				last_token := LAC_LEFT_PARAM
			
when 8 then
--|#line 63

				current_position.go_to (1)
				last_token := LAC_RIGHT_PARAM
			
when 9 then
--|#line 71

				current_position.go_to (5)
				last_token := LAC_ADAPT
			
when 10 then
--|#line 75

				current_position.go_to (3)
				last_token := LAC_ALL
			
when 11 then
--|#line 79

				current_position.go_to (2)
				last_token := LAC_AS
			
when 12 then
--|#line 83

				current_position.go_to (9)
				last_token := LAC_ASSERTION
			
when 13 then
--|#line 87

				current_position.go_to (1)
				last_token := LAC_C
			
when 14 then
--|#line 91

				current_position.go_to (5)
				last_token := LAC_CHECK
			
when 15 then
--|#line 95

				current_position.go_to (7)
				last_token := LAC_CLUSTER
			
when 16 then
--|#line 99

				current_position.go_to (8)
				last_token := LAC_CREATION
			
when 17 then
--|#line 103

				current_position.go_to (5)
				last_token := LAC_DEBUG
			
when 18 then
--|#line 107

				current_position.go_to (7)
				last_token := LAC_DEFAULT
			
when 19 then
--|#line 111

				current_position.go_to (3)
				last_token := LAC_END
			
when 20 then
--|#line 115

				current_position.go_to (6)
				last_token := LAC_ENSURE
			
when 21 then
--|#line 119

				current_position.go_to (7)
				last_token := LAC_EXCLUDE
			
when 22 then
--|#line 123

				current_position.go_to (10)
				last_token := LAC_EXECUTABLE
			
when 23 then
--|#line 127

				current_position.go_to (6)
				last_token := LAC_EXPORT
			
when 24 then
--|#line 131

				current_position.go_to (8)
				last_token := LAC_EXTERNAL
			
when 25 then
--|#line 135

				current_position.go_to (8)
				last_token := LAC_GENERATE
			
when 26 then
--|#line 139

				current_position.go_to (6)
				last_token := LAC_IGNORE
			
when 27 then
--|#line 143

				current_position.go_to (7)
				last_token := LAC_INCLUDE
			
when 28 then
--|#line 147

				current_position.go_to (12)
				last_token := LAC_INCLUDE_PATH
			
when 29 then
--|#line 151

				current_position.go_to (9)
				last_token := LAC_INVARIANT
			
when 30 then
--|#line 155

				current_position.go_to (4)
				last_token := LAC_LOOP
			
when 31 then
--|#line 159

				current_position.go_to (4)
				last_token := LAC_MAKE
			
when 32 then
--|#line 163

				current_position.go_to (2)
				last_token := LAC_NO
			
when 33 then
--|#line 167

				current_position.go_to (6)
				last_token := LAC_OBJECT
			
when 34 then
--|#line 171

				current_position.go_to (8)
				last_token := LAC_OPTIMIZE
			
when 35 then
--|#line 175

				current_position.go_to (6)
				last_token := LAC_OPTION
			
when 36 then
--|#line 179

				current_position.go_to (11)
				last_token := LAC_PRECOMPILED
			
when 37 then
--|#line 183

				current_position.go_to (6)
				last_token := LAC_RENAME
			
when 38 then
--|#line 187

				current_position.go_to (7)
				last_token := LAC_REQUIRE
			
when 39 then
--|#line 191

				current_position.go_to (4)
				last_token := LAC_ROOT
			
when 40 then
--|#line 195

				current_position.go_to (6)
				last_token := LAC_SYSTEM
			
when 41 then
--|#line 199

				current_position.go_to (5)
				last_token := LAC_TRACE
			
when 42 then
--|#line 203

				current_position.go_to (3)
				last_token := LAC_USE
			
when 43 then
--|#line 207

				current_position.go_to (7)
				last_token := LAC_VISIBLE
			
when 44 then
--|#line 211

				current_position.go_to (3)
				last_token := LAC_YES
			
when 45 then
--|#line 219

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := LAC_IDENTIFIER
			
when 46 then
--|#line 231

					-- Empty string.
				current_position.go_to (2)
				report_string_empty_error
				last_token := LAC_STRING
			
when 47 then
--|#line 237

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := LAC_STRING
			
when 48 then
--|#line 243

				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (IN_STR)
			
when 49 then
--|#line 252

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			
when 50 then
--|#line 256

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 51 then
--|#line 260

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 52 then
--|#line 264

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 53 then
--|#line 268

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 54 then
--|#line 272

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 55 then
--|#line 276

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 56 then
--|#line 280

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 57 then
--|#line 284

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 58 then
--|#line 288

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 59 then
--|#line 292

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 60 then
--|#line 296

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 61 then
--|#line 300

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 62 then
--|#line 304

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 63 then
--|#line 308

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 64 then
--|#line 312

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 65 then
--|#line 316

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 66 then
--|#line 320

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 67 then
--|#line 324

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 68 then
--|#line 328

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 69 then
--|#line 332

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 70 then
--|#line 336

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 71 then
--|#line 340

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 72 then
--|#line 344

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 73 then
--|#line 351

				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (INITIAL)
				if token_buffer.empty then
					report_string_empty_error
				end
				last_token := LAC_STRING
			
when 74 then
--|#line 362

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 75 then
--|#line 368

					-- No final double-quote.
				line_number := line_number + 1
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 76 then
--|#line 389

				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			
when 77 then
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
when 0 then
--|#line 0

				terminate
			
when 1 then
--|#line 0

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
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
			    0,    6,    7,    8,    9,    6,    6,   10,   11,   12,
			   13,    6,    6,   14,   15,    6,    6,   16,   17,   18,
			   19,   20,   17,   21,   17,   22,   17,   17,   23,   24,
			   25,   26,   27,   17,   28,   29,   30,   31,   32,   17,
			   17,   33,   17,    6,   16,   17,   18,   19,   20,   17,
			   21,   17,   22,   17,   17,   23,   24,   25,   26,   27,
			   17,   28,   29,   30,   31,   32,   17,   17,   33,   17,
			   35,   36,   37,   35,   36,   37,   44,   47,   50,   51,
			   53,   48,   56,   54,   45,   57,   58,   49,   59,   52,
			   55,   46,   61,   43,   64,   65,   66,   67,   68,   95,

			   96,   97,   60,   44,   47,   50,   51,   53,   48,   56,
			   54,   45,   57,   58,   49,   59,   52,   55,   46,   61,
			   62,   64,   65,   66,   67,   68,   95,   96,   97,   60,
			   63,   71,   71,  223,  126,  155,  156,   40,   98,   99,
			   40,  100,  109,  155,  182,   69,  155,   62,   69,  127,
			  101,   70,  110,   94,  102,  103,   39,   63,   71,   71,
			   72,   73,   74,   75,   76,   98,   99,   77,  100,  109,
			  104,   78,   79,   80,   81,   82,   83,  101,   84,  110,
			   85,  102,  103,  105,   86,  106,   87,  111,  113,   88,
			   89,   90,   91,   92,   93,  114,  107,  104,  115,  116,

			  108,  117,  118,  120,  121,  119,  112,  122,  123,  124,
			  105,  125,  106,  128,  111,  113,  129,  130,  131,  132,
			  133,  134,  114,  107,  135,  115,  116,  108,  117,  118,
			  120,  121,  119,  112,  122,  123,  124,  136,  125,  137,
			  128,  138,  139,  129,  130,  131,  132,  133,  134,  140,
			  141,  135,  142,  143,  144,  145,  146,  147,  148,  149,
			  150,  151,  152,  153,  136,  154,  137,  157,  138,  139,
			  158,  159,  160,  161,  162,  163,  140,  141,  164,  142,
			  143,  144,  145,  146,  147,  148,  149,  150,  151,  152,
			  153,  165,  154,  166,  157,  167,  168,  158,  159,  160,

			  161,  162,  163,  169,  170,  164,  171,  172,  173,  174,
			  176,  175,  177,  178,  179,  180,  181,  183,  165,  184,
			  166,  185,  167,  168,  186,  187,  188,  189,  190,  191,
			  169,  170,  192,  171,  172,  173,  174,  176,  175,  177,
			  178,  179,  180,  181,  183,  193,  184,  194,  185,  195,
			  196,  186,  187,  188,  189,  190,  191,  197,  198,  192,
			  199,  200,  201,  202,  203,  204,  205,  206,  207,  208,
			  209,  210,  193,  211,  194,  212,  195,  196,  213,  214,
			  215,  216,  217,  218,  197,  198,  219,  199,  200,  201,
			  202,  203,  204,  205,  206,  207,  208,  209,  210,  220,

			  211,  221,  212,  222,  224,  213,  214,  215,  216,  217,
			  218,  225,  226,  219,  227,  228,  229,  230,  231,  232,
			  233,  234,  235,  236,  237,   38,  220,   70,  221,   42,
			  222,  224,   34,   34,   34,   34,   41,   39,  225,  226,
			   38,  227,  228,  229,  230,  231,  232,  233,  234,  235,
			  236,  237,   42,  238,   42,   42,    5,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,

			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238>>)
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
			    3,    3,    3,    4,    4,    4,   16,   18,   19,   20,
			   21,   18,   23,   22,   16,   24,   25,   18,   26,   20,
			   22,   16,   27,  241,   29,   30,   31,   32,   33,   44,

			   45,   46,   26,   16,   18,   19,   20,   21,   18,   23,
			   22,   16,   24,   25,   18,   26,   20,   22,   16,   27,
			   28,   29,   30,   31,   32,   33,   44,   45,   46,   26,
			   28,   71,   71,  212,   71,  127,  127,  240,   47,   48,
			  240,   49,   53,  156,  156,  242,  182,   28,  242,   77,
			   50,   69,   54,   40,   50,   51,   39,   28,   37,   37,
			   37,   37,   37,   37,   37,   47,   48,   37,   49,   53,
			   51,   37,   37,   37,   37,   37,   37,   50,   37,   54,
			   37,   50,   51,   52,   37,   52,   37,   55,   56,   37,
			   37,   37,   37,   37,   37,   57,   52,   51,   59,   60,

			   52,   61,   62,   63,   64,   62,   55,   65,   66,   67,
			   52,   68,   52,   95,   55,   56,   97,   98,   99,  100,
			  101,  102,   57,   52,  104,   59,   60,   52,   61,   62,
			   63,   64,   62,   55,   65,   66,   67,  105,   68,  106,
			   95,  107,  108,   97,   98,   99,  100,  101,  102,  109,
			  110,  104,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  105,  124,  106,  128,  107,  108,
			  129,  130,  131,  132,  133,  134,  109,  110,  135,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  136,  124,  137,  128,  138,  139,  129,  130,  131,

			  132,  133,  134,  140,  141,  135,  142,  143,  146,  147,
			  148,  147,  149,  150,  152,  153,  154,  158,  136,  160,
			  137,  161,  138,  139,  163,  164,  165,  166,  167,  168,
			  140,  141,  169,  142,  143,  146,  147,  148,  147,  149,
			  150,  152,  153,  154,  158,  170,  160,  171,  161,  172,
			  173,  163,  164,  165,  166,  167,  168,  174,  175,  169,
			  176,  177,  178,  179,  181,  183,  184,  185,  186,  188,
			  189,  191,  170,  192,  171,  194,  172,  173,  195,  197,
			  199,  201,  203,  204,  174,  175,  206,  176,  177,  178,
			  179,  181,  183,  184,  185,  186,  188,  189,  191,  209,

			  192,  210,  194,  211,  213,  195,  197,  199,  201,  203,
			  204,  214,  215,  206,  218,  220,  223,  224,  226,  228,
			  229,  231,  233,  234,  235,   38,  209,   34,  210,   13,
			  211,  213,  239,  239,  239,  239,    9,    8,  214,  215,
			    7,  218,  220,  223,  224,  226,  228,  229,  231,  233,
			  234,  235,  243,    5,  243,  243,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,

			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   67,   70,  453,  456,  438,  434,  432,
			  456,  456,  456,  419,  456,  456,   56,    0,   53,   57,
			   49,   59,   60,   51,   68,   55,   70,   58,   99,   53,
			   61,   61,   72,   77,  423,  456,  456,  156,  423,  153,
			  149,  456,    0,    0,   82,   72,   66,  117,  102,  120,
			  132,  135,  164,  112,  122,  168,  157,  168,    0,  172,
			  163,  180,  172,  172,  169,  190,  187,  174,  176,  147,
			  456,  129,  456,  456,  456,  456,  456,  137,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  181,    0,  195,  198,  183,

			  202,  183,  204,    0,  187,  209,  220,  210,  221,  228,
			  219,  224,  236,  222,  234,  235,  232,  239,  242,  223,
			  225,  226,  244,    0,  240,    0,  456,  124,  231,  236,
			  244,  236,  237,  251,  238,  244,  254,  256,  261,  262,
			  269,  270,  269,  273,    0,    0,  289,  280,  279,  283,
			  288,    0,  293,  294,  298,  456,  132,    0,  281,    0,
			  298,  296,    0,  296,  304,  306,  291,  292,  299,  315,
			  324,  327,  324,  314,  332,  328,  331,  340,  328,  334,
			    0,  336,  135,  340,  332,  336,  332,    0,  348,  353,
			    0,  354,  337,    0,  354,  361,    0,  337,    0,  348,

			    0,  360,    0,  361,  352,    0,  356,    0,    0,  381,
			  373,  382,   90,  374,  390,  387,    0,    0,  384,    0,
			  387,    0,    0,  384,  381,    0,  390,    0,  398,  403,
			    0,  400,    0,  386,  403,  400,    0,    0,  456,  431,
			  136,   89,  144,  451>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  238,    1,  239,  239,  238,  238,  238,  238,  240,
			  238,  238,  238,  238,  238,  238,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  242,  238,  238,  238,  238,  238,
			  240,  238,  243,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  242,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  241,  241,  241,  241,  241,

			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  238,  238,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  238,  238,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  238,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,

			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,  241,    0,  238,
			  238,  238,  238,  238>>)
		end

	yy_ec_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    4,    1,    1,    5,    1,    6,
			    7,    8,    1,    1,    9,   10,    1,   11,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   13,   14,
			   15,    1,   16,    1,    1,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   27,   28,   29,   30,   31,
			   32,   33,   34,   35,   36,   37,   38,   39,   40,   41,
			   42,    1,    1,    1,    1,   43,    1,   44,   45,   46,

			   47,   48,   49,   50,   51,   52,   53,   54,   55,   56,
			   57,   58,   59,   60,   61,   62,   63,   64,   65,   66,
			   67,   68,   69,    1,    1,    1,    1,    1,    1,    1,
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
			    0,    1,    1,    2,    1,    3,    1,    1,    1,    1,
			    1,    1,    4,    1,    1,    1,    1,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,   78,   76,    2,    3,   48,
			    7,    8,    6,   76,    5,    4,   45,   45,   13,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   49,   75,   73,   74,    2,    3,
			   48,   46,    1,   45,   45,   45,   11,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   32,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   45,   49,
			   73,    0,   66,   64,   65,   67,   68,    0,   69,   70,
			   50,   51,   52,   53,   54,   55,   56,   57,   58,   59,
			   60,   61,   62,   63,   47,   45,   10,   45,   45,   45,

			   45,   45,   45,   19,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   42,   45,   44,   72,    0,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   30,   31,   45,   45,   45,   45,
			   45,   39,   45,   45,   45,   71,    0,    9,   45,   14,
			   45,   45,   17,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   41,   45,    0,   45,   45,   45,   45,   20,   45,   45,
			   23,   45,   45,   26,   45,   45,   33,   45,   35,   45,

			   37,   45,   40,   45,   45,   15,   45,   18,   21,   45,
			   45,   45,   27,   45,   45,   45,   38,   43,   45,   16,
			   45,   24,   25,   45,   45,   34,   45,   12,   45,   45,
			   29,   45,   22,   45,   45,   45,   36,   28,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 456
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 238
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 239
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

	yyNb_rules: INTEGER is 77
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 78
			-- End of buffer rule code

	INITIAL: INTEGER is 0
	IN_STR: INTEGER is 1
			-- Start condition codes

feature -- User-defined features



end -- class LACE_SCANNER


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
