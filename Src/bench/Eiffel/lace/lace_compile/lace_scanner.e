indexing

	description: "Scanners for Lace parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LACE_SCANNER

inherit

	LACE_SCANNER_SKELETON

	PLATFORM_CONSTANTS
		export
			{NONE} all
		end

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
--|#line 37

				current_position.go_to (text_count)
				if is_windows then
					comment_list.extend (text_substring (1, text_count - 1))
				else
					comment_list.extend (text_substring (1, text_count))
				end
			
when 2 then
--|#line 48
current_position.go_to (text_count)
when 3 then
--|#line 49

				line_number := line_number + text_count
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 4 then
--|#line 58

				current_position.go_to (1)
				last_token := LAC_SEMICOLON
			
when 5 then
--|#line 62

				current_position.go_to (1)
				last_token := LAC_COLON
			
when 6 then
--|#line 66

				current_position.go_to (1)
				last_token := LAC_COMMA
			
when 7 then
--|#line 70

				current_position.go_to (1)
				last_token := LAC_LEFT_PARAM
			
when 8 then
--|#line 74

				current_position.go_to (1)
				last_token := LAC_RIGHT_PARAM
			
when 9 then
--|#line 82

				current_position.go_to (5)
				last_token := LAC_ADAPT
			
when 10 then
--|#line 86

				current_position.go_to (3)
				last_token := LAC_ALL
			
when 11 then
--|#line 90

				current_position.go_to (2)
				last_token := LAC_AS
			
when 12 then
--|#line 94

				current_position.go_to (8)
				last_token := LAC_ASSEMBLY
			
when 13 then
--|#line 98

				current_position.go_to (9)
				last_token := LAC_ASSERTION
			
when 14 then
--|#line 102

				current_position.go_to (5)
				last_token := LAC_CHECK
			
when 15 then
--|#line 106

				current_position.go_to (7)
				last_token := LAC_CLUSTER
			
when 16 then
--|#line 110

				current_position.go_to (6)
				last_token := LAC_CREATION
			
when 17 then
--|#line 114

				current_position.go_to (8)
				last_token := LAC_CREATION
			
when 18 then
--|#line 118

				current_position.go_to (5)
				last_token := LAC_DEBUG
			
when 19 then
--|#line 122

				current_position.go_to (14)
				last_token := LAC_DISABLED_DEBUG
			
when 20 then
--|#line 126

				current_position.go_to (7)
				last_token := LAC_DEFAULT
			
when 21 then
--|#line 130

				current_position.go_to (3)
				last_token := LAC_END
			
when 22 then
--|#line 134

				current_position.go_to (6)
				last_token := LAC_ENSURE
			
when 23 then
--|#line 138

				current_position.go_to (7)
				last_token := LAC_EXCLUDE
			
when 24 then
--|#line 142

				current_position.go_to (6)
				last_token := LAC_DEPEND
			
when 25 then
--|#line 146

				current_position.go_to (6)
				last_token := LAC_EXPORT
			
when 26 then
--|#line 150

				current_position.go_to (8)
				last_token := LAC_EXTERNAL
			
when 27 then
--|#line 154

				current_position.go_to (8)
				last_token := LAC_GENERATE
			
when 28 then
--|#line 159

				current_position.go_to (6)
				last_token := LAC_IGNORE
			
when 29 then
--|#line 163

				current_position.go_to (7)
				last_token := LAC_INCLUDE
			
when 30 then
--|#line 167

				current_position.go_to (9)
				last_token := LAC_INVARIANT
			
when 31 then
--|#line 171

				current_position.go_to (7)
				last_token := LAC_LIBRARY
			
when 32 then
--|#line 175

				current_position.go_to (4)
				last_token := LAC_LOOP
			
when 33 then
--|#line 179

				current_position.go_to (2)
				last_token := LAC_NO
			
when 34 then
--|#line 183

				current_position.go_to (8)
				last_token := LAC_OPTIMIZE
			
when 35 then
--|#line 187

				current_position.go_to (6)
				last_token := LAC_OPTION
			
when 36 then
--|#line 191

				current_position.go_to (11)
				last_token := LAC_PRECOMPILED
			
when 37 then
--|#line 195

				current_position.go_to (6)
				last_token := LAC_PREFIX
			
when 38 then
--|#line 199

				current_position.go_to (6)
				last_token := LAC_RENAME
			
when 39 then
--|#line 203

				current_position.go_to (7)
				last_token := LAC_REQUIRE
			
when 40 then
--|#line 207

				current_position.go_to (4)
				last_token := LAC_ROOT
			
when 41 then
--|#line 211

				current_position.go_to (6)
				last_token := LAC_SYSTEM
			
when 42 then
--|#line 215

				current_position.go_to (5)
				last_token := LAC_TRACE
			
when 43 then
--|#line 219

				current_position.go_to (3)
				last_token := LAC_USE
			
when 44 then
--|#line 223

				current_position.go_to (7)
				last_token := LAC_VISIBLE
			
when 45 then
--|#line 227

				current_position.go_to (3)
				last_token := LAC_YES
			
when 46 then
--|#line 235

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := LAC_IDENTIFIER
			
when 47 then
--|#line 247

					-- Empty string.
				current_position.go_to (2)
				report_string_empty_error
				last_token := LAC_STRING
			
when 48 then
--|#line 253

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := LAC_STRING
			
when 49 then
--|#line 259

				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (IN_STR)
			
when 50 then
--|#line 268

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			
when 51 then
--|#line 272

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 52 then
--|#line 276

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 53 then
--|#line 280

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 54 then
--|#line 284

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 55 then
--|#line 288

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 56 then
--|#line 292

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 57 then
--|#line 296

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 58 then
--|#line 300

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 59 then
--|#line 304

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 60 then
--|#line 308

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 61 then
--|#line 312

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 62 then
--|#line 316

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 63 then
--|#line 320

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 64 then
--|#line 324

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 65 then
--|#line 328

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 66 then
--|#line 332

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 67 then
--|#line 336

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 68 then
--|#line 340

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 69 then
--|#line 344

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 70 then
--|#line 348

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 71 then
--|#line 352

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 72 then
--|#line 356

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 73 then
--|#line 360

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 74 then
--|#line 367

				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
					report_string_empty_error
				end
				last_token := LAC_STRING
			
when 75 then
--|#line 378

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 76 then
--|#line 384

					-- No final double-quote.
				line_number := line_number + 1
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 77 then
--|#line 405

				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			
when 78 then
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
			   19,   20,   17,   21,   17,   22,   17,   17,   23,   17,
			   24,   25,   26,   17,   27,   28,   29,   30,   31,   17,
			   32,   17,    6,   16,   17,   18,   19,   20,   17,   21,
			   17,   22,   17,   17,   23,   17,   24,   25,   26,   17,
			   27,   28,   29,   30,   31,   17,   32,   17,   34,   35,
			   36,   34,   35,   36,   43,   46,   49,   51,   53,   47,
			   50,   54,   44,   58,   56,   48,   52,   59,   55,   45,
			   57,   60,   42,   63,   64,   65,   66,   67,   94,   95,

			   43,   46,   49,   51,   53,   47,   50,   54,   44,   58,
			   56,   48,   52,   59,   55,   45,   57,   60,   61,   63,
			   64,   65,   66,   67,   94,   95,   96,   97,   62,   70,
			   70,  237,  125,  155,  156,   39,   98,   99,   39,  103,
			  109,  155,  185,   68,   61,  155,   68,   41,  110,   41,
			   41,  126,   96,   97,   62,   70,   70,   71,   72,   73,
			   74,   75,   98,   99,   76,  103,  109,  106,   77,   78,
			   79,   80,   81,   82,  110,   83,  111,   84,  100,  104,
			  107,   85,  101,   86,  108,  113,   87,   88,   89,   90,
			   91,   92,  102,  106,  105,  112,  114,  115,  116,  119,

			  117,  120,  111,  118,  100,  104,  107,  121,  101,  122,
			  108,  113,  123,  124,  127,  128,  129,  130,  102,  131,
			  105,  112,  114,  115,  116,  119,  117,  120,  132,  118,
			  133,  134,  135,  121,  136,  122,  137,  138,  123,  124,
			  127,  128,  129,  130,  139,  131,  140,  141,  142,  143,
			  144,  145,  146,  149,  132,  150,  133,  134,  135,  151,
			  136,  147,  137,  138,  148,  152,  153,  154,  157,  160,
			  139,  161,  140,  141,  142,  143,  144,  145,  146,  149,
			  162,  150,  163,  158,  164,  151,  165,  147,  159,  166,
			  148,  152,  153,  154,  157,  160,  167,  161,  168,  169,

			  170,  171,  172,  173,  174,  175,  162,  178,  163,  158,
			  164,  176,  165,  177,  159,  166,  179,  180,  181,  182,
			  183,  184,  167,  186,  168,  169,  170,  171,  172,  173,
			  174,  175,  187,  178,  188,  191,  189,  176,  192,  177,
			  190,  193,  179,  180,  181,  182,  183,  184,  194,  186,
			  195,  196,  197,  198,  199,  200,  201,  202,  187,  203,
			  188,  191,  189,  204,  192,  205,  190,  193,  206,  207,
			  208,  209,  210,  211,  194,  212,  195,  196,  197,  198,
			  199,  200,  201,  202,  213,  203,  214,  215,  216,  204,
			  217,  205,  218,  219,  206,  207,  208,  209,  210,  211,

			  220,  212,  221,  222,  223,  224,  225,  226,  227,  228,
			  213,  229,  214,  215,  216,  230,  217,  231,  218,  219,
			  232,  233,  234,  235,  236,  238,  220,  239,  221,  222,
			  223,  224,  225,  226,  227,  228,  240,  229,  241,  242,
			  243,  230,  244,  231,  245,  246,  232,  233,  234,  235,
			  236,  238,   69,  239,   33,   33,   33,   33,   93,   38,
			   37,   69,  240,   41,  241,  242,  243,   40,  244,   38,
			  245,  246,   37,  247,    5,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,

			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247>>)
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
			    1,    1,    1,    1,    1,    1,    1,    1,    3,    3,
			    3,    4,    4,    4,   16,   18,   19,   20,   21,   18,
			   19,   22,   16,   24,   23,   18,   20,   25,   22,   16,
			   23,   26,  250,   28,   29,   30,   31,   32,   43,   44,

			   16,   18,   19,   20,   21,   18,   19,   22,   16,   24,
			   23,   18,   20,   25,   22,   16,   23,   26,   27,   28,
			   29,   30,   31,   32,   43,   44,   45,   46,   27,   70,
			   70,  230,   70,  126,  126,  249,   47,   48,  249,   50,
			   53,  156,  156,  251,   27,  185,  251,  252,   54,  252,
			  252,   76,   45,   46,   27,   36,   36,   36,   36,   36,
			   36,   36,   47,   48,   36,   50,   53,   52,   36,   36,
			   36,   36,   36,   36,   54,   36,   55,   36,   49,   51,
			   52,   36,   49,   36,   52,   56,   36,   36,   36,   36,
			   36,   36,   49,   52,   51,   55,   57,   59,   60,   62,

			   61,   63,   55,   61,   49,   51,   52,   64,   49,   65,
			   52,   56,   66,   67,   94,   96,   97,   98,   49,   99,
			   51,   55,   57,   59,   60,   62,   61,   63,  100,   61,
			  101,  102,  103,   64,  105,   65,  106,  107,   66,   67,
			   94,   96,   97,   98,  108,   99,  109,  110,  111,  112,
			  113,  114,  115,  117,  100,  118,  101,  102,  103,  119,
			  105,  116,  106,  107,  116,  120,  121,  123,  127,  129,
			  108,  130,  109,  110,  111,  112,  113,  114,  115,  117,
			  131,  118,  132,  128,  133,  119,  134,  116,  128,  135,
			  116,  120,  121,  123,  127,  129,  136,  130,  137,  138,

			  139,  140,  141,  142,  143,  144,  131,  147,  132,  128,
			  133,  146,  134,  146,  128,  135,  148,  149,  150,  152,
			  153,  154,  136,  158,  137,  138,  139,  140,  141,  142,
			  143,  144,  159,  147,  161,  164,  162,  146,  165,  146,
			  162,  166,  148,  149,  150,  152,  153,  154,  167,  158,
			  168,  169,  170,  171,  172,  173,  174,  175,  159,  176,
			  161,  164,  162,  177,  165,  178,  162,  166,  179,  180,
			  181,  182,  184,  186,  167,  187,  168,  169,  170,  171,
			  172,  173,  174,  175,  188,  176,  190,  191,  193,  177,
			  195,  178,  197,  198,  179,  180,  181,  182,  184,  186,

			  200,  187,  201,  202,  203,  205,  208,  210,  211,  212,
			  188,  214,  190,  191,  193,  216,  195,  218,  197,  198,
			  219,  221,  223,  224,  228,  233,  200,  235,  201,  202,
			  203,  205,  208,  210,  211,  212,  237,  214,  239,  240,
			  241,  216,  242,  218,  244,  245,  219,  221,  223,  224,
			  228,  233,   68,  235,  248,  248,  248,  248,   39,   38,
			   37,   33,  237,   13,  239,  240,  241,    9,  242,    8,
			  244,  245,    7,    5,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,

			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   65,   68,  473,  474,  470,  466,  463,
			  474,  474,  474,  453,  474,  474,   54,    0,   51,   55,
			   47,   57,   58,   59,   52,   55,   57,   97,   53,   60,
			   60,   71,   76,  457,  474,  474,  153,  458,  456,  454,
			  474,    0,    0,   81,   71,   91,  106,   99,  116,  160,
			  104,  159,  148,  110,  118,  157,  167,  165,    0,  161,
			  177,  170,  168,  166,  190,  188,  177,  178,  448,  474,
			  127,  474,  474,  474,  474,  474,  139,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  182,    0,  194,  197,  182,  202,

			  191,  213,  210,  215,    0,  197,  208,  206,  223,  225,
			  216,  220,  232,  216,  219,  227,  242,  236,  218,  223,
			  229,  247,    0,  242,    0,  474,  122,  232,  254,  242,
			  235,  244,  259,  247,  256,  271,  262,  261,  265,  266,
			  267,  268,  266,  270,  288,    0,  282,  276,  291,  288,
			  293,    0,  298,  299,  303,  474,  130,    0,  305,  296,
			    0,  313,  315,    0,  307,  318,  313,  327,  330,  315,
			  322,  336,  333,  335,  331,  323,  334,  333,  336,  329,
			  348,  336,  342,    0,  344,  134,  345,  350,  350,    0,
			  355,  351,    0,  367,    0,  369,    0,  375,  357,    0,

			  379,  385,  363,  363,    0,  373,    0,    0,  385,    0,
			  386,  368,  378,    0,  381,    0,  395,    0,  389,  399,
			    0,  391,    0,  401,  398,    0,    0,    0,  394,    0,
			   89,    0,    0,  389,    0,  399,    0,  416,    0,  417,
			  418,  420,  424,    0,  407,  422,    0,  474,  453,  134,
			   88,  142,  146>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  247,    1,  248,  248,  247,  247,  247,  247,  249,
			  247,  247,  247,  247,  247,  247,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  251,  247,  247,  247,  247,  247,  249,
			  247,  252,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  251,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  250,  250,  250,  250,  250,  250,

			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  247,  247,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  247,  247,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  247,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,

			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,    0,  247,  247,
			  247,  247,  247>>)
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
			   32,   33,   34,   35,   36,   37,   38,   26,   39,   40,
			   41,    1,    1,    1,    1,   42,    1,   43,   44,   45,

			   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   63,   64,   52,
			   65,   66,   67,    1,    1,    1,    1,    1,    1,    1,
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
			    4,    4,    4,    4,    4,    4,    4,    4>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,   79,   77,    2,    3,   49,
			    7,    8,    6,   77,    5,    4,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   50,   76,   74,   75,    2,    3,   49,
			   47,    1,   46,   46,   46,   11,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   33,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   50,   74,
			    0,   67,   65,   66,   68,   69,    0,   70,   71,   51,
			   52,   53,   54,   55,   56,   57,   58,   59,   60,   61,
			   62,   63,   64,   48,   46,   10,   46,   46,   46,   46,

			   46,   46,   46,   46,   21,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   43,   46,   45,   73,    0,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   32,   46,   46,   46,   46,
			   46,   40,   46,   46,   46,   72,    0,    9,   46,   46,
			   14,   46,   46,   18,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   42,   46,    0,   46,   46,   46,   16,
			   46,   46,   24,   46,   22,   46,   25,   46,   46,   28,

			   46,   46,   46,   46,   35,   46,   37,   38,   46,   41,
			   46,   46,   46,   15,   46,   20,   46,   23,   46,   46,
			   29,   46,   31,   46,   46,   39,   44,   12,   46,   17,
			   46,   26,   27,   46,   34,   46,   13,   46,   30,   46,
			   46,   46,   46,   36,   46,   46,   19,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 474
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 247
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 248
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

	yyNb_rules: INTEGER is 78
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 79
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
