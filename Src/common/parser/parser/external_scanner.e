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
--|#line 36
current_position.go_to (text_count)
when 2 then
--|#line 37
current_position.go_to (text_count)
when 3 then
--|#line 41

				current_position.go_to (1)
				last_token := TE_COLON
			
when 4 then
--|#line 45

				current_position.go_to (1)
				last_token := TE_LPARAN
			
when 5 then
--|#line 49

				current_position.go_to (1)
				last_token := TE_RPARAN
			
when 6 then
--|#line 53

				current_position.go_to (1)
				last_token := TE_COMMA
			
when 7 then
--|#line 57

				current_position.go_to (1)
				last_token := TE_STAR
			
when 8 then
--|#line 61

				current_position.go_to (1)
				last_token := TE_ADDRESS
			
when 9 then
--|#line 65

				current_position.go_to (1)
				last_token := TE_LT
			
when 10 then
--|#line 69

				current_position.go_to (1)
				last_token := TE_GT
			
when 11 then
--|#line 73

				current_position.go_to (1)
				last_token := TE_DQUOTE
			
when 12 then
--|#line 79

				current_position.go_to (6)
				last_token := TE_ACCESS
			
when 13 then
--|#line 83

				current_position.go_to (1)
				last_token := TE_C_LANGUAGE
			
when 14 then
--|#line 87

				current_position.go_to (16)
				last_token := TE_C_LANGUAGE
			
when 15 then
--|#line 91

				current_position.go_to (22)
				last_token := TE_C_LANGUAGE
			
when 16 then
--|#line 95

				current_position.go_to (3)
				last_token := TE_CPP_LANGUAGE
			
when 17 then
--|#line 99

				current_position.go_to (7)
				last_token := TE_CREATOR
			
when 18 then
--|#line 103

				current_position.go_to (8)
				last_token := TE_DEFERRED
			
when 19 then
--|#line 107

				current_position.go_to (6)
				last_token := TE_DELETE
			
when 20 then
--|#line 111

				current_position.go_to (3)
				last_token := TE_DLL_LANGUAGE
			
when 21 then
--|#line 115

				current_position.go_to (6)
				last_token := TE_DLLWIN_LANGUAGE
			
when 22 then
--|#line 119

				current_position.go_to (4)
				last_token := TE_ENUM
			
when 23 then
--|#line 123

				current_position.go_to (5)
				last_token := TE_FIELD
			
when 24 then
--|#line 127

				current_position.go_to (12)
				last_token := TE_GET_PROPERTY
			
when 25 then
--|#line 131

				current_position.go_to (2)
				last_token := TE_IL_LANGUAGE
			
when 26 then
--|#line 135

				current_position.go_to (6)
				last_token := TE_INLINE
			
when 27 then
--|#line 139

				current_position.go_to (3)
				last_token := TE_JAVA_LANGUAGE
			
when 28 then
--|#line 143

				current_position.go_to (5)
				last_token := TE_MACRO
			
when 29 then
--|#line 147

				current_position.go_to (8)
				last_token := TE_OPERATOR
			
when 30 then
--|#line 151

				current_position.go_to (9)
				last_token := TE_SET_FIELD
			
when 31 then
--|#line 155

				current_position.go_to (12)
				last_token := TE_SET_PROPERTY
			
when 32 then
--|#line 159

				current_position.go_to (16)
				last_token := TE_SET_STATIC_FIELD
			
when 33 then
--|#line 163

				current_position.go_to (9)
				last_token := TE_SIGNATURE
			
when 34 then
--|#line 167

				current_position.go_to (8)
				last_token := TE_SIGNED
			
when 35 then
--|#line 171

				current_position.go_to (6)
				last_token := TE_STATIC
			
when 36 then
--|#line 175

				current_position.go_to (12)
				last_token := TE_STATIC_FIELD
			
when 37 then
--|#line 179

				current_position.go_to (6)
				last_token := TE_STRUCT
			
when 38 then
--|#line 183

				current_position.go_to (4)
				last_token := TE_TYPE
			
when 39 then
--|#line 187

				current_position.go_to (8)
				last_token := TE_UNSIGNED
			
when 40 then
--|#line 191

				current_position.go_to (3)
				last_token := TE_USE
			
when 41 then
--|#line 197

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				token_buffer.remove_head (1)
				last_token := TE_INTEGER
			
when 42 then
--|#line 205

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				token_buffer.remove_head (1)
				last_token := TE_ID
			
when 43 then
--|#line 213

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 44 then
--|#line 219

				current_position.go_to (1)
			
when 45 then
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
			   35,   35,   35,   35,   35,   40,   35,   35,   35,   35,
			   35,   35,   35,   35,   39,   33,   37,   33,   35,   43,
			   35,   47,   51,   63,   35,   44,   46,   35,   45,   41,

			   48,  129,   49,   36,   36,   35,   62,   52,   42,   39,
			   50,   57,   57,   35,   43,   53,   47,   51,   56,   54,
			   44,   46,   35,   45,   41,   48,  129,   49,   55,   35,
			   35,   62,   52,   59,   61,   50,   57,   57,   35,   37,
			   53,   37,   35,   56,   54,   37,   35,   53,   64,   35,
			   61,   54,   35,   55,   70,   37,   71,   37,   38,   35,
			   55,   37,   35,   35,   35,   35,   69,   35,   65,   35,
			   37,   37,   53,   64,   74,   35,   58,   35,   67,   70,
			   66,   71,   35,   68,   35,   55,   37,   37,   73,   78,
			   81,   69,   35,   65,   72,   76,   77,   35,   75,   74,

			   35,   35,   82,   67,   35,   66,   35,   84,   68,   35,
			   35,   79,   78,   73,   78,   81,   35,   35,   86,   72,
			   76,   77,   35,   75,   87,   35,   80,   82,   89,   35,
			   88,   35,   35,   94,   90,   91,   79,   83,   35,   95,
			   35,   35,   35,   86,   35,   35,   35,   35,   35,   87,
			   93,   80,   35,   89,   96,   88,   92,  100,   94,   90,
			   91,  102,  103,   35,   35,  113,   35,   97,   35,   98,
			   35,  100,  101,   35,   35,   93,   35,  106,   35,   96,
			   99,   92,  100,  107,   35,  112,  102,  103,  108,   35,
			  113,   35,   97,  105,   98,  110,  104,  101,  117,  109,

			  115,  111,  106,   35,  114,  116,   35,   35,  107,   35,
			  112,  122,   35,  108,   35,   35,   35,   35,   35,   35,
			  110,  121,  118,  117,  109,  115,  111,   35,  123,  114,
			  116,  119,  121,  120,   35,  131,  122,  128,   35,  126,
			   35,  127,   35,   35,   35,  130,  121,  118,  133,  136,
			   35,  125,  134,  123,   35,   35,  119,  121,  120,   35,
			  131,  124,  128,   35,  126,   35,  127,   35,  132,  135,
			  130,  138,  137,  133,  136,  139,   35,  134,   35,  140,
			   35,  141,   35,   35,  144,  147,   35,   35,   35,   35,
			   35,  145,  152,  132,  135,   35,  138,  137,   35,   35,

			  139,  142,   35,  146,  140,  143,  141,  148,  150,  144,
			  147,   35,  158,  149,  151,  153,  145,  152,   35,   35,
			  154,  157,   35,  161,   35,   35,  159,   35,  146,  156,
			  162,  155,  148,  150,   35,   35,   35,  158,  149,  151,
			  153,  165,   35,   35,   35,   35,  157,  160,  161,   35,
			  163,  159,  170,  164,  156,  162,   35,   35,  172,  176,
			  169,  167,  171,  173,   35,  168,  165,  166,   35,   35,
			   35,  174,  160,   35,  180,  163,   35,  170,  164,  175,
			   35,   35,   35,  172,  176,  169,  167,  171,  173,  179,
			  168,   35,   35,  177,   35,   35,  174,  178,   35,  180,

			  181,   35,  182,   35,  175,   35,  186,  183,   35,   35,
			   35,  184,  187,   35,  179,   35,   35,  191,  177,  185,
			  192,  188,  178,   35,   35,  181,  202,  182,  193,  189,
			  190,  186,  183,  197,  194,  195,  184,  187,   35,   35,
			  196,  198,  191,   35,   35,  192,  188,  199,   35,   35,
			  200,  202,   35,  193,  189,  190,   35,   35,  197,  194,
			  195,  204,  201,   35,   35,  196,  198,   35,   35,  209,
			  203,   35,  199,   35,  208,  200,   35,   35,  206,   35,
			  205,  207,   35,   35,   35,   35,  204,  201,  210,   35,
			   37,   35,   35,   35,  209,  203,   85,   36,   35,  208,

			   35,   60,   34,  206,   38,  205,  207,   35,   35,   34,
			  211,  211,  211,  210,    3,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211>>)
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
			  109,   30,   32,   29,   18,   33,  213,   33,   40,   20,
			   39,   23,   26,   40,  210,   20,   22,   28,   21,   19,

			   24,  109,   24,  212,  212,  204,   39,   27,   19,   18,
			   25,   30,   32,  203,   20,   28,   23,   26,   29,   28,
			   20,   22,   45,   21,   19,   24,  109,   24,   28,   31,
			   41,   39,   27,   32,   37,   25,   30,   32,   46,   37,
			   28,   37,   44,   29,   28,   37,   42,   31,   41,   50,
			   38,   31,   59,   28,   45,   38,   46,   38,   38,   43,
			   31,   38,   56,   47,   49,   53,   44,  192,   42,   54,
			   37,   37,   31,   41,   50,  190,   31,   52,   43,   45,
			   42,   46,   51,   43,   57,   31,   38,   38,   49,   54,
			   56,   44,   58,   42,   47,   52,   53,   55,   51,   50,

			   62,   72,   57,   43,   65,   42,   66,   59,   43,   71,
			   64,   55,   58,   49,   54,   56,   67,   68,   62,   47,
			   52,   53,   69,   51,   64,   70,   55,   57,   66,   80,
			   65,   78,   73,   71,   67,   68,   55,   58,   75,   72,
			   76,   79,   77,   62,   81,   83,   84,   86,   94,   64,
			   70,   55,   87,   66,   73,   65,   69,   78,   71,   67,
			   68,   80,   81,   92,   88,   94,   90,   75,   89,   76,
			   91,   83,   79,  189,   96,   70,   95,   86,   97,   73,
			   77,   69,   78,   87,   98,   92,   80,   81,   88,  101,
			   94,  173,   75,   84,   76,   90,   83,   79,   98,   89,

			   96,   91,   86,   99,   95,   97,  105,  100,   87,  106,
			   92,  101,  102,   88,  107,  108,  110,  111,  104,  114,
			   90,  100,   99,   98,   89,   96,   91,  118,  102,   95,
			   97,   99,  104,   99,  115,  111,  101,  108,  117,  106,
			  120,  107,  112,  119,  121,  110,  100,   99,  114,  118,
			  123,  105,  115,  102,  125,  127,   99,  104,   99,  124,
			  111,  104,  108,  122,  106,  128,  107,  130,  112,  117,
			  110,  120,  119,  114,  118,  121,  129,  115,  138,  122,
			  133,  123,  140,  139,  127,  130,  135,  137,  143,  146,
			  136,  128,  138,  112,  117,  147,  120,  119,  148,  150,

			  121,  124,  151,  129,  122,  125,  123,  133,  136,  127,
			  130,  145,  147,  135,  137,  139,  128,  138,  149,  152,
			  140,  146,  154,  150,  153,  155,  148,  156,  129,  145,
			  151,  143,  133,  136,  157,  161,  163,  147,  135,  137,
			  139,  154,  159,  168,  162,  164,  146,  149,  150,  165,
			  152,  148,  161,  153,  145,  151,  174,  167,  163,  168,
			  159,  156,  162,  164,  169,  157,  154,  155,  171,  175,
			  176,  165,  149,  172,  174,  152,  177,  161,  153,  167,
			  178,  179,  180,  163,  168,  159,  156,  162,  164,  172,
			  157,  181,  182,  169,  183,  184,  165,  171,  185,  174,

			  175,  187,  176,  186,  167,  188,  180,  177,  193,  170,
			  199,  178,  181,  191,  172,  194,  196,  185,  169,  179,
			  186,  182,  171,  195,  197,  175,  199,  176,  187,  183,
			  184,  180,  177,  194,  188,  191,  178,  181,  198,  200,
			  193,  195,  185,  208,  201,  186,  182,  196,  202,  205,
			  197,  199,  206,  187,  183,  184,  207,  209,  194,  188,
			  191,  201,  198,  166,  160,  193,  195,  158,  144,  208,
			  200,  142,  196,  141,  207,  197,  134,  132,  205,  131,
			  202,  206,  126,  116,  113,  103,  201,  198,  209,   93,
			   85,   82,   74,   63,  208,  200,   61,   60,   48,  207,

			   36,   35,   34,  205,   17,  202,  206,   13,    8,    6,
			    3,    0,    0,  209,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  610,  614,   65,  606,  614,  602,  614,
			  614,  614,  614,  601,  614,  614,  614,  590,   62,   64,
			   65,   66,   68,   67,   70,   71,   72,   73,   91,   77,
			   75,  123,   76,   83,  599,  589,  594,  128,  144,   84,
			   82,  124,  140,  153,  136,  116,  132,  157,  592,  158,
			  143,  176,  171,  159,  163,  191,  156,  178,  186,  146,
			  593,  584,  194,  587,  204,  198,  200,  210,  211,  216,
			  219,  203,  195,  226,  586,  232,  234,  236,  225,  235,
			  223,  238,  585,  239,  240,  586,  241,  246,  258,  262,
			  260,  264,  257,  583,  242,  270,  268,  272,  278,  297,

			  301,  283,  306,  579,  312,  300,  303,  308,  309,   74,
			  310,  311,  336,  578,  313,  328,  577,  332,  321,  337,
			  334,  338,  357,  344,  353,  348,  576,  349,  359,  370,
			  361,  573,  571,  374,  570,  380,  384,  381,  372,  377,
			  376,  567,  565,  382,  562,  405,  383,  389,  392,  412,
			  393,  396,  413,  418,  416,  419,  421,  428,  561,  436,
			  558,  429,  438,  430,  439,  443,  557,  451,  437,  458,
			  503,  462,  467,  285,  450,  463,  464,  470,  474,  475,
			  476,  485,  486,  488,  489,  492,  497,  495,  499,  267,
			  169,  507,  161,  502,  509,  517,  510,  518,  532,  504,

			  533,  538,  542,  107,   99,  543,  546,  550,  537,  551,
			   88,  614,  101,   83>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  211,    1,  211,  211,  211,  211,  211,  212,  211,
			  211,  211,  211,  212,  211,  211,  211,  213,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  211,  211,  211,  212,  213,  213,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  211,  211,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  211,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,

			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,

			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,    0,  211,  211>>)
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
			    0,    0,    0,   46,   44,    1,    2,   11,    8,    4,
			    5,    7,    6,   43,    3,    9,   10,   41,   43,   13,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			   43,   43,   43,    1,    2,    0,   43,   42,   41,   43,
			   43,   43,   43,   43,   43,   43,   43,   43,   25,   43,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			    0,    0,   43,   16,   43,   43,   43,   43,   43,   20,
			   43,   43,   43,   43,   27,   43,   43,   43,   43,   43,
			   43,   43,   40,   43,   43,    0,   43,   43,   43,   43,
			   43,   43,   43,   22,   43,   43,   43,   43,   43,   43,

			   43,   43,   43,   38,   43,   43,   43,   43,   43,   43,
			   43,   43,   43,   23,   43,   43,   28,   43,   43,   43,
			   43,   43,   43,   43,   43,   43,   12,   43,   43,   43,
			   43,   19,   21,   43,   26,   43,   43,   43,   43,   43,
			   35,   37,   34,   43,   17,   43,   43,   43,   43,   43,
			   43,   43,   43,   43,   43,   43,   43,   43,   18,   43,
			   29,   43,   43,   43,   43,   43,   39,   43,   43,   43,
			   30,   43,   43,   33,   43,   43,   43,   43,   43,   43,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   24,
			   31,   43,   36,   43,   43,   43,   43,   43,   43,   43,

			   43,   43,   43,   14,   32,   43,   43,   43,   43,   43,
			   15,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 614
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 211
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 212
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

	yyNb_rules: INTEGER is 45
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 46
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
