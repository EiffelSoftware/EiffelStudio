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

				current_position.go_to (6)
				last_token := TE_STATIC
			
when 35 then
--|#line 170

				current_position.go_to (12)
				last_token := TE_STATIC_FIELD
			
when 36 then
--|#line 174

				current_position.go_to (6)
				last_token := TE_STRUCT
			
when 37 then
--|#line 178

				current_position.go_to (4)
				last_token := TE_TYPE
			
when 38 then
--|#line 182

				current_position.go_to (3)
				last_token := TE_USE
			
when 39 then
--|#line 188

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				token_buffer.remove_head (1)
				last_token := TE_ID
			
when 40 then
--|#line 196

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 41 then
--|#line 202

				current_position.go_to (1)
			
when 42 then
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
			   13,   28,   29,   30,   13,   13,   13,   31,   33,   31,
			   33,   33,   33,   33,   33,   37,   33,   33,   33,   33,
			   31,   33,   31,   33,   36,   33,   35,   33,   33,   40,
			   58,   44,   48,   34,   34,   41,   43,   33,   42,   38,

			   45,   33,   46,   33,   57,   59,   33,   49,   39,   36,
			   47,   54,   33,   33,   40,   50,   44,   48,   53,   51,
			   41,   43,   33,   42,   38,   45,   56,   46,   52,   57,
			   59,   35,   49,   35,   60,   47,   54,   35,   33,   33,
			   50,   33,   33,   53,   51,   65,   61,   33,   33,   33,
			   33,   33,   33,   52,   33,   33,   66,   33,   33,   60,
			   62,   33,   35,   35,   69,   63,   64,   70,   71,   74,
			   65,   61,   68,   33,   73,   77,   33,   33,   67,   79,
			   72,   66,   33,   33,   75,   62,   76,   80,   33,   69,
			   63,   64,   70,   71,   74,   83,   33,   68,   33,   73,

			   77,   84,   81,   67,   79,   72,   33,   33,   33,   75,
			   82,   76,   80,   33,   33,   33,   85,   33,   33,   33,
			   83,   86,   87,   33,   33,   33,   84,   81,   33,   89,
			   33,   33,   33,   96,   33,   82,   33,   90,   33,   33,
			   33,   85,   91,   93,   88,   33,   86,   87,   33,   94,
			  114,   95,   92,   97,   89,   98,   99,  104,   96,  100,
			  101,  102,   90,   33,  105,  106,   33,   91,   93,   33,
			  103,   33,  107,   33,   94,  114,   95,  108,   97,   33,
			   98,   99,  104,  112,  100,  101,  102,   33,  113,  105,
			  106,   33,  109,   33,   33,  103,   33,  107,  116,   33,

			   33,  110,  108,  111,   33,   33,   33,   33,  112,  115,
			   33,   33,  118,  113,  120,  117,  119,  109,   33,   33,
			  121,   33,  123,  116,   33,   33,  110,  125,  111,  122,
			  124,   33,   33,   33,  115,  126,  132,  118,  127,  120,
			  117,  119,  128,  134,   33,  121,  133,  123,  129,  130,
			  131,  135,  125,   33,  122,  124,   33,   33,  136,   33,
			  126,  132,  137,  127,   33,  140,   33,  128,  134,   33,
			  139,  133,   33,  129,  130,  131,  135,   33,   33,   33,
			  138,   33,  142,  136,   33,   33,  144,  137,   33,  143,
			  140,   33,   33,   33,  145,  139,   33,  141,  151,   33,

			   33,  146,  147,   33,   33,  138,   33,  142,  149,  148,
			  154,  144,   33,  150,  143,  157,  153,  155,  159,  145,
			  161,  156,  152,  151,  158,   33,  146,  147,   33,   33,
			  165,   33,   33,  149,  148,  154,   33,  170,  150,   33,
			  157,  153,  155,  159,   33,  161,  156,  152,  164,  158,
			  160,   33,   33,   33,  162,  165,   33,   33,  163,   33,
			   33,   33,  166,   33,   33,  172,   33,   33,  167,   33,
			  168,   33,   33,  164,   33,  160,  171,  177,  176,  162,
			   33,  182,  169,  163,   33,  173,   33,  166,  174,  183,
			  172,  178,  175,  167,  180,  168,  179,   33,  181,   33,

			  184,  171,  177,  176,  186,  188,  182,  169,   33,   33,
			  173,   33,  185,  174,  183,  187,  178,  175,   33,  180,
			   33,  179,   33,  181,   33,  184,  189,   33,  195,  186,
			  188,   33,   33,   33,  194,   33,   33,  185,   33,   33,
			  187,   33,  193,  190,   35,   33,   33,  191,   33,  192,
			   78,  189,   34,  195,   33,   33,   55,   32,   33,  194,
			   33,   32,  196,  196,  196,  196,  196,  193,  190,  196,
			  196,  196,  191,  196,  192,    3,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,

			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196>>)
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
			   31,   30,   31,   29,   18,   37,  198,   38,   36,   20,
			   37,   23,   26,  197,  197,   20,   22,   28,   21,   19,

			   24,  195,   24,  189,   36,   38,  188,   27,   19,   18,
			   25,   30,   39,   42,   20,   28,   23,   26,   29,   28,
			   20,   22,  177,   21,   19,   24,   35,   24,   28,   36,
			   38,   35,   27,   35,   39,   25,   30,   35,   43,   47,
			   28,   40,   41,   29,   28,   42,   39,   44,   46,   50,
			   49,   48,  175,   28,   51,   52,   43,   54,   53,   39,
			   40,   57,   35,   35,   47,   40,   41,   48,   49,   52,
			   42,   39,   46,   59,   51,   54,   60,   62,   44,   57,
			   50,   43,   64,   63,   52,   40,   53,   59,   61,   47,
			   40,   41,   48,   49,   52,   62,   65,   46,   66,   51,

			   54,   63,   60,   44,   57,   50,   67,   68,   70,   52,
			   61,   53,   59,   71,   72,   76,   64,   73,   74,   75,
			   62,   65,   66,   79,   80,  174,   63,   60,   82,   68,
			   84,   83,   81,   76,   95,   61,   88,   70,  158,   89,
			   87,   64,   71,   73,   67,   90,   65,   66,   85,   74,
			   95,   75,   72,   79,   68,   80,   81,   87,   76,   82,
			   83,   84,   70,   91,   88,   89,   94,   71,   73,   93,
			   85,   98,   90,   92,   74,   95,   75,   91,   79,   97,
			   80,   81,   87,   93,   82,   83,   84,  101,   94,   88,
			   89,  100,   92,   99,  103,   85,  102,   90,   98,  108,

			  105,   92,   91,   92,  106,  109,  110,  111,   93,   97,
			  117,  112,  100,   94,  102,   99,  101,   92,  114,  118,
			  103,  116,  106,   98,  122,  119,   92,  109,   92,  105,
			  108,  124,  113,  128,   97,  110,  117,  100,  111,  102,
			   99,  101,  112,  119,  125,  103,  118,  106,  113,  114,
			  116,  122,  109,  126,  105,  108,  127,  133,  124,  129,
			  110,  117,  125,  111,  132,  128,  135,  112,  119,  134,
			  127,  118,  136,  113,  114,  116,  122,  139,  137,  141,
			  126,  138,  132,  124,  140,  143,  134,  125,  142,  133,
			  128,  155,  145,  149,  135,  127,  151,  129,  141,  164,

			  147,  136,  137,  148,  153,  126,  150,  132,  139,  138,
			  145,  134,  159,  140,  133,  149,  143,  147,  151,  135,
			  153,  148,  142,  141,  150,  154,  136,  137,  152,  156,
			  159,  160,  157,  139,  138,  145,  161,  164,  140,  162,
			  149,  143,  147,  151,  166,  153,  148,  142,  157,  150,
			  152,  163,  165,  168,  154,  159,  167,  169,  156,  170,
			  171,  146,  160,  179,  172,  166,  178,  173,  161,  181,
			  162,  180,  176,  157,  185,  152,  165,  171,  170,  154,
			  183,  179,  163,  156,  144,  167,  182,  160,  168,  180,
			  166,  172,  169,  161,  176,  162,  173,  194,  178,  184,

			  181,  165,  171,  170,  183,  185,  179,  163,  193,  186,
			  167,  187,  182,  168,  180,  184,  172,  169,  190,  176,
			  191,  173,  131,  178,  192,  181,  186,  130,  194,  183,
			  185,  123,  121,  120,  193,  115,  107,  182,  104,   96,
			  184,   86,  192,  187,   78,   77,   69,  190,   58,  191,
			   56,  186,   55,  194,   45,   34,   33,   32,   13,  193,
			    8,    6,    3,    0,    0,    0,    0,  192,  187,    0,
			    0,    0,  190,    0,  191,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,

			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  562,  575,   65,  558,  575,  554,  575,
			  575,  575,  575,  552,  575,  575,  575,    0,   62,   64,
			   65,   66,   68,   67,   70,   71,   72,   73,   91,   77,
			   75,   78,  554,  544,  549,  120,   82,   79,   81,  106,
			  135,  136,  107,  132,  141,  548,  142,  133,  145,  144,
			  143,  148,  149,  152,  151,  548,  538,  155,  542,  167,
			  170,  182,  171,  177,  176,  190,  192,  200,  201,  540,
			  202,  207,  208,  211,  212,  213,  209,  539,  540,  217,
			  218,  226,  222,  225,  224,  242,  535,  234,  230,  233,
			  239,  257,  267,  263,  260,  228,  533,  273,  265,  287,

			  285,  281,  290,  288,  532,  294,  298,  530,  293,  299,
			  300,  301,  305,  326,  312,  529,  315,  304,  313,  319,
			  527,  526,  318,  525,  325,  338,  347,  350,  327,  353,
			  521,  516,  358,  351,  363,  360,  366,  372,  375,  371,
			  378,  373,  382,  379,  478,  386,  455,  394,  397,  387,
			  400,  390,  422,  398,  419,  385,  423,  426,  232,  406,
			  425,  430,  433,  445,  393,  446,  438,  450,  447,  451,
			  453,  454,  458,  461,  219,  146,  466,  116,  460,  457,
			  465,  463,  480,  474,  493,  468,  503,  505,  100,   97,
			  512,  514,  518,  502,  491,   95,  575,   91,   83>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  196,    1,  196,  196,  196,  196,  196,  197,  196,
			  196,  196,  196,  197,  196,  196,  196,  198,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  196,  196,  196,  197,  198,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  196,  196,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  196,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,

			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,    0,  196,  196>>)
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
			    0,    0,    0,   43,   41,    1,    2,   11,    8,    4,
			    5,    7,    6,   40,    3,    9,   10,   41,   40,   13,
			   40,   40,   40,   40,   40,   40,   40,   40,   40,   40,
			   40,    1,    2,    0,   40,   39,   40,   40,   40,   40,
			   40,   40,   40,   40,   40,   25,   40,   40,   40,   40,
			   40,   40,   40,   40,   40,    0,    0,   40,   16,   40,
			   40,   40,   40,   40,   20,   40,   40,   40,   40,   27,
			   40,   40,   40,   40,   40,   40,   40,   38,    0,   40,
			   40,   40,   40,   40,   40,   40,   22,   40,   40,   40,
			   40,   40,   40,   40,   40,   40,   37,   40,   40,   40,

			   40,   40,   40,   40,   23,   40,   40,   28,   40,   40,
			   40,   40,   40,   40,   40,   12,   40,   40,   40,   40,
			   19,   21,   40,   26,   40,   40,   40,   40,   40,   34,
			   36,   17,   40,   40,   40,   40,   40,   40,   40,   40,
			   40,   40,   40,   40,   18,   40,   29,   40,   40,   40,
			   40,   40,   40,   40,   40,   30,   40,   40,   33,   40,
			   40,   40,   40,   40,   40,   40,   40,   40,   40,   40,
			   40,   40,   40,   40,   24,   31,   40,   35,   40,   40,
			   40,   40,   40,   40,   40,   40,   40,   40,   14,   32,
			   40,   40,   40,   40,   40,   15,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 575
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 196
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 197
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

	yyNb_rules: INTEGER is 42
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 43
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
