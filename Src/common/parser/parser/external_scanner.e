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
				last_token := TE_ID
			
when 40 then
--|#line 194

				current_position.go_to (1)
			
when 41 then
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
			   13,   18,   19,   20,   21,   22,   13,   23,   24,   13,
			   25,   13,   26,   13,   13,   27,   28,   29,   13,   13,
			   13,    4,    4,   13,   17,   13,   18,   19,   20,   21,
			   22,   13,   23,   24,   13,   25,   13,   26,   13,   13,
			   27,   28,   29,   13,   13,   13,   30,   32,   30,   32,
			   32,   32,   32,   32,   35,   32,   32,   32,   32,   32,
			   32,   30,   34,   30,   33,   32,   32,   38,   32,   42,
			   46,   32,   32,   39,   41,   32,   40,   36,   43,   32,

			   44,   54,   32,   32,   32,   47,   37,   34,   45,   52,
			   32,   32,   38,   51,   42,   46,   48,   32,   39,   41,
			   49,   40,   36,   43,   57,   44,   54,   32,   56,   50,
			   47,   32,   55,   45,   52,   59,   58,   32,   51,   32,
			   60,   48,   32,   32,   32,   49,   32,   32,   63,   57,
			   32,   32,   32,   56,   50,   32,   32,   32,   32,   67,
			   59,   58,   61,   32,   68,   60,   65,   32,   62,   32,
			   66,   70,   64,   63,   74,   32,   76,   32,   32,   78,
			   69,   77,   73,   32,   67,   32,   75,   61,   71,   68,
			   83,   65,   32,   62,   79,   66,   70,   64,   32,   74,

			   80,   76,   82,   72,   78,   69,   77,   73,   32,   32,
			   32,   75,   32,   71,   32,   83,   32,   32,   81,   79,
			   32,   32,   32,   32,   32,   80,   86,   82,   72,   84,
			   85,   32,   32,   92,   32,   32,   87,   89,   32,   32,
			   32,   32,   99,   81,   90,   32,   95,   88,   91,   93,
			   32,   86,   94,   32,   96,   85,  100,  102,   92,   97,
			  109,   87,   89,   32,   98,  101,  104,   99,   32,   90,
			   32,   95,   32,   91,   93,   32,  103,   94,  110,   96,
			   32,  100,  102,  108,   97,  109,  105,   32,   32,   98,
			  101,  104,   32,   32,   32,  106,   32,  107,  112,   32,

			  114,  103,   32,  110,  111,   32,   32,   32,  108,  113,
			  116,  105,   32,   32,   32,  115,  119,  117,   32,   32,
			  106,   32,  107,  112,  118,  114,  121,  125,   32,  111,
			   32,   32,  120,   32,  113,  116,  123,  124,  130,  128,
			  115,  119,  117,  126,   32,   32,  122,  127,  133,  118,
			   32,  121,  125,   32,  129,   32,  131,  120,  135,  132,
			   32,  123,  124,  130,  128,   32,   32,   32,  126,  140,
			  134,  122,  127,  133,   32,   32,   32,  138,   32,  129,
			   32,  131,   32,  135,  132,   32,  136,  137,   32,   32,
			  143,   32,   32,  141,  140,  134,  139,   32,   32,  153,

			  147,  144,  138,  142,   32,  150,  145,  151,  146,  152,
			   32,  136,   32,   32,   32,  143,   32,   32,  141,  155,
			   32,  139,  148,   32,  153,  147,  144,  149,  142,  154,
			  150,  145,  151,  146,  152,  156,   32,  161,  157,   32,
			  162,  158,   32,   32,  155,  159,  164,  148,   32,   32,
			   32,  160,  149,   32,  154,   32,   32,   32,   32,   32,
			  156,   32,  161,  157,   32,  162,  158,   32,  168,  165,
			  159,  164,  167,  163,  172,  173,  160,   32,  169,   32,
			  166,   32,  176,  174,  178,   32,  175,  170,   32,  171,
			   32,   32,   32,  168,  165,  177,  179,  167,  163,  172,

			  173,   32,  181,  169,  182,  183,   32,  176,  174,  178,
			   32,  175,  170,   32,  171,  180,   32,  185,  184,   32,
			  177,  179,  186,   32,   32,   32,   32,  181,   32,  182,
			  183,   32,   32,  189,  187,   33,   32,   32,  188,   53,
			  180,   31,  185,  184,  190,   32,   32,  186,   31,  192,
			  192,  192,  192,  191,  192,  192,  192,  192,  189,  187,
			  192,  192,  192,  188,  192,  192,  192,  192,  192,  190,
			  192,  192,  192,  192,  192,  192,  192,  192,  191,    3,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,

			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192>>)
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
			    1,    1,    1,    1,    1,    1,    5,   17,    5,   18,
			   19,   20,   22,   21,   18,   23,   24,   25,   26,   28,
			   29,   30,   17,   30,  193,  191,   34,   19,  185,   22,
			   25,  184,  173,   19,   21,  171,   20,   18,   23,   27,

			   23,   34,  170,   37,  154,   26,   18,   17,   24,   29,
			  151,   36,   19,   28,   22,   25,   27,   38,   19,   21,
			   27,   20,   18,   23,   37,   23,   34,   35,   36,   27,
			   26,   41,   35,   24,   29,   38,   37,   40,   28,   39,
			   38,   27,   42,   44,   46,   27,   45,   47,   41,   37,
			   48,  142,   49,   36,   27,   51,   57,   52,   58,   46,
			   38,   37,   39,   56,   47,   38,   44,   63,   40,   54,
			   45,   49,   42,   41,   52,   50,   56,   59,   62,   58,
			   48,   57,   51,   60,   46,   61,   54,   39,   50,   47,
			   63,   44,   64,   40,   59,   45,   49,   42,   67,   52,

			   60,   56,   62,   50,   58,   48,   57,   51,   68,   65,
			   69,   54,   70,   50,   71,   63,   73,   72,   61,   59,
			   75,   81,   76,   77,   78,   60,   67,   62,   50,   64,
			   65,   79,   85,   73,   80,  140,   68,   70,   84,   90,
			   83,  127,   81,   61,   71,  126,   77,   69,   72,   75,
			   86,   67,   76,   87,   78,   65,   83,   85,   73,   79,
			   90,   68,   70,   91,   80,   84,   87,   81,   88,   71,
			   89,   77,   94,   72,   75,   93,   86,   76,   91,   78,
			   96,   83,   85,   89,   79,   90,   88,   97,   95,   80,
			   84,   87,   99,   98,  119,   88,  101,   88,   94,  102,

			   96,   86,  104,   91,   93,  105,  107,  108,   89,   95,
			   98,   88,  109,  110,  113,   97,  102,   99,  106,  112,
			   88,  115,   88,   94,  101,   96,  105,  109,  114,   93,
			  118,  121,  104,  120,   95,   98,  107,  108,  115,  113,
			   97,  102,   99,  110,  122,  123,  106,  112,  121,  101,
			  125,  105,  109,  130,  114,  124,  118,  104,  123,  120,
			  128,  107,  108,  115,  113,  129,  131,  133,  110,  130,
			  122,  106,  112,  121,  134,  132,  135,  128,  145,  114,
			  136,  118,  137,  123,  120,  117,  124,  125,  141,  138,
			  133,  143,  144,  131,  130,  122,  129,  139,  147,  145,

			  137,  134,  128,  132,  116,  141,  135,  143,  136,  144,
			  156,  124,  146,  150,  148,  133,  158,  152,  131,  147,
			  155,  129,  138,  149,  145,  137,  134,  139,  132,  146,
			  141,  135,  143,  136,  144,  148,  153,  155,  149,  159,
			  156,  150,  157,  160,  147,  152,  158,  138,  162,  161,
			  163,  153,  139,  164,  146,  165,  166,  168,  169,  167,
			  148,  172,  155,  149,  174,  156,  150,  175,  162,  159,
			  152,  158,  161,  157,  166,  167,  153,  178,  163,  176,
			  160,  179,  172,  168,  175,  177,  169,  164,  181,  165,
			  180,  183,  111,  162,  159,  174,  176,  161,  157,  166,

			  167,  182,  178,  163,  179,  180,  186,  172,  168,  175,
			  187,  169,  164,  103,  165,  177,  188,  182,  181,  189,
			  174,  176,  183,  190,  100,   92,   82,  178,   74,  179,
			  180,   66,   55,  188,  186,   53,   43,   33,  187,   32,
			  177,   31,  182,  181,  189,   13,    8,  183,    6,    3,
			    0,    0,    0,  190,    0,    0,    0,    0,  188,  186,
			    0,    0,    0,  187,    0,    0,    0,    0,    0,  189,
			    0,    0,    0,    0,    0,    0,    0,    0,  190,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,

			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  549,  579,   64,  545,  579,  540,  579,
			  579,  579,  579,  539,  579,  579,  579,   61,   63,   64,
			   65,   67,   66,   69,   70,   71,   72,   93,   73,   74,
			   79,  538,  527,  531,   80,  121,  105,   97,  111,  133,
			  131,  125,  136,  530,  137,  140,  138,  141,  144,  146,
			  169,  149,  151,  531,  163,  526,  157,  150,  152,  171,
			  177,  179,  172,  161,  186,  203,  525,  192,  202,  204,
			  206,  208,  211,  210,  522,  214,  216,  217,  218,  225,
			  228,  215,  520,  234,  232,  226,  244,  247,  262,  264,
			  233,  257,  519,  269,  266,  282,  274,  281,  287,  286,

			  518,  290,  293,  507,  296,  299,  312,  300,  301,  306,
			  307,  486,  313,  308,  322,  315,  398,  379,  324,  288,
			  327,  325,  338,  339,  349,  344,  239,  235,  354,  359,
			  347,  360,  369,  361,  368,  370,  374,  376,  383,  391,
			  229,  382,  145,  385,  386,  372,  406,  392,  408,  417,
			  407,  104,  411,  430,   98,  414,  404,  436,  410,  433,
			  437,  443,  442,  444,  447,  449,  450,  453,  451,  452,
			   96,   89,  455,   86,  458,  461,  473,  479,  471,  475,
			  484,  482,  495,  485,   85,   82,  500,  504,  510,  513,
			  517,   79,  579,   82>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  192,    1,  192,  192,  192,  192,  192,  193,  192,
			  192,  192,  192,  193,  192,  192,  192,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  192,  192,  192,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  192,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,

			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,    0,  192>>)
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
			   16,   17,   18,    1,    1,   19,   20,   21,   22,   23,
			   24,   25,   26,   27,   28,   20,   29,   30,   31,   32,
			   33,   20,   34,   35,   36,   37,   38,   39,   20,   40,
			   20,   41,    1,   42,    1,   43,    1,   44,   45,   46,

			   47,   48,   49,   50,   51,   52,   53,   45,   54,   55,
			   56,   57,   58,   45,   59,   60,   61,   62,   63,   64,
			   45,   65,   45,    1,    1,    1,    1,    1,    1,    1,
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
			    0,    1,    1,    1,    1,    1,    2,    2,    1,    1,
			    1,    2,    1,    2,    2,    1,    1,    2,    1,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   42,   40,    1,    2,   11,    8,    4,
			    5,    7,    6,   39,    3,    9,   10,   39,   13,   39,
			   39,   39,   39,   39,   39,   39,   39,   39,   39,   39,
			    1,    2,    0,   39,   39,   39,   39,   39,   39,   39,
			   39,   39,   39,   25,   39,   39,   39,   39,   39,   39,
			   39,   39,   39,    0,   39,   16,   39,   39,   39,   39,
			   39,   20,   39,   39,   39,   39,   27,   39,   39,   39,
			   39,   39,   39,   39,   38,   39,   39,   39,   39,   39,
			   39,   39,   22,   39,   39,   39,   39,   39,   39,   39,
			   39,   39,   37,   39,   39,   39,   39,   39,   39,   39,

			   23,   39,   39,   28,   39,   39,   39,   39,   39,   39,
			   39,   12,   39,   39,   39,   39,   19,   21,   39,   26,
			   39,   39,   39,   39,   39,   34,   36,   17,   39,   39,
			   39,   39,   39,   39,   39,   39,   39,   39,   39,   39,
			   18,   39,   29,   39,   39,   39,   39,   39,   39,   39,
			   39,   30,   39,   39,   33,   39,   39,   39,   39,   39,
			   39,   39,   39,   39,   39,   39,   39,   39,   39,   39,
			   24,   31,   39,   35,   39,   39,   39,   39,   39,   39,
			   39,   39,   39,   39,   14,   32,   39,   39,   39,   39,
			   39,   15,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 579
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 192
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 193
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

	yyNb_rules: INTEGER is 41
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 42
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
