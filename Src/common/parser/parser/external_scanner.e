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
--|#line 35
current_position.go_to (text_count)
when 2 then
--|#line 36
current_position.go_to (text_count)
when 3 then
--|#line 40

				current_position.go_to (1)
				last_token := TE_COLON
			
when 4 then
--|#line 44

				current_position.go_to (1)
				last_token := TE_LPARAN
			
when 5 then
--|#line 48

				current_position.go_to (1)
				last_token := TE_RPARAN
			
when 6 then
--|#line 52

				current_position.go_to (1)
				last_token := TE_COMMA
			
when 7 then
--|#line 56

				current_position.go_to (1)
				last_token := TE_STAR
			
when 8 then
--|#line 60

				current_position.go_to (1)
				last_token := TE_ADDRESS
			
when 9 then
--|#line 64

				current_position.go_to (1)
				last_token := TE_LT
			
when 10 then
--|#line 68

				current_position.go_to (1)
				last_token := TE_GT
			
when 11 then
--|#line 72

				current_position.go_to (1)
				last_token := TE_DQUOTE
			
when 12 then
--|#line 78

				current_position.go_to (6)
				last_token := TE_ACCESS
			
when 13 then
--|#line 82

				current_position.go_to (1)
				last_token := TE_C_LANGUAGE
			
when 14 then
--|#line 86

				current_position.go_to (16)
				last_token := TE_C_LANGUAGE
			
when 15 then
--|#line 90

				current_position.go_to (22)
				last_token := TE_C_LANGUAGE
			
when 16 then
--|#line 94

				current_position.go_to (3)
				last_token := TE_CPP_LANGUAGE
			
when 17 then
--|#line 98

				current_position.go_to (7)
				last_token := TE_CREATOR
			
when 18 then
--|#line 102

				current_position.go_to (8)
				last_token := TE_DEFERRED
			
when 19 then
--|#line 106

				current_position.go_to (6)
				last_token := TE_DELETE
			
when 20 then
--|#line 110

				current_position.go_to (3)
				last_token := TE_DLL_LANGUAGE
			
when 21 then
--|#line 114

				current_position.go_to (6)
				last_token := TE_DLLWIN_LANGUAGE
			
when 22 then
--|#line 118

				current_position.go_to (4)
				last_token := TE_ENUM
			
when 23 then
--|#line 122

				current_position.go_to (5)
				last_token := TE_FIELD
			
when 24 then
--|#line 126

				current_position.go_to (12)
				last_token := TE_GET_PROPERTY
			
when 25 then
--|#line 130

				current_position.go_to (2)
				last_token := TE_IL_LANGUAGE
			
when 26 then
--|#line 134

				current_position.go_to (6)
				last_token := TE_INLINE
			
when 27 then
--|#line 138

				current_position.go_to (3)
				last_token := TE_JAVA_LANGUAGE
			
when 28 then
--|#line 142

				current_position.go_to (5)
				last_token := TE_MACRO
			
when 29 then
--|#line 146

				current_position.go_to (8)
				last_token := TE_OPERATOR
			
when 30 then
--|#line 150

				current_position.go_to (9)
				last_token := TE_SET_FIELD
			
when 31 then
--|#line 154

				current_position.go_to (12)
				last_token := TE_SET_PROPERTY
			
when 32 then
--|#line 158

				current_position.go_to (16)
				last_token := TE_SET_STATIC_FIELD
			
when 33 then
--|#line 162

				current_position.go_to (9)
				last_token := TE_SIGNATURE
			
when 34 then
--|#line 166

				current_position.go_to (8)
				last_token := TE_SIGNED
			
when 35 then
--|#line 170

				current_position.go_to (6)
				last_token := TE_STATIC
			
when 36 then
--|#line 174

				current_position.go_to (12)
				last_token := TE_STATIC_FIELD
			
when 37 then
--|#line 178

				current_position.go_to (6)
				last_token := TE_STRUCT
			
when 38 then
--|#line 182

				current_position.go_to (4)
				last_token := TE_TYPE
			
when 39 then
--|#line 186

				current_position.go_to (8)
				last_token := TE_UNSIGNED
			
when 40 then
--|#line 190

				current_position.go_to (3)
				last_token := TE_USE
			
when 41 then
--|#line 196

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				token_buffer.remove_head (1)
				last_token := TE_ID
			
when 42 then
--|#line 204

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 43 then
--|#line 210

				current_position.go_to (1)
			
when 44 then
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
			    0,    4,    5,    6,    5,    7,    4,    8,    9,   10,
			   11,    4,   12,    4,   13,   14,   15,    4,   16,   17,
			   18,   13,   19,   20,   21,   22,   23,   13,   24,   25,
			   13,   26,   13,   27,   13,   13,   28,   29,   30,   13,
			   13,   13,    4,    4,   13,   18,   13,   19,   20,   21,
			   22,   23,   13,   24,   25,   13,   26,   13,   27,   13,
			   13,   31,   29,   32,   13,   13,   13,   33,   35,   33,
			   35,   35,   35,   35,   35,   39,   35,   35,   35,   35,
			   37,   35,   35,   35,   38,   33,   35,   33,   35,   42,
			   35,   46,   50,   62,   35,   43,   45,   35,   44,   40,

			   47,   35,   48,   36,   36,   35,   61,   51,   41,   38,
			   49,   56,   56,   35,   42,   52,   46,   50,   55,   53,
			   43,   45,   35,   44,   40,   47,   35,   48,   54,   35,
			   35,   61,   51,   58,   60,   49,   56,   56,   35,   37,
			   52,   37,   35,   55,   53,   37,   35,   52,   63,   35,
			   68,   53,   35,   54,   69,   35,   35,   66,   35,   35,
			   54,   35,   67,   35,   35,   35,   72,   70,   64,   35,
			   37,   37,   52,   63,   74,   68,   57,   75,   35,   69,
			   65,   73,   66,   71,   77,   54,   76,   67,   92,   35,
			   35,   72,   70,   64,   35,   35,   81,   80,   35,   74,

			   35,   35,   75,   78,   35,   65,   73,   35,   71,   77,
			   77,   76,   85,   92,   86,   35,   83,   88,   79,   89,
			   35,   81,   80,   35,   87,   90,   35,   35,   78,   35,
			   35,   35,   35,   35,   35,   82,   35,   85,   91,   86,
			   35,   35,   88,   79,   89,   35,   99,   93,   95,   87,
			   90,  102,   35,   94,   35,   35,   96,  112,   97,   35,
			   99,   35,  100,   91,  101,   35,  105,   35,   98,  107,
			   35,   99,   93,   95,  111,   35,  102,   35,   35,   35,
			  114,   96,  112,   97,   35,  103,  106,  100,  104,  101,
			  108,  105,  110,  113,  107,   35,  109,  115,  116,  111,

			   35,  121,   35,   35,   35,  114,   35,  125,   35,  120,
			   35,  106,   35,   35,   35,  108,  153,  110,  113,  117,
			  122,  109,  115,  116,   35,  127,  121,  120,  118,  128,
			  119,   35,  125,  126,  120,   35,   35,   35,  131,  129,
			   35,   35,  130,  132,  117,  122,   35,  124,   35,  133,
			  127,   35,  120,  118,  128,  119,  123,   35,  126,  135,
			   35,   35,  139,  131,  129,  136,  134,  130,  132,   35,
			   35,  137,  138,   35,  133,   35,   35,   35,   35,  140,
			   35,   35,   35,   35,  135,   35,   35,  139,  145,  143,
			  136,  134,   35,  141,  146,  144,  137,  138,  149,  151,

			  147,   35,  148,   35,  140,  150,  160,   35,  142,  152,
			  155,   35,   35,  145,  143,   35,   35,   35,  156,  146,
			  144,   35,   35,  149,  151,  147,  154,  148,  157,  158,
			  150,  160,  159,   35,  152,  155,  164,   35,  162,   35,
			  161,   35,   35,  156,  163,   35,   35,   35,   35,   35,
			   35,  176,   35,  157,  158,  166,  169,  159,  165,  168,
			  170,  164,   35,  162,  167,  161,  172,  171,  173,  163,
			   35,  174,   35,   35,   35,   35,  176,   35,  175,  177,
			  166,  169,   35,  180,  168,  170,  178,   35,   35,  167,
			  179,  172,  171,  173,   35,   35,  174,   35,   35,   35,

			   35,  185,   35,  175,  177,  181,  182,   35,  180,  186,
			   35,  178,  184,  183,  190,  179,  187,  191,   35,   35,
			   35,   35,   35,   35,  194,  192,  185,   35,  193,  188,
			  181,  182,  189,  199,  186,   35,  196,   35,  183,  190,
			  197,  187,  191,  201,  200,   35,   35,   35,   35,  194,
			  192,  195,  198,  193,  188,  204,   35,  189,  199,   35,
			   35,  196,  203,  208,   35,  197,  202,   35,  201,  200,
			   35,   35,   35,   35,   35,  205,  195,  198,  207,  209,
			  204,   35,   37,   35,   35,  206,   35,  203,  208,   84,
			   36,  202,   35,   35,   59,   34,   35,   35,   34,  210,

			  205,  210,  210,  207,  209,  210,  210,  210,  210,  210,
			  206,    3,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210>>)
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
			    1,    1,    1,    1,    1,    1,    1,    5,   18,    5,
			   19,   20,   21,   23,   22,   19,   24,   25,   26,   27,
			  212,   30,   32,   29,   18,   33,  209,   33,   39,   20,
			   38,   23,   26,   39,  203,   20,   22,   28,   21,   19,

			   24,  202,   24,  211,  211,  191,   38,   27,   19,   18,
			   25,   30,   32,  189,   20,   28,   23,   26,   29,   28,
			   20,   22,   44,   21,   19,   24,   43,   24,   28,   31,
			   40,   38,   27,   32,   37,   25,   30,   32,   42,   37,
			   28,   37,   48,   29,   28,   37,   41,   31,   40,   45,
			   43,   31,   46,   28,   44,   52,   49,   42,   50,   51,
			   31,   58,   42,   69,   53,  188,   48,   45,   41,   55,
			   37,   37,   31,   40,   50,   43,   31,   51,   56,   44,
			   41,   49,   42,   46,   53,   31,   52,   42,   69,   54,
			   57,   48,   45,   41,   61,   65,   56,   55,   64,   50,

			   63,   66,   51,   54,   68,   41,   49,   67,   46,   53,
			   57,   52,   61,   69,   63,   71,   58,   65,   54,   66,
			   77,   56,   55,   70,   64,   67,   72,   74,   54,   75,
			   76,   78,   79,   80,   82,   57,   85,   61,   68,   63,
			   93,   83,   65,   54,   66,   87,   77,   70,   72,   64,
			   67,   80,   91,   71,   95,   86,   74,   93,   75,   88,
			   82,   90,   78,   68,   79,   94,   85,   89,   76,   87,
			   96,   77,   70,   72,   91,  172,   80,  105,  139,  100,
			   95,   74,   93,   75,   97,   82,   86,   78,   83,   79,
			   88,   85,   90,   94,   87,   99,   89,   96,   97,   91,

			   98,  100,  104,  107,  101,   95,  106,  105,  108,   99,
			  109,   86,  111,  103,  113,   88,  139,   90,   94,   98,
			  101,   89,   96,   97,  110,  107,  100,  103,   98,  108,
			   98,  114,  105,  106,   99,  116,  118,  117,  111,  109,
			  119,  120,  110,  113,   98,  101,  121,  104,  122,  114,
			  107,  123,  103,   98,  108,   98,  103,  124,  106,  117,
			  126,  128,  121,  111,  109,  118,  116,  110,  113,  127,
			  169,  119,  120,  132,  114,  134,  129,  138,  136,  122,
			  135,  165,  149,  142,  117,  137,  145,  121,  128,  126,
			  118,  116,  144,  123,  129,  127,  119,  120,  135,  137,

			  132,  147,  134,  148,  122,  136,  149,  151,  124,  138,
			  144,  146,  150,  128,  126,  152,  154,  153,  145,  129,
			  127,  155,  168,  135,  137,  132,  142,  134,  146,  147,
			  136,  149,  148,  156,  138,  144,  153,  159,  151,  160,
			  150,  158,  161,  145,  152,  162,  164,  157,  163,  166,
			  170,  168,  174,  146,  147,  155,  160,  148,  154,  158,
			  161,  153,  167,  151,  156,  150,  163,  162,  164,  152,
			  171,  166,  173,  175,  178,  176,  168,  179,  167,  170,
			  155,  160,  177,  174,  158,  161,  171,  181,  180,  156,
			  173,  163,  162,  164,  182,  184,  166,  183,  186,  187,

			  185,  179,  190,  167,  170,  175,  176,  196,  174,  180,
			  143,  171,  178,  177,  184,  173,  181,  185,  193,  192,
			  197,  195,  194,  201,  190,  186,  179,  198,  187,  182,
			  175,  176,  183,  196,  180,  199,  193,  207,  177,  184,
			  194,  181,  185,  198,  197,  200,  204,  141,  208,  190,
			  186,  192,  195,  187,  182,  201,  205,  183,  196,  140,
			  206,  193,  200,  207,  133,  194,  199,  131,  198,  197,
			  130,  125,  115,  112,  102,  204,  192,  195,  206,  208,
			  201,   92,   84,   81,   73,  205,   62,  200,  207,   60,
			   59,  199,   47,   36,   35,   34,   13,    8,    6,    3,

			  204,    0,    0,  206,  208,    0,    0,    0,    0,    0,
			  205,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  599,  611,   65,  595,  611,  591,  611,
			  611,  611,  611,  590,  611,  611,  611,    0,   62,   64,
			   65,   66,   68,   67,   70,   71,   72,   73,   91,   77,
			   75,  123,   76,   83,  592,  582,  587,  128,   84,   82,
			  124,  140,  132,  120,  116,  143,  146,  586,  136,  150,
			  152,  153,  149,  158,  183,  163,  172,  184,  155,  586,
			  577,  188,  580,  194,  192,  189,  195,  201,  198,  157,
			  217,  209,  220,  578,  221,  223,  224,  214,  225,  226,
			  227,  577,  228,  235,  578,  230,  249,  239,  253,  261,
			  255,  246,  575,  234,  259,  248,  264,  278,  294,  289,

			  273,  298,  568,  307,  296,  271,  300,  297,  302,  304,
			  318,  306,  567,  308,  325,  566,  329,  331,  330,  334,
			  335,  340,  342,  345,  351,  565,  354,  363,  355,  370,
			  564,  561,  367,  558,  369,  374,  372,  379,  371,  272,
			  553,  541,  377,  504,  386,  380,  405,  395,  397,  376,
			  406,  401,  409,  411,  410,  415,  427,  441,  435,  431,
			  433,  436,  439,  442,  440,  375,  443,  456,  416,  364,
			  444,  464,  269,  466,  446,  467,  469,  476,  468,  471,
			  482,  481,  488,  491,  489,  494,  492,  493,  159,  107,
			  496,   99,  513,  512,  516,  515,  501,  514,  521,  529,

			  539,  517,   95,   88,  540,  550,  554,  531,  542,   80,
			  611,  101,   77>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  210,    1,  210,  210,  210,  210,  210,  211,  210,
			  210,  210,  210,  211,  210,  210,  210,  212,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  210,  210,  210,  211,  212,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  210,
			  210,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  210,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,

			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,

			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			    0,  210,  210>>)
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
			    8,    9,   10,   11,   12,    1,   13,    1,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   15,    1,
			   16,   17,   18,    1,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   29,   21,   30,   31,   32,   33,
			   34,   21,   35,   36,   37,   38,   39,   40,   21,   41,
			   21,   42,    1,   43,    1,   44,    1,   45,   46,   47,

			   48,   49,   50,   51,   52,   53,   54,   46,   55,   56,
			   57,   58,   59,   46,   60,   61,   62,   63,   64,   65,
			   46,   66,   46,    1,    1,    1,    1,    1,    1,    1,
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
			    1,    2,    1,    2,    3,    1,    1,    2,    1,    1,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    2,    2,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   45,   43,    1,    2,   11,    8,    4,
			    5,    7,    6,   42,    3,    9,   10,   43,   42,   13,
			   42,   42,   42,   42,   42,   42,   42,   42,   42,   42,
			   42,   42,   42,    1,    2,    0,   42,   41,   42,   42,
			   42,   42,   42,   42,   42,   42,   42,   25,   42,   42,
			   42,   42,   42,   42,   42,   42,   42,   42,   42,    0,
			    0,   42,   16,   42,   42,   42,   42,   42,   20,   42,
			   42,   42,   42,   27,   42,   42,   42,   42,   42,   42,
			   42,   40,   42,   42,    0,   42,   42,   42,   42,   42,
			   42,   42,   22,   42,   42,   42,   42,   42,   42,   42,

			   42,   42,   38,   42,   42,   42,   42,   42,   42,   42,
			   42,   42,   23,   42,   42,   28,   42,   42,   42,   42,
			   42,   42,   42,   42,   42,   12,   42,   42,   42,   42,
			   19,   21,   42,   26,   42,   42,   42,   42,   42,   35,
			   37,   34,   42,   17,   42,   42,   42,   42,   42,   42,
			   42,   42,   42,   42,   42,   42,   42,   18,   42,   29,
			   42,   42,   42,   42,   42,   39,   42,   42,   42,   30,
			   42,   42,   33,   42,   42,   42,   42,   42,   42,   42,
			   42,   42,   42,   42,   42,   42,   42,   42,   24,   31,
			   42,   36,   42,   42,   42,   42,   42,   42,   42,   42,

			   42,   42,   14,   32,   42,   42,   42,   42,   42,   15,
			    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 611
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 210
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 211
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

	yyNb_rules: INTEGER is 44
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 45
			-- End of buffer rule code

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
