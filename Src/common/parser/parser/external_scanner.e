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

					-- To escape external keywords.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				token_buffer.remove_head (1)
				last_token := TE_ID
			
when 43 then
--|#line 214

					-- Traditional identifier
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 44 then
--|#line 221

					-- Special identifier for include files that specifies
					-- a path, e.g. <sys/timeb.h>
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_INCLUDE_ID
			
when 45 then
--|#line 230

				current_position.go_to (1)
			
when 46 then
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
			   11,    4,   12,    4,    4,   13,   14,   15,    4,   16,
			   17,   18,   13,   19,   20,   21,   22,   23,   13,   24,
			   25,   13,   26,   13,   27,   13,   13,   28,   29,   30,
			   13,   13,   13,    4,    4,   13,   18,   13,   19,   20,
			   21,   22,   23,   13,   24,   25,   13,   26,   13,   27,
			   13,   13,   31,   29,   32,   13,   13,   13,   33,   35,
			   33,   35,   35,   35,   35,   35,   62,   37,   41,   37,
			   37,   37,   37,   37,   35,   38,   35,   35,   35,   40,
			   35,   62,   37,   44,   37,   37,   37,   38,   37,   45,

			   35,   35,   46,   42,   33,   48,   33,   47,   37,   37,
			   36,   36,   43,   49,   40,   50,   52,   35,   44,   53,
			  109,   51,   88,   36,   45,   37,   35,   46,   42,   35,
			   48,   35,   47,   61,   37,   35,   57,   37,   49,   37,
			   50,   52,   34,   37,   53,   54,   51,   35,   58,   55,
			   54,   39,   63,   34,   55,   37,  215,   38,   56,   38,
			   58,   57,  215,   56,   38,  215,  215,  215,   35,  215,
			   54,  215,   35,   58,   55,   54,   37,   65,  215,   59,
			   37,   60,  215,   56,   35,   58,   63,   66,   56,   38,
			   38,   38,   37,   38,   35,   39,   35,   35,   38,   35,

			   35,   64,   37,   35,   37,   37,   35,   37,   37,  215,
			   35,   37,   66,  215,   37,  215,   69,   67,   37,   73,
			   35,   70,   71,   38,   38,   35,   64,  215,   37,   68,
			   35,   75,   72,   37,  215,   74,   76,   77,   37,  215,
			   35,   69,   67,   35,   73,   35,   70,   71,   37,   78,
			   35,   37,  215,   37,   68,   35,   75,   72,   37,   35,
			   74,   76,   77,   37,   80,   81,   80,   37,   35,   35,
			  215,   35,   79,  215,   78,   35,   37,   37,   84,   37,
			   82,   86,  215,   37,   83,   35,   90,   87,   89,   80,
			   81,   85,   62,   37,   62,   37,   35,   79,   35,   62,

			  215,  215,   91,   84,   37,   82,   37,  215,   92,   83,
			   35,   90,   35,   89,   35,   93,  215,   94,   37,  215,
			   37,   35,   37,   35,   62,   62,   35,   91,   35,   37,
			  215,   37,  215,   92,   37,   35,   37,  215,   96,   97,
			   93,   35,   94,   37,   35,   95,   99,   35,   35,   37,
			  215,   35,   37,   35,   35,   37,   37,  215,  100,   37,
			   98,   37,   37,   96,   97,  101,  215,   35,  215,   35,
			   95,   99,  106,  215,  103,   37,  104,   37,   35,   35,
			  102,  105,  215,  100,   35,   35,   37,   37,   35,  215,
			  101,  215,   37,   37,  103,   35,   37,  106,  215,  103,

			  110,  104,  108,   37,  112,   35,  105,  215,  215,   35,
			  111,  215,  215,   37,  215,  114,  113,   37,  116,  107,
			  115,  215,   35,   35,   35,  110,   35,  117,   35,  112,
			   37,   37,   37,  215,   37,  111,   37,  215,   35,  121,
			  114,  113,  215,  116,  215,  115,   37,   35,  122,  215,
			  119,  118,  117,  125,  120,   37,  215,  123,   35,  124,
			   35,   35,  215,   35,  121,  215,   37,  215,   37,   37,
			  126,   37,   35,  122,  215,  119,  118,  127,  125,  120,
			   37,   35,  123,   35,  124,   35,  215,  125,   35,   37,
			   35,   37,   35,   37,  130,  126,   37,   35,   37,  215,

			   37,  215,  127,  215,  215,   37,  132,  129,  215,  131,
			  133,  135,  125,   35,   35,  134,  128,  136,   35,  130,
			   35,   37,   37,  215,   35,  215,   37,  215,   37,   35,
			   35,  132,   37,  138,  131,  133,  135,   37,   37,  215,
			  134,   35,  136,  137,  215,  215,   35,  140,   35,   37,
			  215,  215,  139,   35,   37,  215,   37,   35,  138,  141,
			  215,   37,  142,  144,  215,   37,   35,   35,  137,  215,
			   35,   35,  140,  143,   37,   37,  215,  139,   37,   37,
			  145,   35,   35,   35,  141,   35,   35,  142,  144,   37,
			   37,   37,   35,   37,   37,   35,  146,  148,  143,  150,

			   37,  151,   35,   37,   35,  145,  215,   35,  149,  147,
			   37,  215,   37,  152,  154,   37,  215,   35,  215,  156,
			  153,   35,  148,   35,  150,   37,  151,   35,   35,   37,
			  155,   37,  215,  149,   35,   37,   37,  215,  152,  154,
			  157,   35,   37,   35,  156,  153,   35,  215,  215,   37,
			   35,   37,   35,  160,   37,  155,  158,  215,   37,   35,
			   37,  162,   35,  215,   35,  157,  215,   37,   35,  215,
			   37,  159,   37,   35,  161,  163,   37,  165,  160,   35,
			  164,   37,   35,   35,  169,   35,  162,   37,  166,   35,
			   37,   37,  215,   37,  167,  215,  215,   37,  168,  161,

			  163,  215,  165,   35,  173,  164,  215,  215,  215,  169,
			   35,   37,   35,  166,  171,  172,  170,   35,   37,  167,
			   37,  174,   35,  168,   35,   37,   35,   35,  215,  173,
			   37,  175,   37,  176,   37,   37,  177,  215,  215,  171,
			  172,  215,   35,   35,  180,  178,  174,   35,  215,  179,
			   37,   37,   35,  215,   35,   37,  175,   35,  176,   35,
			   37,  177,   37,  215,  215,   37,  215,   37,  215,  180,
			  178,  183,  181,   35,  179,   35,  184,  182,   35,   35,
			   35,   37,   35,   37,   35,   35,   37,   37,   37,  215,
			   37,  185,   37,   37,  215,   35,  183,  181,  215,  215,

			   35,  184,  182,   37,  191,  190,  186,  187,   37,   35,
			  188,   35,  215,  215,  192,  195,  185,   37,  189,   37,
			   35,  193,  215,  215,  215,   35,   35,  196,   37,  191,
			  190,  186,  187,   37,   37,  188,  194,   35,  215,  192,
			  195,  198,   35,   35,  215,   37,  193,  215,  197,   35,
			   37,   37,  196,  215,   35,   35,   35,   37,  215,   35,
			  199,  194,   37,   37,   37,  215,  198,   37,  201,   35,
			   35,   35,   35,  197,  202,  215,  200,   37,   37,   37,
			   37,   35,  215,  204,  205,  199,  203,  206,   35,   37,
			  208,  215,   35,  201,  215,  215,   37,  215,   35,  202,

			   37,  200,  209,  207,  215,   35,   37,  215,  204,  205,
			   35,  203,  206,   37,  215,  208,   35,  212,   37,  215,
			  215,   35,  210,  215,   37,  215,  215,  209,  207,   37,
			  215,  215,  215,  215,  215,  211,  215,  213,  215,  215,
			  215,  215,  212,  215,  215,  215,  215,  210,  214,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  211,  215,  213,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  214,    3,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,

			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215>>)
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
			    1,    1,    1,    1,    1,    1,    1,    1,    5,    8,
			    5,   13,   18,   19,   20,   21,  218,    8,   19,   13,
			   18,   19,   20,   21,   22,  217,   23,   25,   24,   18,
			   27,  109,   22,   20,   23,   25,   24,   88,   27,   20,

			   29,   26,   21,   19,   33,   23,   33,   22,   29,   26,
			  216,  216,   19,   24,   18,   24,   26,   30,   20,   27,
			   87,   25,   63,   61,   20,   30,   28,   21,   19,   32,
			   23,   31,   22,   35,   28,   36,   29,   32,   24,   31,
			   24,   26,   34,   36,   27,   28,   25,   49,   30,   28,
			   31,   17,   38,    6,   31,   49,    3,   38,   28,   38,
			   32,   29,    0,   31,   38,    0,    0,    0,   42,    0,
			   28,    0,   41,   30,   28,   31,   42,   41,    0,   31,
			   41,   32,    0,   28,   40,   32,   39,   42,   31,   38,
			   38,   39,   40,   39,   43,   39,   44,   45,   39,   46,

			   47,   40,   43,   48,   44,   45,   50,   46,   47,    0,
			   51,   48,   42,    0,   50,    0,   44,   43,   51,   47,
			   52,   44,   45,   39,   39,   60,   40,    0,   52,   43,
			   53,   50,   46,   60,    0,   48,   51,   52,   53,    0,
			   54,   44,   43,   55,   47,   59,   44,   45,   54,   53,
			   56,   55,    0,   59,   43,   57,   50,   46,   56,   58,
			   48,   51,   52,   57,   55,   56,   59,   58,   65,   64,
			    0,   66,   54,    0,   53,   67,   65,   64,   58,   66,
			   56,   60,    0,   67,   57,   68,   66,   62,   64,   55,
			   56,   59,   62,   68,   62,   62,   69,   54,   70,   62,

			    0,    0,   67,   58,   69,   56,   70,    0,   68,   57,
			   71,   66,   72,   64,   73,   69,    0,   70,   71,    0,
			   72,   74,   73,   75,   62,   62,   76,   67,   77,   74,
			    0,   75,    0,   68,   76,   78,   77,    0,   72,   73,
			   69,   79,   70,   78,   81,   71,   75,   80,   82,   79,
			    0,   84,   81,   83,   86,   80,   82,    0,   77,   84,
			   74,   83,   86,   72,   73,   78,    0,   85,    0,   89,
			   71,   75,   83,    0,   80,   85,   81,   89,   90,   91,
			   79,   82,    0,   77,   92,   93,   90,   91,   94,    0,
			   78,    0,   92,   93,   85,   95,   94,   83,    0,   80,

			   89,   81,   86,   95,   91,   96,   82,    0,    0,   97,
			   90,    0,    0,   96,    0,   93,   92,   97,   95,   85,
			   94,    0,   98,   99,  101,   89,  100,   97,  102,   91,
			   98,   99,  101,    0,  100,   90,  102,    0,  103,  101,
			   93,   92,    0,   95,    0,   94,  103,  104,  102,    0,
			   99,   98,   97,  103,  100,  104,    0,  102,  106,  102,
			  105,  108,    0,  110,  101,    0,  106,    0,  105,  108,
			  104,  110,  107,  102,    0,   99,   98,  105,  103,  100,
			  107,  111,  102,  112,  102,  114,    0,  107,  113,  111,
			  116,  112,  115,  114,  110,  104,  113,  117,  116,    0,

			  115,    0,  105,    0,    0,  117,  112,  108,    0,  111,
			  113,  115,  107,  118,  119,  114,  107,  116,  120,  110,
			  121,  118,  119,    0,  122,    0,  120,    0,  121,  123,
			  124,  112,  122,  119,  111,  113,  115,  123,  124,    0,
			  114,  125,  116,  118,    0,    0,  126,  122,  127,  125,
			    0,    0,  121,  128,  126,    0,  127,  129,  119,  123,
			    0,  128,  124,  126,    0,  129,  130,  131,  118,    0,
			  135,  133,  122,  125,  130,  131,    0,  121,  135,  133,
			  127,  132,  134,  136,  123,  137,  138,  124,  126,  132,
			  134,  136,  139,  137,  138,  140,  128,  131,  125,  133,

			  139,  134,  141,  140,  142,  127,    0,  143,  132,  129,
			  141,    0,  142,  137,  140,  143,    0,  144,    0,  142,
			  139,  145,  131,  146,  133,  144,  134,  147,  148,  145,
			  141,  146,    0,  132,  149,  147,  148,    0,  137,  140,
			  143,  150,  149,  151,  142,  139,  152,    0,    0,  150,
			  153,  151,  154,  149,  152,  141,  144,    0,  153,  155,
			  154,  151,  156,    0,  158,  143,    0,  155,  157,    0,
			  156,  147,  158,  159,  150,  152,  157,  154,  149,  160,
			  153,  159,  162,  161,  158,  163,  151,  160,  155,  164,
			  162,  161,    0,  163,  156,    0,    0,  164,  157,  150,

			  152,    0,  154,  165,  163,  153,    0,    0,    0,  158,
			  167,  165,  166,  155,  160,  161,  159,  168,  167,  156,
			  166,  165,  169,  157,  170,  168,  171,  172,    0,  163,
			  169,  166,  170,  167,  171,  172,  168,    0,    0,  160,
			  161,    0,  173,  174,  172,  169,  165,  175,    0,  171,
			  173,  174,  177,    0,  176,  175,  166,  178,  167,  179,
			  177,  168,  176,    0,    0,  178,    0,  179,    0,  172,
			  169,  176,  173,  180,  171,  181,  178,  175,  182,  183,
			  184,  180,  185,  181,  186,  187,  182,  183,  184,    0,
			  185,  179,  186,  187,    0,  189,  176,  173,    0,    0,

			  188,  178,  175,  189,  185,  184,  180,  181,  188,  190,
			  182,  192,    0,    0,  186,  189,  179,  190,  183,  192,
			  191,  187,    0,    0,    0,  193,  194,  190,  191,  185,
			  184,  180,  181,  193,  194,  182,  188,  195,    0,  186,
			  189,  192,  196,  197,    0,  195,  187,    0,  191,  198,
			  196,  197,  190,    0,  200,  199,  201,  198,    0,  202,
			  195,  188,  200,  199,  201,    0,  192,  202,  198,  206,
			  203,  204,  205,  191,  199,    0,  197,  206,  203,  204,
			  205,  207,    0,  201,  202,  195,  200,  203,  208,  207,
			  205,    0,  209,  198,    0,    0,  208,    0,  211,  199,

			  209,  197,  206,  204,    0,  210,  211,    0,  201,  202,
			  212,  200,  203,  210,    0,  205,  213,  211,  212,    0,
			    0,  214,  209,    0,  213,    0,    0,  206,  204,  214,
			    0,    0,    0,    0,    0,  210,    0,  212,    0,    0,
			    0,    0,  211,    0,    0,    0,    0,  209,  213,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  210,    0,  212,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  213,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,

			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  156,  974,   66,  150,  974,   63,  974,
			  974,  974,  974,   65,  974,  974,  974,  136,   66,   67,
			   68,   69,   78,   80,   82,   81,   95,   84,  120,   94,
			  111,  125,  123,  102,  139,  121,  129,    0,  146,  180,
			  178,  166,  162,  188,  190,  191,  193,  194,  197,  141,
			  200,  204,  214,  224,  234,  237,  244,  249,  253,  239,
			  219,  119,  281,  110,  263,  262,  265,  269,  279,  290,
			  292,  304,  306,  308,  315,  317,  320,  322,  329,  335,
			  341,  338,  342,  347,  345,  361,  348,  108,   93,  363,
			  372,  373,  378,  379,  382,  389,  399,  403,  416,  417,

			  420,  418,  422,  432,  441,  454,  452,  466,  455,   87,
			  457,  475,  477,  482,  479,  486,  484,  491,  507,  508,
			  512,  514,  518,  523,  524,  535,  540,  542,  547,  551,
			  560,  561,  575,  565,  576,  564,  577,  579,  580,  586,
			  589,  596,  598,  601,  611,  615,  617,  621,  622,  628,
			  635,  637,  640,  644,  646,  653,  656,  662,  658,  667,
			  673,  677,  676,  679,  683,  697,  706,  704,  711,  716,
			  718,  720,  721,  736,  737,  741,  748,  746,  751,  753,
			  767,  769,  772,  773,  774,  776,  778,  779,  794,  789,
			  803,  814,  805,  819,  820,  831,  836,  837,  843,  849,

			  848,  850,  853,  864,  865,  866,  863,  875,  882,  886,
			  899,  892,  904,  910,  915,  974,  108,   82,   73>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  215,    1,  215,  215,  215,  215,  215,  216,  215,
			  215,  215,  215,  216,  215,  215,  215,  217,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  215,  215,  215,  216,  218,  217,  217,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  215,  218,  215,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  215,  215,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,

			  216,  216,  216,  216,  216,  216,  216,  216,  216,  215,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,

			  216,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,    0,  215,  215,  215>>)
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
			   26,   27,   28,   29,   30,   22,   31,   32,   33,   34,
			   35,   22,   36,   37,   38,   39,   40,   41,   22,   42,
			   22,   43,    1,   44,    1,   45,    1,   46,   47,   48,

			   49,   50,   51,   52,   53,   54,   55,   47,   56,   57,
			   58,   59,   60,   47,   61,   62,   63,   64,   65,   66,
			   47,   67,   47,    1,    1,    1,    1,    1,    1,    1,
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
			    3,    3,    3,    2,    2,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   47,   45,    1,    2,   11,    8,    4,
			    5,    7,    6,   43,    3,    9,   10,   41,   43,   13,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			   43,   43,   43,    1,    2,    0,   43,    0,   42,   41,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   25,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			   43,    0,   44,    0,   43,   16,   43,   43,   43,   43,
			   43,   20,   43,   43,   43,   43,   27,   43,   43,   43,
			   43,   43,   43,   43,   40,   43,   43,    0,    0,   43,
			   43,   43,   43,   43,   43,   43,   22,   43,   43,   43,

			   43,   43,   43,   43,   43,   43,   38,   43,   43,    0,
			   43,   43,   43,   43,   43,   43,   43,   23,   43,   43,
			   28,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			   12,   43,   43,   43,   43,   19,   21,   43,   26,   43,
			   43,   43,   43,   43,   35,   37,   34,   43,   17,   43,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			   43,   43,   18,   43,   29,   43,   43,   43,   43,   43,
			   39,   43,   43,   43,   30,   43,   43,   33,   43,   43,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			   43,   43,   43,   24,   31,   43,   36,   43,   43,   43,

			   43,   43,   43,   43,   43,   43,   43,   14,   32,   43,
			   43,   43,   43,   43,   15,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 974
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 215
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 216
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

	yyNb_rules: INTEGER is 46
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 47
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
