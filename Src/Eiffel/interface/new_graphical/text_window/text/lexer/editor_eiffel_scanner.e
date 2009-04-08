note
	description:"Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author:     "Arnaud PICHERY from an Eric Bezault model"
	date:       "$Date$"
	revision:   "$Revision$"

class EDITOR_EIFFEL_SCANNER

inherit

	EDITOR_SCANNER

	EDITOR_EIFFEL_SCANNER_SKELETON

create
	make

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= VERBATIM_STR1)
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
			yy_acclist := yy_acclist_template
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line 45 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 45")
end
-- Ignore carriage return
when 2 then
--|#line 46 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 46")
end

					curr_token := new_space (text_count)
					update_token_list

when 3 then
--|#line 50 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 50")
end

					if not in_comments then
						curr_token := new_tabulation (text_count)
					else
						curr_token := new_comment (text)
					end
					update_token_list

when 4 then
--|#line 58 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 58")
end

					from i_ := 1 until i_ > text_count loop
						curr_token := new_eol
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False

when 5 then
--|#line 70 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 70")
end

						-- comments
					curr_token := new_comment (text)
					in_comments := True
					update_token_list

when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line 79 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 79")
end

						-- Symbols
					if not in_comments then
						curr_token := new_text (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list

when 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38 then
--|#line 100 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 100")
end

						-- Operator Symbol
					if not in_comments then
						curr_token := new_operator (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list

when 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107 then
--|#line 132 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 132")
end

										-- Keyword
										if not in_comments then
											curr_token := new_keyword (text)
										else
											curr_token := new_comment (text)
										end
										update_token_list

when 108 then
--|#line 213 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 213")
end

										if not in_comments then
											if is_current_group_valid then
												tmp_classes := current_group.class_by_name (text, True)
												if not tmp_classes.is_empty then
													curr_token := new_class (text)
													curr_token.set_pebble (stone_of_class (tmp_classes.first))
												else
													curr_token := new_text (text)
												end
											else
												curr_token := new_text (text)
											end
										else
											curr_token := new_comment (text)
										end
										update_token_list

when 109 then
--|#line 233 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 233")
end

										if not in_comments then
											curr_token := new_text (text)
										else
											curr_token := new_comment (text)
										end
										update_token_list

when 110 then
--|#line 245 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 245")
end

										if not in_comments then
											curr_token := new_text (text)
										else
											curr_token := new_comment (text)
										end
										update_token_list

when 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132 then
--|#line 259 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 259")
end

					if not in_comments then
						curr_token := new_character (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list

when 133 then
--|#line 289 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 289")
end

					if not in_comments then
						code_ := text_substring (4, text_count - 2).to_integer
						if code_ > {CHARACTER}.Max_value then
							-- Character error. Consedered as text.
							curr_token := new_text (text)
						else
							curr_token := new_character (text)
						end
					else
						curr_token := new_comment (text)
					end
					update_token_list

when 134 then
--|#line 304 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 304")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						curr_token := new_text (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list

when 135 then
--|#line 326 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 326")
end

 				if not in_comments then
						-- Verbatim string opener.
					curr_token := new_string (text)
					update_token_list
					in_verbatim_string := True
					start_of_verbatim_string := True
					set_start_condition (VERBATIM_STR1)
				else
					curr_token := new_comment (text)
					update_token_list
				end

when 136 then
--|#line 340 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 340")
end

				if not in_comments then
						-- Verbatim string opener.
					curr_token := new_string (text)
					update_token_list
					in_verbatim_string := True
					start_of_verbatim_string := True
					set_start_condition (VERBATIM_STR1)
				else
					curr_token := new_comment (text)
					update_token_list
				end

when 137 then
--|#line 355 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 355")
end
-- Ignore carriage return
when 138 then
--|#line 356 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 356")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list

when 139 then
--|#line 365 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 365")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list

when 140 then
--|#line 374 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 374")
end

						curr_token := new_space (text_count)
						update_token_list

when 141 then
--|#line 379 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 379")
end

						curr_token := new_tabulation (text_count)
						update_token_list

when 142 then
--|#line 384 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 384")
end

						from i_ := 1 until i_ > text_count loop
							curr_token := new_eol
							update_token_list
							i_ := i_ + 1
						end

when 143 then
--|#line 392 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 392")
end

						curr_token := new_string (text)
						update_token_list

when 144, 145 then
--|#line 398 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 398")
end

					-- Eiffel String
					if not in_comments then
						curr_token := new_string (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list

when 146 then
--|#line 411 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 411")
end

					-- Eiffel Bit
					if not in_comments then
						curr_token := new_number (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list

when 147, 148, 149, 150 then
--|#line 423 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 423")
end

						-- Eiffel Integer
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list

when 151, 152, 153, 154 then
--|#line 437 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 437")
end

						-- Bad Eiffel Integer
						if not in_comments then
							curr_token := new_text (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list

when 155 then
	yy_end := yy_end - 1
--|#line 452 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 452")
end

							-- Eiffel reals & doubles
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list

when 156, 157 then
--|#line 453 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 453")
end

							-- Eiffel reals & doubles
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list

when 158 then
	yy_end := yy_end - 1
--|#line 455 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 455")
end

							-- Eiffel reals & doubles
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list

when 159, 160 then
--|#line 456 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 456")
end

							-- Eiffel reals & doubles
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list

when 161 then
--|#line 473 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 473")
end

					curr_token := new_text (text)
					update_token_list

when 162 then
--|#line 481 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 481")
end

					-- Error (considered as text)
				if not in_comments then
					curr_token := new_text (text)
				else
					curr_token := new_comment (text)
				end
				update_token_list

when 163 then
--|#line 0 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 0")
end
default_action
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0, 1 then
--|#line 0 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 0")
end
terminate
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 10021)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
			yy_nxt_template_11 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   27,   28,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   40,   41,   40,
			   40,   42,   40,   43,   44,   45,   40,   46,   47,   48,
			   49,   50,   51,   52,   40,   40,   53,   54,   55,   56,
			    6,   57,   58,   59,   60,   61,   62,   63,   64,   64,
			   65,   64,   64,   66,   64,   67,   68,   69,   64,   70,
			   71,   72,   73,   74,   75,   76,   64,   64,   77,   78,
			   79,    6,    6,    6,   80,   81,   82,   83,   84,   85,

			   86,   88,   89,   90,   91,  139,  137,  140,  140,  140,
			  140,  141,  865,   88,   89,   90,   91,  138,  760,  142,
			  144, 1060,  145,  145,  146,  146,  154,  155,  156,  157,
			  753,  107,  612,  152,  108,  159,  159,  159,  107, 1060,
			  128,  108,  128,  128,  267,  267,  267,  144,  129,  146,
			  146,  146,  146,  610,  159,  159,  608,   92,  159,  159,
			  268,  268,  151,  382,  612,  152,  269,  269,  269,   92,
			  610,  159,  228,  252,  253,  254,  255,  256,  257,  258,
			  109,  382,  143,  270,  270,  270,  165,  165,   93,  151,
			  165,  165,  608,   94,   95,   96,   97,   98,   99,  100,

			   93,  405,  405,  165,  229,   94,   95,   96,   97,   98,
			   99,  100,  110,  574,  280, 1060,  281,  281,  111,  112,
			  113,  114,  115,  116,  117,  120,  121,  122,  123,  124,
			  125,  126,  130,  131,  132,  133,  134,  135,  136,  144,
			  284,  145,  145,  146,  146,  519,  159,  159,  516,  516,
			  159,  230,  148,  149,  159,  190,  178,  382,  159,  159,
			  218,  159,  159,  159,  159,  191,  159,  159,  159,  514,
			  282,  159,  383,  383,  150,  385,  385,  385,  165,  165,
			  408,  151,  165,  231,  148,  149,  165,  192,  179,  403,
			  165,  165,  219,  165,  165,  165,  165,  193,  165,  165,

			  165,  283,  338,  165,  104,  103,  150,  159,  159,  159,
			  159,  102,  382,  101,  284,  382,  271,  159,  159,  159,
			  159,  159,  159,  160,  159,  159,  159,  159,  161,  159,
			  162,  159,  159,  159,  159,  163,  164,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  266,  159,  250,  165,
			  165,  165,  165,  165,  165,  166,  165,  165,  165,  165,
			  167,  165,  168,  165,  165,  165,  165,  169,  170,  165,
			  165,  165,  165,  165,  165,  158,  153,  374,  374,  374,
			  374,  171,  172,  173,  174,  175,  176,  177,  159,  180,
			  159,  375,  944,  181,  159,  159,  182,  236,  159,  183,

			  159,  159,  184,  194,  105,  195,  104,  237,  103,  102,
			  159,  159,  404,  404,  404,  196,  101,  376,  376, 1060,
			  165,  185,  165,  375,  944,  186,  165,  165,  187,  238,
			  165,  188,  165,  165,  189,  197,  159,  198, 1060,  239,
			  159,  200,  165,  165,  214,  201, 1060,  199,  159, 1060,
			  215, 1060,  159,  159, 1060,  159, 1060, 1060,  202, 1060,
			 1060,  159,  159,  406,  406,  406,  232, 1060,  165,  407,
			  407,  407,  165,  203,  383,  383,  216,  204, 1060,  159,
			  165,  233,  217, 1060,  165,  165, 1060,  165,  159,  220,
			  205,  159,  159,  165,  165,  159,  206, 1060,  234,  221,

			 1060,  222,  159,  207,  208,  223,  159, 1060,  159,  209,
			 1060,  165,  242,  235,  607,  240,  159, 1060, 1060,  159,
			  165,  224, 1060,  165,  165, 1060,  243,  165,  210,  159,
			 1060,  225, 1060,  226,  165,  211,  212,  227,  165,  159,
			  165,  213, 1060,  159,  244,  159,  246,  241,  165,  159,
			 1007,  165,  165,  179,  165, 1060,  159,  192,  245,  248,
			 1060,  165,  159, 1060,  165,  383,  383,  193,  165,  165,
			  165,  165,  515,  515,  515,  165,  602,  165,  247, 1060,
			 1060,  165, 1007, 1060,  165,  179,  165, 1060,  165,  192,
			 1060,  249, 1060, 1060,  165,  166,  165,  231, 1060,  193,

			  167, 1060,  168, 1060,  165,  607,  165,  169,  170,  259,
			  260,  261,  262,  263,  264,  265,  165,  259,  260,  261,
			  262,  263,  264,  265,  517,  517,  517,  166, 1060,  231,
			 1060,  197,  167,  198,  168, 1060,  165, 1060,  165,  169,
			  170, 1060, 1060,  199,  281, 1060,  281,  288,  165,  518,
			  518,  518, 1060,  259,  260,  261,  262,  263,  264,  265,
			  185, 1060,  234,  197,  186,  198, 1060,  187, 1060,  165,
			  188,  165, 1060,  189, 1060,  199, 1060,  235,  159,  159,
			  159,  165, 1060, 1060,  259,  260,  261,  262,  263,  264,
			  265, 1060,  185,  203,  234, 1060,  186,  204, 1060,  187,

			  282,  165,  188,  165,  165,  189,  165, 1060, 1060,  235,
			  205, 1060, 1060,  165, 1060, 1060,  165,  259,  260,  261,
			  262,  263,  264,  265, 1060,  203,  210, 1060, 1060,  204,
			 1060,  283,  165,  211,  212, 1060,  165, 1060,  165,  213,
			  216,  224,  205,  165,  165,  165,  217,  165,  165,  165,
			  219,  225, 1060,  226, 1060,  165, 1060,  227,  210,  165,
			  159,  159,  159,  165,  165,  211,  212, 1060,  165, 1060,
			  165,  213,  216,  224,  229,  165,  165,  165,  217,  165,
			  165,  165,  219,  225,  165,  226,  241,  165,  238,  227,
			 1060,  165,  165, 1060,  165,  165,  165,  247,  239, 1060,

			  165,  165,  165,  165,  165, 1060,  229, 1060,  244,  159,
			  159,  159,  165,  165, 1060, 1060,  165, 1060,  241,  165,
			  238,  165,  245, 1060,  165, 1060,  165, 1060,  165,  247,
			  239,  165, 1060,  165, 1060,  165,  165, 1060, 1060,  281,
			  244,  285,  281, 1060,  165,  165,  165,  249,  159,  159,
			  159,  165,  282,  165,  245,  282,  165,  289, 1060, 1060,
			  272, 1060, 1060,  165,  273,  274,  275,  276,  277,  278,
			  279, 1060,  283, 1060, 1060,  283,  165,  297,  165,  249,
			  272,  273,  274,  275,  276,  277,  278,  279,  165,  520,
			  520,  520,  521,  521,  521,  286,  305,  273,  274,  275,

			  276,  277,  278,  279,  306,  306,  306,  273,  274,  275,
			  276,  277,  278,  279,  307,  307,  338,  273,  274,  275,
			  276,  277,  278,  279,  107, 1060,  287,  108,  159,  159,
			  159,  273,  274,  275,  276,  277,  278,  279,  107, 1060,
			 1060,  108, 1060, 1060,  290,  291,  292,  293,  294,  295,
			  296,  308,  308,  308,  273,  274,  275,  276,  277,  278,
			  279,  159,  159,  159,  298,  299,  300,  301,  302,  303,
			  304,  309,  309,  309,  273,  274,  275,  276,  277,  278,
			  279,  310, 1060, 1060,  273,  274,  275,  276,  277,  278,
			  279,  107, 1060, 1060,  108,  378,  378,  378,  378,  339, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  340,  341,  342,  343,  344,  345,  159,  159,  159,  379,
			 1060,  120,  121,  122,  123,  124,  125,  126, 1060,  144,
			 1060,  380,  380,  381,  381,  120,  121,  122,  123,  124,
			  125,  126,  152,  144, 1060,  381,  381,  381,  381, 1060,
			  109,  379, 1060, 1060,  323, 1060,  323,  323, 1060,  107,
			 1060, 1060,  108,  389,  389,  389,  389,  324, 1060,  324,
			  324,  151,  107, 1060,  152,  108,  159,  159,  159,  159,
			 1060, 1060,  110,  159, 1060,  151, 1060, 1060,  111,  112,
			  113,  114,  115,  116,  117,  312,  159, 1060,  313,  119,
			  119,  119, 1060,  390,  385,  385,  385,  314,  109,  107,

			 1060,  165,  108, 1060,  119,  165,  119, 1060,  119,  119,
			  315,  109, 1060,  119,  107,  119, 1060,  108,  165,  119,
			 1060,  119, 1060, 1060,  119,  119,  119,  119,  119,  119,
			  110, 1060,  107, 1060,  609,  108,  111,  112,  113,  114,
			  115,  116,  117,  110,  107, 1060, 1060,  108,  109,  111,
			  112,  113,  114,  115,  116,  117, 1060, 1060,  280,  107,
			  281,  281,  108,  109,  273,  274,  275,  276,  277,  278,
			  279, 1060,  316,  317,  318,  319,  320,  321,  322,  107,
			  110,  109,  108,  625,  625,  625,  111,  112,  113,  114,
			  115,  116,  117,  107, 1060,  110,  108,  626,  626,  626,

			  325,  111,  112,  113,  114,  115,  116,  117,  109,  107,
			 1060, 1060,  108,  110,  282, 1060,  326,  326,  326,  111,
			  112,  113,  114,  115,  116,  117,  107, 1060,  109,  108,
			  331,  120,  121,  122,  123,  124,  125,  126,  107, 1060,
			  110,  108,  109,  327,  327,  283,  111,  112,  113,  114,
			  115,  116,  117,  107, 1060, 1060,  108, 1060,  109, 1060,
			  110,  522, 1060,  328,  328,  328,  111,  112,  113,  114,
			  115,  116,  117,  107,  110, 1060,  108,  329,  329,  329,
			  111,  112,  113,  114,  115,  116,  117, 1060,  107, 1060,
			  110,  108, 1060,  330, 1060, 1060,  111,  112,  113,  114,

			  115,  116,  117,  273,  274,  275,  276,  277,  278,  279,
			  332,  332,  332,  120,  121,  122,  123,  124,  125,  126,
			 1060, 1060,  333,  333, 1060,  120,  121,  122,  123,  124,
			  125,  126, 1060,  281, 1060,  281,  281,  334,  334,  334,
			  120,  121,  122,  123,  124,  125,  126,  338,  523,  524,
			  525,  526,  527,  528,  529,  338, 1060,  335,  335,  335,
			  120,  121,  122,  123,  124,  125,  126,  338,  599,  599,
			  599,  599,  336, 1060,  507,  120,  121,  122,  123,  124,
			  125,  126,  346, 1060, 1060,  347,  348,  349,  350,  282,
			  165,  165,  165, 1060,  351, 1060,  338,  165,  165,  165,

			 1060,  352, 1060,  353, 1060,  354,  355,  356,  357,  338,
			  358, 1060,  359,  165,  165,  165,  360, 1060,  361,  338,
			  283,  362,  363,  364,  365,  366,  367,  127,  127,  127,
			  339,  340,  341,  342,  343,  344,  345,  368,  339,  340,
			  341,  342,  343,  344,  345,  338, 1060,  369,  369,  369,
			  339,  340,  341,  342,  343,  344,  345,  252,  253,  254,
			  255,  256,  257,  258,  165,  165,  165, 1060, 1060,  339,
			  340,  341,  342,  343,  344,  345,  370,  370, 1060,  339,
			  340,  341,  342,  343,  344,  345,  727,  727,  727,  371,
			  371,  371,  339,  340,  341,  342,  343,  344,  345,  372,

			  372,  372,  339,  340,  341,  342,  343,  344,  345,  305,
			  273,  274,  275,  276,  277,  278,  279,  728,  728,  728,
			 1060, 1060,  159, 1060, 1060,  373,  391, 1060,  339,  340,
			  341,  342,  343,  344,  345,  387,  387,  387,  387,  159,
			  165, 1060,  165, 1060, 1060,  387,  387,  387,  387,  387,
			  387,  159,  165,  159,  165,  159,  397,  159,  392,  393,
			 1060, 1060,  394,  281, 1060,  281,  288, 1060,  159, 1060,
			  159,  165,  165, 1060,  165,  382, 1060,  387,  387,  387,
			  387,  387,  387,  165,  165,  165,  159,  165,  398,  165,
			  159,  395,  159, 1060,  396,  159,  159, 1060,  392,  411,

			  165, 1060,  165,  159,  399,  165,  398,  165, 1060,  159,
			  395,  401,  159,  396,  165,  165,  165,  165,  165,  282,
			 1060,  165,  165,  165,  165,  165,  165,  165,  165,  402,
			  392,  412, 1060,  165, 1060,  165,  400,  165,  398,  165,
			 1060,  165,  395,  402,  165,  396,  165,  165,  165,  165,
			  283, 1060,  165,  165,  165,  165,  159,  165,  165,  400,
			  159,  402, 1060,  413,  165,  165,  165,  159,  165,  159,
			  159,  159,  159,  159,  410,  409,  159,  159,  165, 1060,
			  159,  417, 1060, 1060,  165,  415,  165, 1060,  165,  159,
			 1060,  400,  165, 1060,  159,  414,  165,  159,  165,  165,

			  165,  159, 1060, 1060,  165,  165,  410,  410,  165,  165,
			  165,  412,  165,  418,  419, 1060, 1060,  416,  165, 1060,
			  165,  165, 1060, 1060,  414, 1060,  165, 1060, 1060,  165,
			  165, 1060,  165,  165,  416,  165,  165,  165,  165, 1060,
			 1060,  159,  418,  412,  165,  159,  420,  165,  165,  165,
			  165,  165,  165,  165, 1060,  165,  414, 1060,  159,  420,
			 1060,  165,  165, 1060,  165,  165,  416,  165,  165,  165,
			  165,  159, 1060,  165,  418,  159,  165,  165, 1060,  165,
			  165,  165, 1060,  165, 1060,  165, 1060,  165,  159,  427,
			  165,  420,  424,  165,  159,  421,  425,  165,  159,  422,

			 1060, 1060,  165,  165,  165,  159, 1060,  165,  429,  159,
			  426,  159, 1060,  423,  165,  439,  159,  159,  159,  159,
			  165,  428,  159,  430,  424, 1060,  165,  424,  425, 1060,
			  165,  425,  159, 1060,  165, 1060,  165,  165, 1060, 1060,
			  431,  165,  426,  165,  159,  426,  165,  440,  159, 1060,
			  165,  165,  165, 1060,  165,  432, 1060,  428,  431,  433,
			 1060,  159,  165,  434,  165, 1060,  165,  165,  165,  165,
			  159,  435, 1060,  432,  159,  436,  165, 1060,  165,  165,
			  165,  437,  165, 1060,  165, 1060, 1060,  159, 1060,  428,
			  431,  435, 1060,  165,  165,  436, 1060, 1060,  165,  165,

			  165,  165,  165,  435,  159,  432,  165,  436,  159,  440,
			  165,  165,  438,  438,  165,  159,  159,  159,  441,  165,
			  165,  159,  165,  165,  165,  165,  442,  159,  159,  159,
			  159, 1060,  165, 1060,  159,  165,  165,  165,  165,  165,
			  165,  440, 1060, 1060,  438, 1060,  165,  159, 1060, 1060,
			  442, 1060,  165,  165,  165,  165,  165,  165,  442,  159,
			 1060, 1060,  165,  159,  165,  159,  165,  165,  445,  159,
			  446, 1060,  447,  165,  443,  165,  159,  159,  159,  165,
			 1060, 1060,  159,  448, 1060,  165,  449,  598,  598,  598,
			  598,  165,  165,  165,  165,  165, 1060,  165, 1060, 1060, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  450,  165,  451, 1060,  452,  165,  444,  165,  165,  165,
			  165, 1060,  159, 1060,  165,  453,  159,  165,  454,  165,
			 1060,  165,  455,  444,  159,  165,  457,  165,  159,  159,
			 1060,  165,  754,  754,  754,  754, 1060,  165,  458, 1060,
			 1060,  159, 1060, 1060,  165, 1060, 1060, 1060,  165, 1060,
			 1060,  165, 1060,  165,  456,  444,  165,  165,  459,  165,
			  165,  165, 1060,  165,  450, 1060,  451, 1060,  452,  165,
			  460, 1060,  165,  165,  165,  456,  165,  159,  165,  453,
			  459,  159,  454, 1060,  165,  165,  159,  165,  165,  165,
			  159,  165,  460,  462,  159,  463,  450,  165,  451, 1060,

			  452,  165, 1060,  159,  165,  461,  165,  456,  165,  165,
			  165,  453,  459,  165,  454, 1060,  165,  165,  165,  165,
			  165,  165,  165,  165,  460,  462,  165,  464,  159,  165,
			  507,  465,  159,  165,  159,  165,  467,  462,  159,  159,
			  165, 1060,  165,  159,  468,  159,  165,  464,  165,  466,
			  159,  159,  165,  165,  469,  165,  159,  165,  165,  165,
			  165, 1060, 1060,  466,  165,  165,  165,  159,  468,  165,
			  165,  165,  165, 1060,  165,  165,  468,  165,  165,  464,
			  165,  466,  165,  165,  165,  165,  470,  165,  165,  165,
			  165,  165, 1060,  470,  471, 1060,  472,  165, 1060,  165,

			  165,  165,  165,  159,  473, 1060, 1060,  474, 1060,  475,
			  476, 1060,  165,  252,  253,  254,  255,  256,  257,  258,
			  758,  758,  758,  758, 1060,  470,  477, 1060,  478, 1060,
			 1060, 1060,  165, 1060,  165,  165,  479, 1060, 1060,  480,
			 1060,  481,  482, 1060,  165,  477, 1060,  478,  604,  604,
			  604,  604,  159,  165, 1060,  479,  159, 1060,  480, 1060,
			  481,  482, 1060,  483,  159,  165, 1060,  484,  159,  159,
			  485, 1060,  165, 1060,  486, 1060, 1060,  477, 1060,  478,
			 1060,  487,  165, 1060,  165,  165, 1060,  479,  165, 1060,
			  480, 1060,  481,  482,  159,  485,  165,  165,  489,  486,

			  165,  165,  485,  165,  165,  165,  486, 1060,  159,  488,
			  490,  159,  159,  488,  165,  165,  159,  165, 1060,  165,
			  159, 1060,  165, 1060,  165,  159,  165, 1060,  491,  165,
			  490,  492, 1060,  499,  165,  165, 1060,  165, 1060, 1060,
			  165,  488,  490,  165,  165, 1060, 1060,  165,  165,  165,
			 1060,  165,  165, 1060,  165, 1060,  165,  165,  159, 1060,
			  492,  165,  503,  492,  159,  500,  165,  493,  159,  496,
			 1060, 1060,  494, 1060,  497,  159,  159,  165,  159,  165,
			  159,  159,  159,  495,  501,  498,  165, 1060,  165,  165,
			  165, 1060,  500,  159,  504,  505,  165,  507,  165,  496,

			  165,  496, 1060, 1060,  497, 1060,  497,  165,  165,  165,
			  165,  165,  165,  165,  165,  498,  502,  498,  165,  507,
			  165,  165,  504,  502,  500,  165,  165,  506,  165,  165,
			  165,  165,  507,  165,  165,  165,  616, 1060,  165,  506,
			 1060,  165,  507, 1060, 1060,  165,  165,  861,  861,  861,
			  861, 1060,  507, 1060,  504,  502, 1060, 1060,  165, 1060,
			  165,  165,  507,  165, 1060,  165,  165,  165,  616, 1060,
			  165,  506, 1060,  165,  385,  385,  385,  165,  165,  508,
			  252,  253,  254,  255,  256,  257,  258,  306,  306,  306,
			  273,  274,  275,  276,  277,  278,  279, 1060, 1060,  509,

			  509,  509,  252,  253,  254,  255,  256,  257,  258,  530,
			 1060, 1060,  510,  510,  609,  252,  253,  254,  255,  256,
			  257,  258,  511,  511,  511,  252,  253,  254,  255,  256,
			  257,  258,  512,  512,  512,  252,  253,  254,  255,  256,
			  257,  258,  513, 1060, 1060,  252,  253,  254,  255,  256,
			  257,  258,  307,  307, 1060,  273,  274,  275,  276,  277,
			  278,  279,  308,  308,  308,  273,  274,  275,  276,  277,
			  278,  279,  309,  309,  309,  273,  274,  275,  276,  277,
			  278,  279,  310, 1060, 1060,  273,  274,  275,  276,  277,
			  278,  279,  281, 1060,  285,  281,  531,  532,  533,  534,

			  535,  536,  537,  282, 1060, 1060,  282, 1060,  289, 1060,
			  283,  272, 1060,  283, 1060,  297, 1060, 1060,  272,  273,
			  274,  275,  276,  277,  278,  279,  282, 1060, 1060,  282,
			 1060,  289, 1060, 1060,  272,  282, 1060, 1060,  282, 1060,
			  289, 1060, 1060,  272, 1060, 1060,  282, 1060,  286,  282,
			 1060,  289, 1060, 1060,  272, 1060,  282, 1060, 1060,  282,
			 1060,  289, 1060, 1060,  272, 1060,  282, 1060, 1060,  282,
			  597,  289,  597, 1060,  272,  598,  598,  598,  598,  287,
			 1060,  165, 1060,  165,  273,  274,  275,  276,  277,  278,
			  279, 1060, 1060,  165, 1060,  290,  291,  292,  293,  294,

			  295,  296,  298,  299,  300,  301,  302,  303,  304,  282,
			 1060, 1060,  282,  165,  289,  165, 1060,  272,  290,  291,
			  292,  293,  294,  295,  296,  165,  538,  290,  291,  292,
			  293,  294,  295,  296, 1060,  539,  539,  539,  290,  291,
			  292,  293,  294,  295,  296,  540,  540, 1060,  290,  291,
			  292,  293,  294,  295,  296,  541,  541,  541,  290,  291,
			  292,  293,  294,  295,  296,  282, 1060, 1060,  282, 1060,
			  289, 1060, 1060,  272,  273,  274,  275,  276,  277,  278,
			  279,  283, 1060, 1060,  283,  165,  297,  165, 1060,  272,
			  273,  274,  275,  276,  277,  278,  279,  165,  542,  542,

			  542,  290,  291,  292,  293,  294,  295,  296,  283, 1060,
			 1060,  283, 1060,  297, 1060, 1060,  272,  165,  283,  165,
			 1060,  283, 1060,  297, 1060, 1060,  272, 1060,  283,  165,
			 1060,  283, 1060,  297, 1060, 1060,  272, 1060,  283, 1060,
			 1060,  283, 1060,  297, 1060, 1060,  272, 1060,  283, 1060,
			 1060,  283, 1060,  297,  543, 1060,  272,  290,  291,  292,
			  293,  294,  295,  296,  283, 1060, 1060,  283, 1060,  297,
			 1060, 1060,  272,  298,  299,  300,  301,  302,  303,  304,
			  273,  274,  275,  276,  277,  278,  279,  273,  274,  275,
			  276,  277,  278,  279,  862,  862,  862,  862, 1060,  544,

			  298,  299,  300,  301,  302,  303,  304,  545,  545,  545,
			  298,  299,  300,  301,  302,  303,  304,  546,  546, 1060,
			  298,  299,  300,  301,  302,  303,  304,  547,  547,  547,
			  298,  299,  300,  301,  302,  303,  304,  548,  548,  548,
			  298,  299,  300,  301,  302,  303,  304,  107, 1060, 1060,
			  552, 1060, 1060,  549, 1060, 1060,  298,  299,  300,  301,
			  302,  303,  304,  273,  274,  275,  276,  277,  278,  279,
			  550,  550,  550,  273,  274,  275,  276,  277,  278,  279,
			  551,  551,  551,  273,  274,  275,  276,  277,  278,  279,
			  107, 1060, 1060,  108, 1060, 1060, 1060,  553, 1060, 1060, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  108, 1060, 1060, 1060,  107, 1060, 1060,  552, 1060, 1060,
			 1060,  107, 1060, 1060,  555, 1060, 1060,  554,  554,  554,
			  554,  107, 1060,  144,  552,  606,  606,  606,  606,  107,
			 1060, 1060,  552, 1060,  316,  317,  318,  319,  320,  321,
			  322,  107, 1060, 1060,  552,  757,  757,  757,  757, 1060,
			  603,  107,  603, 1060,  552,  604,  604,  604,  604, 1060,
			 1060,  107, 1060, 1060,  552,  151,  752,  752,  752,  752,
			 1060,  107, 1060, 1060,  552, 1060, 1060,  120,  121,  122,
			  123,  124,  125,  126,  120,  121,  122,  123,  124,  125,
			  126,  316,  317,  318,  319,  320,  321,  322,  316,  317,

			  318,  319,  320,  321,  322, 1060,  753, 1060,  316,  317,
			  318,  319,  320,  321,  322,  556,  316,  317,  318,  319,
			  320,  321,  322, 1060, 1060,  557,  557,  557,  316,  317,
			  318,  319,  320,  321,  322,  558,  558, 1060,  316,  317,
			  318,  319,  320,  321,  322,  559,  559,  559,  316,  317,
			  318,  319,  320,  321,  322,  560,  560,  560,  316,  317,
			  318,  319,  320,  321,  322,  107, 1060, 1060,  552,  596,
			  596,  596,  596,  323, 1060,  323,  323, 1060,  107, 1060,
			 1060,  108, 1060,  375, 1060, 1060,  324,  620,  324,  324,
			  165,  107,  165, 1060,  108, 1060,  600,  600,  600,  600,

			 1060, 1060,  165,  613,  613,  613,  613, 1060, 1060,  376,
			  601,  107, 1060, 1060,  108,  375, 1060, 1060, 1060,  620,
			 1060, 1060,  165, 1060,  165,  107, 1060,  109,  108, 1060,
			  751,  751,  751,  751,  165, 1060,  602, 1060,  107, 1060,
			  109,  108,  601,  390,  859, 1060, 1060, 1060,  107,  561,
			 1060,  108,  316,  317,  318,  319,  320,  321,  322,  110,
			  109,  107, 1060, 1060,  108,  111,  112,  113,  114,  115,
			  116,  117,  110,  617,  109, 1060,  859,  159,  111,  112,
			  113,  114,  115,  116,  117,  107, 1060,  109,  108, 1060,
			  159, 1060,  110,  107, 1060, 1060,  108, 1060,  111,  112,

			  113,  114,  115,  116,  117,  618,  110, 1060,  107,  165,
			  109,  108,  111,  112,  113,  114,  115,  116,  117,  110,
			  107, 1060,  165,  108, 1060,  111,  112,  113,  114,  115,
			  116,  117, 1060, 1060,  109,  120,  121,  122,  123,  124,
			  125,  126,  110,  107, 1060, 1060,  108, 1060,  111,  112,
			  113,  114,  115,  116,  117,  107, 1060,  109,  108,  866,
			  866,  866,  866, 1060, 1060,  107,  110, 1060,  108,  562,
			  562,  562,  111,  112,  113,  114,  115,  116,  117, 1060,
			  120,  121,  122,  123,  124,  125,  126, 1060, 1060,  110,
			 1060, 1060,  563,  563,  563,  111,  112,  113,  114,  115,

			  116,  117, 1060,  868,  868,  868,  868,  120,  121,  122,
			  123,  124,  125,  126, 1060,  339,  340,  341,  342,  343,
			  344,  345, 1060, 1060, 1060,  943,  943,  943,  943, 1060,
			  120,  121,  122,  123,  124,  125,  126, 1060, 1060,  564,
			  564,  564,  120,  121,  122,  123,  124,  125,  126,  565,
			  565,  565,  120,  121,  122,  123,  124,  125,  126, 1060,
			 1060, 1060,  339,  340,  341,  342,  343,  344,  345,  566,
			  339,  340,  341,  342,  343,  344,  345,  572,  947,  947,
			  947,  947,  567,  567,  567,  339,  340,  341,  342,  343,
			  344,  345,  573, 1060,  568,  568, 1060,  339,  340,  341,

			  342,  343,  344,  345,  569,  569,  569,  339,  340,  341,
			  342,  343,  344,  345,  575, 1060, 1060,  570,  570,  570,
			  339,  340,  341,  342,  343,  344,  345,  576,  144, 1060,
			  605,  605,  606,  606,  948,  948,  948,  948, 1060,  571,
			 1060,  152,  339,  340,  341,  342,  343,  344,  345,  577,
			  577,  577,  577,  578,  950,  950,  950,  950, 1060, 1060,
			  339,  340,  341,  342,  343,  344,  345,  579, 1060, 1060,
			  151, 1060, 1060,  152,  580,  339,  340,  341,  342,  343,
			  344,  345,  581,  942,  942,  942,  942, 1060, 1060,  582,
			 1060, 1060,  614,  614,  614,  614,  583,  339,  340,  341,

			  342,  343,  344,  345,  584,  759,  759,  759,  759, 1060,
			  339,  340,  341,  342,  343,  344,  345,  585,  942,  942,
			  942,  942, 1060,  339,  340,  341,  342,  343,  344,  345,
			  586, 1060,  390, 1060, 1060, 1060,  339,  340,  341,  342,
			  343,  344,  345,  587, 1060,  760, 1001, 1001, 1001, 1001,
			  339,  340,  341,  342,  343,  344,  345,  339,  340,  341,
			  342,  343,  344,  345,  588,  339,  340,  341,  342,  343,
			  344,  345,  339,  340,  341,  342,  343,  344,  345,  339,
			  340,  341,  342,  343,  344,  345,  589,  339,  340,  341,
			  342,  343,  344,  345,  590,  751,  751,  751,  751, 1060,

			  339,  340,  341,  342,  343,  344,  345,  591,  159,  375,
			 1060, 1060,  159,  339,  340,  341,  342,  343,  344,  345,
			  592,  860,  860,  860,  860,  159,  339,  340,  341,  342,
			  343,  344,  345,  593, 1060,  376, 1006, 1006, 1006, 1006,
			  165,  375, 1060, 1060,  165, 1060, 1060,  339,  340,  341,
			  342,  343,  344,  345, 1060, 1060, 1060,  165, 1060, 1060,
			  756,  753,  756, 1060, 1060,  757,  757,  757,  757,  339,
			  340,  341,  342,  343,  344,  345, 1060,  339,  340,  341,
			  342,  343,  344,  345, 1060, 1060, 1060, 1060, 1060, 1060,
			  339,  340,  341,  342,  343,  344,  345, 1060,  949,  949,

			  949,  949, 1060,  339,  340,  341,  342,  343,  344,  345,
			 1008, 1008, 1008, 1008, 1060, 1060,  339,  340,  341,  342,
			  343,  344,  345,  127,  127,  127,  339,  340,  341,  342,
			  343,  344,  345, 1060,  127,  127,  127,  339,  340,  341,
			  342,  343,  344,  345,  127,  127,  127,  339,  340,  341,
			  342,  343,  344,  345, 1060, 1060,  127,  127,  127,  339,
			  340,  341,  342,  343,  344,  345,  594,  594,  594,  339,
			  340,  341,  342,  343,  344,  345, 1060,  595,  595,  595,
			  339,  340,  341,  342,  343,  344,  345,  387,  387,  387,
			  387, 1060,  159,  618, 1060, 1060,  159,  387,  387,  387,

			  387,  387,  387,  159,  165,  615,  165,  159, 1060,  159,
			 1060, 1060,  863,  863,  863,  863,  165, 1060, 1060, 1060,
			  159, 1060, 1060, 1060,  165,  618,  869,  611,  165,  387,
			  387,  387,  387,  387,  387,  165,  165,  616,  165,  165,
			  621,  165,  159,  623,  159,  159,  159, 1060,  165,  159,
			  619,  165,  165,  165,  165, 1060,  165,  622,  869,  159,
			  624, 1060,  159,  165, 1060, 1060,  165,  159, 1060,  627,
			 1060,  159,  623, 1060,  165,  623,  165,  165,  165, 1060,
			 1060,  165,  620,  165,  159,  165,  165, 1060,  165,  624,
			 1060,  165,  624,  628,  165,  165, 1060, 1060,  165,  165, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1060,  628,  165,  165,  165,  159,  165,  159,  165,  159,
			 1060,  159, 1060,  630,  165, 1060,  165,  165,  165,  165,
			 1060, 1060,  159,  629,  159,  628, 1060,  632,  631,  165,
			 1060,  633, 1060, 1060,  165,  159,  165,  165,  165,  165,
			  165,  165, 1060,  165, 1060,  630,  165, 1060,  159,  165,
			  165,  165, 1060,  634,  165,  630,  165, 1060,  159,  632,
			  632,  165,  159,  634,  165, 1060,  165,  165, 1060, 1060,
			 1060,  165, 1060,  165,  159,  635,  165,  636,  639, 1060,
			  165, 1060,  159,  165,  641,  634,  159, 1060,  159, 1060,
			  165,  159, 1060, 1060,  165, 1060,  165, 1060,  165,  159,

			 1060,  159,  637,  165, 1060,  165,  165,  636,  165,  636,
			  640, 1060, 1060, 1060,  165,  165,  642,  165,  165,  165,
			  165,  640, 1060,  165,  642, 1060,  638, 1060,  165,  165,
			  165,  165, 1060,  165,  638,  165, 1060,  165,  159, 1060,
			  165, 1060,  643, 1060, 1060,  644,  159,  165, 1060,  165,
			  159,  165,  165,  640,  165,  159,  642, 1060,  638, 1060,
			  165,  165,  165,  159,  165, 1060, 1060,  165, 1060,  165,
			  165,  159,  165, 1060,  644,  159, 1060,  644,  165,  165,
			 1060,  165,  165,  165,  165, 1060,  165,  165,  159, 1060,
			  165,  645,  165,  165,  647,  165,  165,  159,  159,  646,

			 1060,  651,  165,  165, 1060,  649, 1060,  165,  648, 1060,
			 1060,  159, 1060,  165,  159,  165,  165, 1060,  165,  650,
			  165, 1060,  165,  646,  165,  165,  649, 1060,  165,  165,
			  165,  646, 1060,  652,  165,  652, 1060,  649, 1060, 1060,
			  650,  159,  165,  165,  165,  159,  165, 1060,  165,  159,
			  165,  650, 1060,  159,  165, 1060, 1060, 1060,  159,  653,
			  165, 1060, 1060,  165, 1060,  165,  159,  652,  655, 1060,
			  654, 1060, 1060,  165,  165,  165,  165,  165, 1060, 1060,
			  165,  165,  165, 1060, 1060,  165,  165, 1060,  656, 1060,
			  165,  654,  165, 1060, 1060,  165, 1060,  165,  165, 1060,

			  656,  159,  654, 1060, 1060,  159, 1060,  165, 1060,  165,
			  659,  165,  165,  657,  165, 1060, 1060,  662,  159,  165,
			  656,  165, 1060,  660,  165, 1060,  658,  159, 1060,  165,
			  159,  159, 1060,  165,  663, 1060, 1060,  165,  661, 1060,
			 1060,  165,  659,  165,  159,  659, 1060,  159,  159,  662,
			  165,  165,  159,  165, 1060,  660,  665, 1060,  660,  165,
			  159,  165,  165,  165,  667,  159,  664, 1060,  159,  671,
			  662, 1060,  159,  159, 1060, 1060,  165,  159, 1060,  165,
			  165, 1060, 1060,  669,  165,  159,  159, 1060,  666, 1060,
			 1060, 1060,  165, 1060, 1060, 1060,  668,  165, 1060, 1060,

			  165,  672,  159,  664,  165,  165,  673,  668,  666,  165,
			  165,  165,  165,  165,  165,  670,  165,  165,  165,  159,
			 1060, 1060,  165,  165, 1060,  165,  165,  165, 1060,  670,
			  949,  949,  949,  949,  165,  664, 1060,  165,  674,  668,
			  666, 1060,  165,  165,  165,  165,  165, 1060,  165,  672,
			 1060,  165, 1060, 1060,  165,  165,  674,  165,  165,  165,
			  165,  670,  165,  165, 1060,  165,  675,  159, 1060,  165,
			  159,  159,  165, 1060, 1060,  165,  159, 1060,  676, 1060,
			  679,  672,  677,  159,  159, 1060, 1060, 1060,  674,  165,
			 1060,  165,  165,  159,  165,  165,  159,  165,  676,  165,

			  159,  165,  165,  165,  165, 1060, 1060,  165,  165, 1060,
			  676, 1060,  680,  159,  678,  165,  165,  680,  165, 1060,
			  165,  165,  678,  165,  165,  165,  165,  159,  165, 1060,
			  165,  159,  165,  165, 1060,  165,  165,  165,  682, 1060,
			 1060,  681, 1060, 1060,  159,  165, 1060,  165, 1060,  680,
			  165, 1060,  165,  165,  678,  165,  165,  159,  165,  165,
			 1060,  683,  165,  165, 1060,  165, 1060,  165,  165,  165,
			  682,  684, 1060,  682,  159, 1060,  165, 1060,  165,  165,
			  165, 1060, 1060, 1060,  159,  165, 1060,  165,  689,  165,
			  165,  159, 1060,  684,  159,  691,  685,  165,  159,  686,

			 1060,  159, 1060,  684,  687, 1060,  165,  688,  159, 1060,
			  165,  159,  165,  165, 1060,  165,  165,  693, 1060, 1060,
			  690,  159,  165,  165, 1060,  165,  165,  692,  687, 1060,
			  165,  688, 1060,  165,  159, 1060,  687,  159,  159,  688,
			  165,  159,  159,  165,  159,  165,  697,  165,  159,  694,
			 1060, 1060, 1060,  165,  701,  159,  690,  165,  695, 1060,
			 1060,  159, 1060,  165,  698,  165,  165, 1060, 1060,  165,
			  165,  694,  692,  165,  165,  165,  165, 1060,  699,  165,
			  165,  165,  165, 1060,  165, 1060,  702,  165,  690, 1060,
			  696,  165, 1060,  165,  165,  165,  700,  165, 1060,  699,

			  165, 1060,  165,  694,  692, 1060, 1060,  165,  165,  696,
			  165,  165,  165,  165,  165, 1060,  165,  700,  159, 1060,
			  165,  705,  703,  165, 1060,  159,  165,  165, 1060,  165,
			 1060,  699,  165,  702,  165,  159,  704, 1060,  159,  165,
			  165,  696,  165,  165,  165,  165, 1060, 1060, 1060,  700,
			  165,  706,  165,  706,  704,  165, 1060,  165, 1060,  165,
			 1060,  165,  165, 1060,  165,  702, 1060,  165,  704,  159,
			  165,  165,  159,  159,  165,  165,  159,  165, 1060,  165,
			  707,  710,  709,  706, 1060,  708,  159,  165,  165,  159,
			  165,  165, 1060,  159,  165, 1060,  165,  711,  159, 1060,

			  165,  165,  713, 1060,  165,  165,  165, 1060,  165, 1060,
			  159,  165,  708,  710,  710,  159, 1060,  708,  165,  712,
			  165,  165,  165,  165, 1060,  165,  165,  159,  165,  712,
			  165,  159,  165,  159,  714, 1060, 1060,  159,  165, 1060,
			 1060,  717,  165,  715,  159,  714, 1060,  165, 1060, 1060,
			  159,  712,  165, 1060,  165, 1060, 1060, 1060,  165,  165,
			  165, 1060, 1060,  165,  165,  165,  165, 1060,  165,  165,
			  165,  716, 1060,  718, 1060,  716,  165,  714,  165,  165,
			  718,  724,  165,  165,  165,  165,  165,  720, 1060,  159,
			  165,  165,  165,  159,  522,  165,  165,  719,  165, 1060,

			  165,  159,  165,  716,  721,  159,  159,  507, 1060, 1060,
			  165,  165,  718,  724,  507,  165, 1060,  165,  159,  720,
			  722,  165,  165,  165,  165,  165,  507,  165,  165,  720,
			  165,  159, 1060,  165,  165,  159,  722,  165,  165,  159,
			  165,  507, 1060,  159,  723,  165, 1060,  165,  159, 1060,
			  165,  507,  722, 1060, 1060, 1060,  159,  165, 1060, 1060,
			  165,  507,  165,  165, 1060,  522, 1060,  165, 1060, 1060,
			 1060,  165,  165, 1060, 1060,  165,  724,  165,  522,  165,
			  165,  523,  524,  525,  526,  527,  528,  529,  165,  165,
			  252,  253,  254,  255,  256,  257,  258,  252,  253,  254, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  255,  256,  257,  258,  522, 1003, 1003, 1003, 1003,  252,
			  253,  254,  255,  256,  257,  258,  522, 1005, 1005, 1005,
			 1005, 1060, 1060,  530,  252,  253,  254,  255,  256,  257,
			  258,  725,  725,  725,  252,  253,  254,  255,  256,  257,
			  258,  726,  726,  726,  252,  253,  254,  255,  256,  257,
			  258,  729,  523,  524,  525,  526,  527,  528,  529,  522,
			 1060, 1060,  730,  730,  730,  523,  524,  525,  526,  527,
			  528,  529,  522,  273,  274,  275,  276,  277,  278,  279,
			  530,  273,  274,  275,  276,  277,  278,  279,  731,  731,
			  530,  523,  524,  525,  526,  527,  528,  529, 1060, 1060,

			  732,  732,  732,  523,  524,  525,  526,  527,  528,  529,
			  531,  532,  533,  534,  535,  536,  537,  530,  864,  864,
			  864,  864, 1060,  941, 1060,  941, 1060,  530,  942,  942,
			  942,  942, 1060,  951, 1060,  951, 1060,  530,  949,  949,
			  949,  949, 1060,  733,  733,  733,  523,  524,  525,  526,
			  527,  528,  529,  530, 1060, 1060,  734, 1060,  865,  523,
			  524,  525,  526,  527,  528,  529,  735,  531,  532,  533,
			  534,  535,  536,  537,  736,  736,  736,  531,  532,  533,
			  534,  535,  536,  537,  282, 1060, 1060,  282, 1060,  289,
			 1060,  282,  272, 1060,  282, 1060,  289, 1060, 1060,  272,

			 1060,  737,  737, 1060,  531,  532,  533,  534,  535,  536,
			  537,  738,  738,  738,  531,  532,  533,  534,  535,  536,
			  537,  739,  739,  739,  531,  532,  533,  534,  535,  536,
			  537,  282, 1060, 1060,  282, 1060,  289,  740, 1060,  272,
			  531,  532,  533,  534,  535,  536,  537,  282, 1060, 1060,
			  282, 1060,  289, 1060, 1060,  272, 1060,  282, 1060, 1060,
			  282, 1060,  289, 1060, 1060,  272, 1060,  282, 1060, 1060,
			  282, 1060,  289, 1060, 1060,  272,  290,  291,  292,  293,
			  294,  295,  296,  290,  291,  292,  293,  294,  295,  296,
			  283, 1060, 1060,  283, 1060,  297, 1060,  283,  272, 1060,

			  283, 1060,  297, 1060,  283,  272, 1060,  283, 1060,  297,
			 1060,  283,  272, 1060,  283, 1060,  297, 1060, 1060,  272,
			 1060, 1060, 1060,  290,  291,  292,  293,  294,  295,  296,
			  283, 1060, 1060,  283, 1060,  297, 1060, 1060,  272,  290,
			  291,  292,  293,  294,  295,  296,  741,  741,  741,  290,
			  291,  292,  293,  294,  295,  296,  742,  742,  742,  290,
			  291,  292,  293,  294,  295,  296,  283, 1060, 1060,  283,
			 1060,  297, 1060, 1060,  272, 1060, 1060, 1060,  553, 1060,
			 1060,  552,  298,  299,  300,  301,  302,  303,  304,  298,
			  299,  300,  301,  302,  303,  304,  298,  299,  300,  301,

			  302,  303,  304,  298,  299,  300,  301,  302,  303,  304,
			  107, 1060,  761,  552,  606,  606,  606,  606, 1060,  743,
			  743,  743,  298,  299,  300,  301,  302,  303,  304,  107,
			 1060, 1060,  552, 1060, 1060, 1060,  107, 1060, 1060,  552,
			 1060,  119,  745,  745,  745,  745,  553, 1060, 1060,  552,
			 1005, 1005, 1005, 1005,  390,  744,  744,  744,  298,  299,
			  300,  301,  302,  303,  304,  316,  317,  318,  319,  320,
			  321,  322,  119,  107, 1060, 1060,  552, 1060, 1060, 1060,
			  107, 1060, 1060,  552, 1060, 1060, 1060,  107, 1060, 1060,
			  552,  762,  762,  762,  762, 1060, 1060,  316,  317,  318,

			  319,  320,  321,  322,  107, 1060, 1060,  552,  614,  614,
			  614,  614,  867,  867,  867,  867,  316,  317,  318,  319,
			  320,  321,  322,  316,  317,  318,  319,  320,  321,  322,
			 1060,  390, 1060,  316,  317,  318,  319,  320,  321,  322,
			  107, 1060, 1060,  552, 1043, 1043, 1043, 1043,  390, 1060,
			 1060, 1060,  760,  107, 1060, 1060,  108, 1060, 1060, 1060,
			  316,  317,  318,  319,  320,  321,  322,  316,  317,  318,
			  319,  320,  321,  322,  316,  317,  318,  319,  320,  321,
			  322,  107, 1060, 1060,  108, 1060, 1060, 1060,  746,  746,
			  746,  316,  317,  318,  319,  320,  321,  322,  107, 1060,

			 1060,  108,  109, 1060, 1060,  107, 1060, 1060,  108,  755,
			  755,  755,  755,  339,  340,  341,  342,  343,  344,  345,
			 1060, 1060, 1060,  601,  747,  747,  747,  316,  317,  318,
			  319,  320,  321,  322,  110, 1060,  942,  942,  942,  942,
			  111,  112,  113,  114,  115,  116,  117,  109, 1060,  602,
			 1011, 1011, 1011, 1011, 1060,  601, 1060,  870, 1060,  614,
			  614,  614,  614, 1060, 1060,  507, 1060, 1060,  120,  121,
			  122,  123,  124,  125,  126, 1060,  753, 1060, 1060,  110,
			 1060, 1060,  507, 1060, 1060,  111,  112,  113,  114,  115,
			  116,  117,  120,  121,  122,  123,  124,  125,  126,  151,

			 1060, 1060, 1060,  339,  340,  341,  342,  343,  344,  345,
			  750,  577,  577,  577,  577, 1060, 1060, 1060,  339,  340,
			  341,  342,  343,  344,  345, 1060, 1045, 1045, 1045, 1045,
			 1060,  339,  340,  341,  342,  343,  344,  345,  748,  748,
			  748,  339,  340,  341,  342,  343,  344,  345,  252,  253,
			  254,  255,  256,  257,  258,  749,  749,  749,  339,  340,
			  341,  342,  343,  344,  345,  252,  253,  254,  255,  256,
			  257,  258, 1060, 1060, 1060, 1060, 1060, 1060, 1060,  761,
			 1060,  605,  605,  606,  606,  339,  340,  341,  342,  343,
			  344,  345,  152, 1060, 1060,  127,  127,  127,  339,  340,

			  341,  342,  343,  344,  345,  127,  127,  127,  339,  340,
			  341,  342,  343,  344,  345,  159, 1060, 1060,  165,  159,
			  165,  390, 1060,  159,  152, 1060,  764,  159, 1060, 1060,
			  165,  165,  159,  165,  763, 1060, 1060, 1060,  766, 1060,
			  159,  765, 1060,  165, 1060, 1060, 1060,  165, 1060, 1060,
			  165,  165,  165, 1060, 1060,  165, 1060, 1060,  764,  165,
			 1060, 1060,  165,  165,  165,  165,  764,  159,  770,  769,
			  766,  159,  165,  766,  159,  165,  768,  165,  159,  165,
			  767,  165,  772,  165,  159,  165, 1060,  165,  159,  165,
			 1060,  159,  159,  165, 1060, 1060,  771,  165, 1060,  165,

			  770,  770, 1060,  165, 1060,  159,  165, 1060,  768,  165,
			  165,  165,  768,  165,  772,  165,  165,  165, 1060,  165,
			  165,  165,  159,  165,  165,  165,  159, 1060,  772,  165,
			  774,  165,  773,  165,  159, 1060,  159,  165,  159,  159,
			  777, 1060, 1060,  165, 1060, 1060, 1060, 1060,  165, 1060,
			  165,  159,  775,  159,  165,  776, 1060, 1060,  165, 1060,
			  165, 1060,  774,  165,  774,  165,  165,  778,  165, 1060,
			  165,  165,  778, 1060,  165,  165,  165,  159, 1060, 1060,
			  165,  159,  165,  165,  776,  165,  165,  776,  784,  165,
			 1060,  165,  165,  165,  159,  165,  779,  780,  159,  778, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1060,  165,  781,  782, 1060,  165,  165,  159,  165,  165,
			  165,  159,  165,  165, 1060,  159, 1060, 1060,  165, 1060,
			  784,  165,  165,  165,  785,  165,  165,  165,  780,  780,
			  165, 1060,  159,  165,  782,  782,  159,  165,  783,  165,
			 1060, 1060,  165,  165,  165, 1060,  165,  165,  165,  159,
			 1060, 1060,  786, 1060,  165,  159,  786,  787,  165,  159,
			 1060, 1060,  788, 1060,  165,  159, 1060, 1060,  165,  159,
			  784,  165,  159,  165, 1060, 1060, 1060, 1060,  165, 1060,
			  165,  165,  791,  165,  786, 1060, 1060,  165, 1060,  788,
			  165,  165,  159, 1060,  788, 1060,  159,  165, 1060, 1060,

			  789,  165,  159,  165,  165,  165,  159,  790, 1060,  159,
			  165,  165,  165,  165,  792,  165,  159,  792, 1060,  795,
			  159, 1060,  165,  165,  165,  165, 1060,  794,  165,  793,
			 1060, 1060,  790,  159,  165, 1060, 1060,  165,  165,  790,
			 1060,  165,  165,  165,  165,  165,  159, 1060,  165,  792,
			  159,  796,  165, 1060,  165,  165,  165,  165,  165,  794,
			 1060,  794,  796,  797,  165,  165,  165,  159,  165,  165,
			  798,  799,  800, 1060, 1060, 1060,  165, 1060,  165,  165,
			 1060,  165,  165, 1060,  159, 1060, 1060, 1060,  165,  159,
			  165,  165, 1060,  159,  796,  798,  165, 1060,  165,  165,

			  165, 1060,  798,  800,  800,  165,  159,  165,  165,  801,
			 1060,  165, 1060,  165,  802,  159,  165,  165,  159,  159,
			 1060,  165,  803,  165,  165,  165,  165, 1060, 1060, 1060,
			 1060, 1060,  159,  804, 1060,  159,  165,  165,  165,  165,
			  165,  802,  165,  165, 1060,  165,  802,  165, 1060,  165,
			  165,  165,  165,  159,  804,  808,  165,  159,  165,  159,
			 1060,  805, 1060,  159,  165,  804,  806,  165,  165,  165,
			  159,  165,  165, 1060,  165,  165,  159,  165,  165, 1060,
			  165,  165,  807, 1060,  165,  165, 1060,  808,  159,  165,
			  810,  165,  159,  806, 1060,  165, 1060, 1060,  806, 1060,

			  159,  165,  165,  165,  159,  159, 1060, 1060,  165,  814,
			  165,  809,  165,  165,  808, 1060,  165,  811,  165,  165,
			  165,  165,  810,  159,  165,  812, 1060,  813,  165,  159,
			  159,  165,  165,  159,  159, 1060,  165,  165, 1060, 1060,
			  159,  814, 1060,  810, 1060, 1060,  815,  159,  165,  812,
			  165,  165,  165,  165,  165,  165, 1060,  812,  816,  814,
			  165,  165,  165,  165,  165,  165,  165, 1060,  165, 1060,
			  165,  159,  165, 1060, 1060,  159, 1060, 1060,  816,  165,
			  165,  818,  817,  165,  165, 1060,  165,  159,  159, 1060,
			  816,  159, 1060,  165,  159, 1060,  165,  165,  159,  165,

			  165, 1060,  165,  165,  159, 1060,  165,  165,  165,  165,
			 1060,  159,  165,  818,  818,  165, 1060,  159,  165,  165,
			  165,  159, 1060,  165, 1060,  165,  165, 1060,  819,  165,
			  165,  165, 1060,  820,  159,  165,  165, 1060,  165, 1060,
			  165,  165,  159,  165, 1060,  165,  159, 1060, 1060,  165,
			  165,  159,  165,  165,  165,  159, 1060, 1060, 1060,  159,
			  820,  165, 1060,  165,  165,  820,  165,  165,  159, 1060,
			  822,  821,  159,  165,  165, 1060,  159,  165,  165, 1060,
			  823, 1060, 1060,  165,  165, 1060,  165,  165, 1060,  159,
			 1060,  165, 1060,  165,  824,  165,  165,  165, 1060,  165,

			  165, 1060,  822,  822,  165,  165,  159,  826,  165,  165,
			  159,  825,  824,  165, 1060,  165,  159, 1060, 1060, 1060,
			  159,  165,  165,  159,  165,  165,  824, 1060,  828,  165,
			 1060,  165,  159,  827,  165, 1060,  159, 1060,  165,  826,
			 1060,  165,  165,  826,  829,  165, 1060,  165,  165,  159,
			 1060, 1060,  165, 1060,  165,  165,  165,  165, 1060, 1060,
			  828,  165,  830,  165,  165,  828,  165,  159,  165, 1060,
			 1060,  159, 1060,  165,  832,  831,  830,  165, 1060,  165,
			 1060,  165, 1060, 1060,  159, 1060, 1060,  159, 1060,  165,
			 1060,  159, 1060,  165,  830,  165, 1060,  159,  835,  165,

			  836,  159,  165,  165,  159,  165,  832,  832, 1060,  165,
			 1060,  165,  165,  165,  159,  165,  165,  833, 1060,  165,
			 1060,  165,  834,  165,  159,  165, 1060, 1060,  159,  165,
			  836, 1060,  836,  165,  165,  159,  165,  839,  165,  159,
			  165,  159, 1060, 1060,  165,  165,  165,  165,  837,  834,
			  165,  838,  159,  840,  834, 1060,  165,  165, 1060,  159,
			  165, 1060,  165,  159,  165, 1060, 1060,  165, 1060,  840,
			  165,  165,  165,  165,  165,  165,  841,  165, 1060, 1060,
			  838,  842,  165,  838,  165,  840,  159,  165,  159, 1060,
			  159,  165,  159, 1060,  165,  165,  165, 1060,  165, 1060,

			  165,  843,  844,  159, 1060,  159,  165,  165,  842,  165,
			  165,  159, 1060,  842,  165,  159,  165, 1060,  165,  165,
			  165, 1060,  165, 1060,  165, 1060,  165,  165,  159,  165,
			  165, 1060,  165,  844,  844,  165,  159,  165, 1060,  165,
			  159,  845,  165,  165,  846, 1060,  165,  165,  165, 1002,
			  165, 1002,  165,  159, 1003, 1003, 1003, 1003,  165,  165,
			  165,  165,  165,  159, 1060, 1060, 1060,  159,  165, 1060,
			  159,  165,  165,  846,  159, 1060,  846,  165, 1060,  165,
			  159,  849,  165,  847,  165,  165,  848,  159,  850,  165,
			  165,  522, 1060,  851,  165,  165, 1060,  159,  522,  165,

			  165, 1060,  165,  852, 1060,  165,  165,  165,  522,  165,
			  159,  165,  165,  850,  165,  848,  165,  165,  848,  165,
			  850,  165,  165,  159,  159,  852,  165,  159,  159,  165,
			  522,  165,  165,  165, 1060,  852, 1060,  165, 1060,  165,
			  159,  159,  165,  165,  522, 1004,  165, 1004,  165,  165,
			 1005, 1005, 1005, 1005,  522,  165,  165, 1060,  165,  165,
			  165,  530, 1060,  165, 1060,  165, 1060, 1060,  530, 1060,
			 1060, 1060,  165,  165, 1060,  165,  530, 1060,  523,  524,
			  525,  526,  527,  528,  529,  523,  524,  525,  526,  527,
			  528,  529,  530, 1060, 1060,  523,  524,  525,  526,  527,

			  528,  529,  530, 1010, 1060, 1010, 1060, 1060, 1011, 1011,
			 1011, 1011,  530, 1060, 1060, 1060, 1060,  523,  524,  525,
			  526,  527,  528,  529, 1060, 1060, 1060, 1060,  853,  853,
			  853,  523,  524,  525,  526,  527,  528,  529,  854,  854,
			  854,  523,  524,  525,  526,  527,  528,  529,  531,  532,
			  533,  534,  535,  536,  537,  531,  532,  533,  534,  535,
			  536,  537, 1060,  531,  532,  533,  534,  535,  536,  537,
			  282, 1060, 1060,  282, 1060,  289, 1060, 1060,  272,  531,
			  532,  533,  534,  535,  536,  537,  855,  855,  855,  531,
			  532,  533,  534,  535,  536,  537,  856,  856,  856,  531, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  532,  533,  534,  535,  536,  537,  282, 1060, 1060,  282,
			 1060,  289, 1060,  283,  272, 1060,  283, 1060,  297, 1060,
			  283,  272, 1060,  283, 1060,  297, 1060, 1060,  272, 1060,
			 1060, 1060,  107, 1060, 1060,  552, 1060, 1060,  165,  107,
			  165,  165,  552,  165,  119,  857,  857,  857,  857,  107,
			  165, 1060,  552,  165,  339,  340,  341,  342,  343,  344,
			  345,  858,  290,  291,  292,  293,  294,  295,  296, 1060,
			  165, 1060,  165,  165, 1060,  165, 1060, 1060, 1060, 1060,
			 1060, 1044,  165, 1044, 1060,  165, 1045, 1045, 1045, 1045,
			  339,  340,  341,  342,  343,  344,  345, 1060,  290,  291,

			  292,  293,  294,  295,  296,  298,  299,  300,  301,  302,
			  303,  304,  298,  299,  300,  301,  302,  303,  304,  316,
			  317,  318,  319,  320,  321,  322,  316,  317,  318,  319,
			  320,  321,  322, 1060, 1060, 1060,  316,  317,  318,  319,
			  320,  321,  322, 1060,  339,  340,  341,  342,  343,  344,
			  345,  863,  863,  863,  863, 1060,  159,  159,  159, 1060,
			  159,  159,  159,  159,  165,  601,  872,  159,  159,  875,
			  873,  871,  159,  159,  159,  159,  165, 1060, 1060, 1060,
			  159, 1060, 1060, 1060, 1060,  159, 1060, 1060,  165,  165,
			  165,  602,  165,  165,  165,  165,  165,  601,  872,  165,

			  165,  876,  874,  872,  165,  165,  165,  165,  165,  874,
			  876, 1060,  165,  165,  159,  165, 1060,  165,  159, 1060,
			  165,  165,  165,  165, 1060,  165,  159,  165, 1060,  165,
			  159,  159,  165,  165,  159, 1060, 1060, 1060,  159,  165,
			 1060,  874,  876,  159, 1060,  165,  165,  165, 1060, 1060,
			  165,  877,  165,  165,  165,  165, 1060,  165,  165,  165,
			 1060,  165,  165,  165,  165,  165,  165,  165,  159,  165,
			  165,  165,  879,  878,  159,  165,  880,  881,  159,  165,
			  165,  882,  884,  878,  165,  159,  165,  883, 1060, 1060,
			  159,  159,  165, 1060,  159, 1060,  165, 1060,  159,  165,

			  165,  165,  159, 1060,  881,  878,  165,  159,  882,  881,
			  165,  165,  165,  882,  884,  885,  165,  165,  165,  884,
			 1060, 1060,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165, 1060, 1060,  165,  886,  159,  165,  888,  165,
			  159,  165,  165,  887,  165,  159, 1060,  886,  159,  159,
			  889, 1060,  891,  159,  165, 1060, 1060,  165, 1060,  165,
			 1060,  165,  159,  165, 1060,  159, 1060,  886,  165,  165,
			  888, 1060,  165,  165,  165,  888,  165,  165, 1060, 1060,
			  165,  165,  890,  890,  892,  165,  165, 1060, 1060,  165,
			 1060,  165,  159,  892,  165,  893,  159,  165,  894, 1060,

			  165,  165,  165,  159, 1060, 1060,  165,  159,  165,  159,
			 1060, 1060,  165, 1060,  165,  890,  898, 1060,  165, 1060,
			  159,  165,  895,  165,  165,  892,  165,  894,  165, 1060,
			  894, 1060,  165,  165,  165,  165, 1060, 1060,  165,  165,
			  165,  165, 1060,  165,  165,  165,  165, 1060,  898,  159,
			  165,  896,  165,  159,  896,  165,  159,  165,  165,  165,
			  159,  159,  897, 1060, 1060,  159,  159, 1060,  165,  165,
			  165, 1060, 1060,  159,  900,  165, 1060,  165,  899, 1060,
			  165,  165,  159,  896, 1060,  165,  159,  165,  165,  165,
			 1060,  165,  165,  165,  898,  901, 1060,  165,  165,  159,

			  165,  165,  165, 1060,  159,  165,  900,  165,  903,  902,
			  900, 1060,  165,  904,  165, 1060, 1060, 1060,  165,  165,
			  165,  159,  165,  906, 1060,  159,  165,  902,  165,  159,
			  159,  165,  165,  905,  159, 1060,  165, 1060,  165,  165,
			  904,  902,  159, 1060,  165,  904,  165,  159, 1060, 1060,
			 1060,  165,  165,  165,  165,  906,  165,  165,  165, 1060,
			  165,  165,  165,  159,  165,  906,  165,  159, 1060, 1060,
			  165,  907,  908,  910,  165,  165,  165,  165,  165,  165,
			  159,  159,  165,  909,  165,  159, 1060,  165,  165,  159,
			 1060, 1060, 1060,  159,  165,  165, 1060,  911,  159,  165,

			 1060, 1060, 1060,  908,  908,  910,  159,  165,  165,  165,
			  165, 1060,  165,  165,  165,  910,  165,  165,  159,  165,
			  165,  165,  159, 1060, 1060,  165,  165, 1060,  912,  912,
			  165,  165,  159,  165, 1060,  159,  913,  914,  165, 1060,
			  165,  159,  165,  165,  165,  159,  165, 1060, 1060,  159,
			  165, 1060,  165, 1060,  165, 1060,  165, 1060,  915,  165,
			  912,  165,  159,  165,  165,  165,  159,  165,  914,  914,
			 1060,  918, 1060,  165, 1060,  165,  165,  165,  165,  159,
			  165,  165,  165, 1060,  920,  917,  916,  165,  165,  165,
			  916,  165,  165,  165,  165,  165,  159,  165,  165,  165,

			  159,  922, 1060,  918,  919,  159, 1060,  165,  165,  921,
			  165,  165,  165,  159,  165, 1060,  920,  918,  916,  165,
			  165,  165,  159, 1060,  165, 1060,  159,  165,  165,  165,
			  923,  165,  165,  922, 1060, 1060,  920,  165, 1060,  165,
			  165,  922,  165,  159,  924,  165,  946,  946,  946,  946,
			 1060,  165,  165,  165,  165,  159,  159, 1060,  165,  159,
			  927,  928,  924,  165, 1060,  165, 1060,  165,  165, 1060,
			  165,  926,  925,  159, 1060,  165,  924,  165, 1060, 1060,
			  165, 1060, 1060,  165, 1060,  165,  865,  165,  165, 1060,
			 1060,  165,  928,  928,  159,  165, 1060,  165,  159,  165,

			  165, 1060,  165,  926,  926,  165,  165, 1060,  165,  165,
			 1060,  159,  165,  929,  930,  159,  159,  933,  165,  159,
			  159,  159, 1060, 1060, 1060, 1060,  165, 1060, 1060,  165,
			  165,  165,  159,  159,  159,  931, 1060,  932,  165, 1060,
			  165,  165, 1060,  165, 1060,  930,  930,  165,  165,  934,
			  165,  165,  165,  165,  159, 1060, 1060,  934,  159, 1060,
			  165,  165,  165,  165,  165,  165,  165,  932,  165,  932,
			  165,  159,  165,  165,  159, 1060, 1060, 1060,  159, 1060,
			  165, 1060,  935, 1060,  159,  165,  165,  165,  937,  934,
			  165,  159,  165,  936,  165,  522,  165,  165,  165, 1060,

			  165,  159,  165,  165,  165,  522,  165, 1060,  165,  159,
			  165, 1060,  165,  159,  936,  938,  165,  165,  530,  165,
			  938, 1060,  165,  165,  165,  936,  159,  530,  165,  165,
			  165,  159, 1060,  165,  165,  159, 1060,  165, 1060,  940,
			  165,  165, 1060,  107,  939,  165,  552,  938,  159,  165,
			  949,  949,  949,  949,  165,  119,  165, 1060,  165, 1060,
			 1060, 1060, 1060,  165, 1060, 1060,  165,  165, 1060,  165,
			 1060,  940, 1005, 1005, 1005, 1005,  940, 1060, 1060, 1060,
			  165,  165,  523,  524,  525,  526,  527,  528,  529, 1060,
			  760, 1060,  523,  524,  525,  526,  527,  528,  529,  863, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  863,  863,  863, 1060, 1060,  531,  532,  533,  534,  535,
			  536,  537,  865,  945,  531,  532,  533,  534,  535,  536,
			  537, 1060, 1060,  953,  953,  953,  953,  165, 1060,  165,
			  316,  317,  318,  319,  320,  321,  322,  954,  159,  165,
			  159,  956,  159, 1060,  955,  945, 1060,  159,  165, 1060,
			  165,  159, 1060, 1060,  165,  159,  165,  159,  159,  165,
			  165,  165,  159,  958,  159, 1060,  165,  957, 1060,  954,
			  165,  165,  165,  956,  165,  159,  956,  959, 1060,  165,
			  165, 1060,  165,  165, 1060, 1060,  165,  165,  165,  165,
			  165, 1060,  165,  159,  165,  958,  165,  159,  165,  958,

			  165,  159,  165, 1060,  165,  159,  165,  165,  960,  960,
			  159,  165,  165,  165,  962,  961,  165, 1060,  159,  165,
			 1060,  165,  159,  165, 1060,  165,  159,  964, 1060,  165,
			 1060,  165,  165,  165,  165, 1060,  165,  165,  165,  159,
			  960,  963,  165,  165,  165,  165,  962,  962,  165,  968,
			  165,  165,  159,  165,  165,  165,  965,  966,  165,  964,
			  165,  967,  165,  165,  165,  159,  165, 1060, 1060,  159,
			  159,  165,  165,  964,  159, 1060,  165, 1060,  159, 1060,
			 1060,  968,  159,  165,  165,  165,  159,  159,  966,  966,
			 1060, 1060,  165,  968,  165,  165,  165,  165,  165,  159,

			 1060,  165,  165,  159,  165, 1060,  165,  969,  165,  165,
			  165,  165,  159, 1060,  165,  165,  159,  165,  165,  165,
			  159,  165,  165,  970,  165, 1060, 1060,  165, 1060,  159,
			  165,  165,  165,  971,  165,  165,  972,  159, 1060,  970,
			 1060,  165,  165,  165,  165, 1060, 1060,  165,  165,  165,
			  159,  974,  165,  165,  165,  970,  165, 1060,  165,  165,
			  165,  165,  165,  159,  165,  972,  165,  973,  972,  165,
			  165,  159,  983, 1060,  165,  159,  159, 1060, 1060,  165,
			  159,  165,  165,  974,  165, 1060,  165, 1060,  159,  159,
			  165,  165,  165,  159, 1060,  165,  165,  159, 1060,  974,

			 1060, 1060,  165,  165,  984, 1060, 1060,  165,  165, 1060,
			  159,  975,  165, 1060, 1060,  165,  165,  165,  165,  159,
			  165,  165,  976,  159, 1060,  165, 1060,  165,  165,  165,
			 1060, 1060,  977,  165, 1060,  978,  159, 1060,  165, 1060,
			  165, 1060,  165,  976,  159,  165,  980,  165,  159,  165,
			  165,  165,  159, 1060,  976,  165,  159, 1060, 1060,  165,
			 1060,  159, 1060,  979,  978,  165, 1060,  978,  165,  159,
			  165,  981,  165,  165, 1060,  165,  165,  165,  980,  984,
			  165,  982,  165, 1060,  165,  165, 1060,  159,  165, 1060,
			  165,  159,  165,  165, 1060,  980, 1060, 1060, 1060, 1060,

			 1060,  165,  165,  982,  159,  165,  985,  165,  165, 1060,
			  165,  984, 1060,  982,  159, 1060,  986,  165,  159,  165,
			  165, 1060,  165,  165,  165, 1060,  159, 1060, 1060, 1060,
			  159,  159,  987,  165,  165,  165,  165,  165,  986,  165,
			  165, 1060,  165,  159,  988,  165,  165, 1060,  986,  165,
			  165, 1060,  165,  159, 1060, 1060, 1060,  159,  165, 1060,
			 1060, 1060,  165,  165,  988,  165,  989,  165, 1060,  165,
			  159,  165,  165, 1060,  990,  165,  988,  165,  159,  159,
			 1060,  165,  159,  159,  165,  165, 1060, 1060,  165,  165,
			  992,  991, 1060, 1060, 1060,  159,  159,  165,  990,  165,

			  165,  159,  165, 1060,  165,  993,  990, 1060,  159,  165,
			  165,  165,  159, 1060,  165,  165,  165,  994,  159, 1060,
			  165, 1060,  992,  992,  165,  159,  165,  165,  165,  165,
			  159,  165,  165,  165,  159,  159,  165,  994, 1060,  159,
			  165,  165,  159,  165,  165,  165,  159,  159, 1060,  994,
			  165,  165,  159,  165, 1060,  165,  165,  165,  165,  159,
			 1060,  995,  165,  165, 1060, 1060,  165,  165,  165, 1060,
			  165,  165,  165, 1060,  165,  165, 1060,  165,  165,  165,
			 1060, 1060,  165,  165,  165,  165,  165,  165,  165, 1060,
			 1060,  165,  159,  996,  996,  165,  159, 1060,  165,  165,

			 1060,  998,  165, 1060,  165,  997,  159, 1060, 1060,  159,
			  159,  165, 1060,  165,  165,  165, 1060,  159,  165, 1060,
			  165,  159, 1060,  159,  165,  165,  996,  165,  165,  165,
			  165,  165, 1060,  998,  159, 1000,  999,  998,  165,  165,
			 1060,  165,  165,  165, 1060,  165,  165,  165,  165,  165,
			 1060, 1060, 1060,  165, 1060,  165, 1060,  165,  165,  165,
			 1060,  165, 1009, 1009, 1009, 1009,  165, 1000, 1000,  159,
			 1060,  165, 1012,  159, 1013, 1060, 1007, 1060,  165,  159,
			  165, 1060,  165,  159,  165,  165,  159,  165, 1060, 1060,
			  165, 1060, 1060, 1015,  165,  159,  159,  165, 1014,  159,

			 1060,  165,  602, 1060, 1013,  165, 1013, 1060, 1007, 1060,
			 1060,  165,  159, 1060,  165,  165,  165,  165,  165,  165,
			  159, 1060, 1060, 1060,  159, 1015,  165,  165,  165,  165,
			 1015,  165, 1060, 1016,  165, 1060, 1017,  159,  159,  165,
			 1060,  165,  159, 1060,  165,  159,  165, 1060, 1018,  159,
			 1060,  165,  165, 1060, 1060,  159,  165, 1060, 1060, 1060,
			 1060, 1060,  159, 1060, 1060, 1017,  165, 1060, 1017,  165,
			  165,  165, 1060,  165,  165, 1060, 1019,  165,  165, 1060,
			 1019,  165, 1060,  165,  165, 1021,  165,  165,  159, 1020,
			 1060, 1060,  159, 1060,  165,  165,  165,  165,  159, 1060,

			 1060, 1022,  159, 1023, 1060,  159, 1060,  165, 1019, 1060,
			 1060,  165, 1060,  165, 1060,  159,  165, 1021,  165, 1060,
			  165, 1021, 1060,  165,  165, 1060, 1060,  165,  165,  165,
			  165, 1060, 1060, 1023,  165, 1023, 1025,  165,  165,  165,
			  159, 1060,  159,  165,  159,  165,  159,  165,  165,  159,
			  165, 1024,  165,  159,  159,  165, 1060,  159,  159,  159,
			 1026,  165,  165,  165, 1060, 1060,  159,  165, 1025,  165,
			  165,  159,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165, 1025,  165,  165,  165,  165, 1060,  165,
			  165,  165, 1027,  165,  165,  165,  159, 1027,  165,  165,

			  159,  165,  165,  165,  165,  165,  159,  165,  159,  165,
			  159,  165,  159,  159,  165,  165,  159, 1029, 1060,  165,
			 1030, 1028, 1060,  159, 1060,  159, 1060,  165,  165, 1027,
			 1060, 1060,  165,  159,  165, 1060,  165, 1060,  165,  159,
			  165, 1060,  165, 1034,  165,  165,  165,  165,  165, 1029,
			  159, 1031, 1031, 1029,  159,  165,  159,  165,  165,  165,
			  165, 1060, 1060, 1060, 1032,  165,  165,  159,  165, 1033,
			  165,  165, 1035, 1060, 1060, 1035, 1037, 1060,  165,  165,
			 1060,  165,  165, 1031, 1060,  165,  165,  165,  165,  159,
			  165,  165,  165,  159, 1060, 1060, 1033,  165,  165,  165, yy_Dummy>>,
			1, 1000, 8000)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  165, 1033,  165,  159, 1035, 1036,  159,  159, 1037, 1039,
			  165,  165,  165,  165,  165, 1060,  165,  165,  165,  165,
			  159,  165, 1060,  165,  165,  165,  159, 1060,  165,  165,
			 1038, 1060,  159, 1060, 1060,  165, 1040, 1037,  165,  165,
			 1060, 1039, 1060,  159,  165, 1060,  165, 1060,  165,  159,
			  165, 1060,  165,  159, 1041,  159,  165,  159,  165,  159,
			  165,  165, 1039,  165,  165,  165, 1060,  165, 1041, 1060,
			  159, 1060,  159,  165, 1060,  165, 1060,  165, 1060, 1060,
			 1060,  165, 1060, 1060, 1060,  165, 1041,  165, 1060,  165,
			  159,  165, 1060,  165, 1047,  165, 1060,  165, 1060,  165,

			 1060, 1060,  165, 1060,  165,  165, 1060,  159, 1060,  165,
			 1042, 1042, 1042, 1042,  948,  948,  948,  948, 1046, 1046,
			 1046, 1046,  165,  165, 1048,  165, 1048, 1060, 1007, 1060,
			  159,  165, 1060,  165,  159,  165,  165, 1060,  165,  165,
			 1060, 1060,  159,  165, 1060, 1060,  159,  159,  165,  165,
			  753,  165, 1060, 1060,  602,  165, 1048,  165,  760,  159,
			 1007,  165,  165,  165, 1060,  165,  165,  165,  165, 1060,
			  165, 1060,  159,  159,  165,  165,  159,  159,  165,  165,
			  165,  165, 1060,  165, 1049, 1050,  165,  165,  165,  159,
			  159,  165, 1060,  165,  165,  159,  165,  165,  165,  159,

			 1060,  165, 1060,  165,  165,  165,  165,  159,  165,  165,
			 1060,  159,  159,  165, 1060, 1060, 1050, 1050,  165,  165,
			  165,  165,  165, 1060,  159, 1060,  165,  165,  165,  165,
			  165,  165,  159,  165, 1060,  165,  159,  159,  165,  165,
			  165,  159,  165,  165,  165,  165,  159, 1060, 1052,  159,
			  159, 1051,  165,  165,  159,  165,  165, 1060, 1060,  165,
			 1060,  165, 1060, 1053,  165,  165, 1060, 1060,  165,  165,
			 1060,  165,  165,  165,  165,  159, 1060, 1060,  165,  159,
			 1052,  165,  165, 1052,  165,  165,  165,  165,  165, 1060,
			  165,  165,  159,  165, 1054, 1054, 1060,  165,  159, 1056,

			  165, 1060, 1055,  165, 1060, 1060,  165,  165,  165, 1060,
			  159,  165, 1060, 1060,  159,  159, 1060,  165,  165,  165,
			  165,  165,  165,  165,  165, 1060, 1054,  159, 1060,  165,
			  165, 1056,  165,  165, 1056,  159, 1060, 1060,  165,  159,
			  165, 1060,  165, 1060, 1060, 1060,  165,  165, 1060,  165,
			  165,  165,  159,  165,  165,  165,  165, 1060, 1060,  165,
			 1060,  165, 1060, 1060, 1060,  165,  165,  165, 1060, 1060,
			 1060,  165, 1001, 1001, 1001, 1001, 1057, 1057, 1057, 1057,
			 1008, 1008, 1008, 1008,  165,  159,  165,  159,  165,  159,
			 1059, 1058, 1060,  165, 1060,  165,  159,  165,  165,  165,

			  159, 1060,  159, 1060,  159,  165,  165,  159,  165,  165,
			 1060,  159,  753,  159, 1060, 1060,  865,  165,  165,  165,
			  760,  165, 1059, 1059,  159,  165, 1060,  165,  165,  165,
			 1060,  165,  165, 1060,  165, 1060,  165,  165,  165,  165,
			  165,  165,  159,  165, 1060,  165,  159, 1060, 1060,  165,
			  165,  165, 1043, 1043, 1043, 1043,  165, 1060,  159,  159,
			 1060,  165,  159, 1060,  165, 1060,  165, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060,  165,  159,  165, 1060,  165, 1060,
			 1060,  165, 1060,  165, 1060, 1060, 1060, 1060, 1060, 1060,
			  165,  165,  865,  165,  165, 1060,  165, 1060,  165, 1060,

			 1060, 1060, 1060, 1060, 1060, 1060, 1060,  165,  165,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,  106,  106, 1060,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  118, 1060, 1060, 1060, 1060,
			 1060, 1060,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  119,  119,
			 1060,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,

			  119,  127,  127, 1060,  127,  127,  127,  127, 1060,  127,
			  127,  127,  127,  127,  127,  127,  127,  127,  127,  127,
			  127,  127,  127,  127,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  251,  251,
			 1060,  251,  251,  251, 1060, 1060,  251,  251,  251,  251,
			  251,  251,  251,  251,  251,  251,  251,  251,  251,  251,
			  251,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  272, 1060, 1060,  272, 1060,
			  272,  272,  272,  272,  272,  272,  272,  272,  272,  272,
			  272,  272,  272,  272,  272,  272,  272,  272,  286,  286,

			 1060,  286,  286,  286,  286,  286,  286,  286,  286,  286,
			  286,  286,  286,  286,  286,  286,  286,  286,  286,  286,
			  286,  287,  287, 1060,  287,  287,  287,  287,  287,  287,
			  287,  287,  287,  287,  287,  287,  287,  287,  287,  287,
			  287,  287,  287,  287,  311,  311, 1060,  311,  311,  311,
			  311,  311,  311,  311,  311,  311,  311,  311,  311,  311,
			  311,  311,  311,  311,  311,  311,  311,  337, 1060, 1060,
			 1060, 1060,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  377,  377,  377,  377,  377,  377,  377,  377, 1060,  377,

			  377,  377,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  377,  377,  384,  384,  384,  384,  384,  384,  384,
			  384,  384,  384,  384,  384,  384,  386,  386,  386,  386,
			  386,  386,  386,  386,  386,  386,  386,  386,  386,  388,
			  388,  388,  388,  388,  388,  388,  388,  388,  388,  388,
			  388,  388,  282,  282, 1060,  282,  282,  282, 1060,  282,
			  282,  282,  282,  282,  282,  282,  282,  282,  282,  282,
			  282,  282,  282,  282,  282,  283,  283, 1060,  283,  283,
			  283, 1060,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  283,  952,  952,

			  952,  952,  952,  952,  952,  952, 1060,  952,  952,  952,
			  952,  952,  952,  952,  952,  952,  952,  952,  952,  952,
			  952,    5, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, yy_Dummy>>,
			1, 1000, 9000)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, yy_Dummy>>,
			1, 22, 10000)
		end

	yy_chk_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 10021)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
			yy_chk_template_11 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    3,    3,    3,    3,   23,   22,   23,   23,   23,
			   23,   24, 1043,    4,    4,    4,    4,   22, 1008,   24,
			   26,  147,   26,   26,   26,   26,   30,   30,   32,   32,
			 1001,   12,  612,   26,   12,   80,   80,   80,   15,  152,
			   16,   15,   16,   16,   82,   82,   82,   27,   16,   27,
			   27,   27,   27,  610,   40,   45,  608,    3,   40,   45,
			   83,   83,   26,  147,  388,   26,   84,   84,   84,    4,
			  386,   40,   45,   57,   57,   57,   57,   57,   57,   57,
			   12,  152,   24,   85,   85,   85,   40,   45,    3,   27,
			   40,   45,  384,    3,    3,    3,    3,    3,    3,    3,

			    4,  174,  174,   40,   45,    4,    4,    4,    4,    4,
			    4,    4,   12,  348,   88,  382,   88,   88,   12,   12,
			   12,   12,   12,   12,   12,   15,   15,   15,   15,   15,
			   15,   15,   16,   16,   16,   16,   16,   16,   16,   25,
			  284,   25,   25,   25,   25,  265,   43,   46,  262,  262,
			   43,   46,   25,   25,   35,   37,   35,  382,   37,   35,
			   43,   35,   37,   43,   46,   37,   35,   35,   37,  260,
			   88,   37,  148,  148,   25,  149,  149,  149,   43,   46,
			  177,   25,   43,   46,   25,   25,   35,   37,   35,  172,
			   37,   35,   43,   35,   37,   43,   46,   37,   35,   35,

			   37,   88,  128,   37,  104,  103,   25,   34,   34,   34,
			   34,  102,  148,  101,   89,  149,   86,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,  171,  171,  171,   81,   34,   54,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   33,   28,  140,  140,  140,
			  140,   34,   34,   34,   34,   34,   34,   34,   36,   36,
			   48,  140,  862,   36,   48,   36,   36,   48,   38,   36,

			   36,   36,   36,   38,   11,   38,   10,   48,    9,    8,
			   38,   38,  173,  173,  173,   38,    7,  140,  862,    5,
			   36,   36,   48,  140,  862,   36,   48,   36,   36,   48,
			   38,   36,   36,   36,   36,   38,   42,   38,    0,   48,
			   42,   39,   38,   38,   42,   39,    0,   38,   39,    0,
			   42,    0,   39,   42,    0,   39,    0,    0,   39,    0,
			    0,   39,   47,  175,  175,  175,   47,    0,   42,  176,
			  176,  176,   42,   39,  383,  383,   42,   39,    0,   47,
			   39,   47,   42,    0,   39,   42,    0,   39,   44,   44,
			   39,   41,   44,   39,   47,   41,   41,    0,   47,   44,

			    0,   44,   49,   41,   41,   44,   49,    0,   41,   41,
			    0,   47,   50,   47,  383,   49,   50,    0,    0,   49,
			   44,   44,    0,   41,   44,    0,   50,   41,   41,   50,
			    0,   44,    0,   44,   49,   41,   41,   44,   49,   51,
			   41,   41,    0,   51,   50,   52,   51,   49,   50,   52,
			  948,   49,   64,   59,   64,    0,   51,   61,   50,   52,
			    0,   50,   52,    0,   64,  607,  607,   61,  259,  259,
			  259,   51,  261,  261,  261,   51,  948,   52,   51,    0,
			    0,   52,  948,    0,   64,   59,   64,    0,   51,   61,
			    0,   52,    0,    0,   52,   58,   64,   70,    0,   61,

			   58,    0,   58,    0,   70,  607,   70,   58,   58,   59,
			   59,   59,   59,   59,   59,   59,   70,   61,   61,   61,
			   61,   61,   61,   61,  263,  263,  263,   58,    0,   70,
			    0,   62,   58,   62,   58,    0,   70,    0,   70,   58,
			   58,    0,    0,   62,   91,    0,   91,   91,   70,  264,
			  264,  264,    0,   58,   58,   58,   58,   58,   58,   58,
			   60,    0,   71,   62,   60,   62,    0,   60,    0,   71,
			   60,   71,    0,   60,    0,   62,    0,   71,  266,  266,
			  266,   71,    0,    0,   62,   62,   62,   62,   62,   62,
			   62,    0,   60,   63,   71,    0,   60,   63,    0,   60,

			   91,   71,   60,   71,   63,   60,   63,    0,    0,   71,
			   63,    0,    0,   71,    0,    0,   63,   60,   60,   60,
			   60,   60,   60,   60,    0,   63,   65,    0,    0,   63,
			    0,   91,   65,   65,   65,    0,   63,    0,   63,   65,
			   66,   68,   63,   66,   65,   66,   66,   67,   63,   67,
			   67,   68,    0,   68,    0,   66,    0,   68,   65,   67,
			  267,  267,  267,   68,   65,   65,   65,    0,   69,    0,
			   69,   65,   66,   68,   69,   66,   65,   66,   66,   67,
			   69,   67,   67,   68,   73,   68,   73,   66,   72,   68,
			    0,   67,   72,    0,   72,   68,   73,   75,   72,    0,

			   69,   75,   69,   75,   72,    0,   69,    0,   74,  268,
			  268,  268,   69,   75,    0,    0,   73,    0,   73,   74,
			   72,   74,   74,    0,   72,    0,   72,    0,   73,   75,
			   72,   74,    0,   75,    0,   75,   72,    0,    0,   90,
			   74,   90,   90,    0,   76,   75,   76,   76,  269,  269,
			  269,   74,   92,   74,   74,   92,   76,   92,    0,    0,
			   92,    0,    0,   74,   87,   87,   87,   87,   87,   87,
			   87,    0,   93,    0,    0,   93,   76,   93,   76,   76,
			   93,   94,   94,   94,   94,   94,   94,   94,   76,  270,
			  270,  270,  271,  271,  271,   90,   95,   95,   95,   95,

			   95,   95,   95,   95,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   97,   97,  127,   97,   97,   97,
			   97,   97,   97,   97,  119,    0,   90,  119,  403,  403,
			  403,   90,   90,   90,   90,   90,   90,   90,  120,    0,
			    0,  120,    0,    0,   92,   92,   92,   92,   92,   92,
			   92,   98,   98,   98,   98,   98,   98,   98,   98,   98,
			   98,  404,  404,  404,   93,   93,   93,   93,   93,   93,
			   93,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,  100,    0,    0,  100,  100,  100,  100,  100,  100,
			  100,  106,    0,    0,  106,  144,  144,  144,  144,  127, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  127,  127,  127,  127,  127,  127,  405,  405,  405,  144,
			    0,  119,  119,  119,  119,  119,  119,  119,    0,  145,
			    0,  145,  145,  145,  145,  120,  120,  120,  120,  120,
			  120,  120,  145,  146,    0,  146,  146,  146,  146,    0,
			  106,  144,    0,    0,  109,    0,  109,  109,    0,  109,
			    0,  151,  109,  151,  151,  151,  151,  110,    0,  110,
			  110,  145,  110,    0,  145,  110,  406,  406,  406,  159,
			    0,    0,  106,  159,    0,  146,    0,    0,  106,  106,
			  106,  106,  106,  106,  106,  108,  159,    0,  108,  108,
			  108,  108,    0,  151,  385,  385,  385,  108,  109,  111,

			    0,  159,  111,    0,  108,  159,  108,    0,  108,  108,
			  108,  110,    0,  108,  112,  108,    0,  112,  159,  108,
			    0,  108,    0,    0,  108,  108,  108,  108,  108,  108,
			  109,    0,  113,    0,  385,  113,  109,  109,  109,  109,
			  109,  109,  109,  110,  121,    0,    0,  121,  111,  110,
			  110,  110,  110,  110,  110,  110,    0,    0,  280,  114,
			  280,  280,  114,  112,  272,  272,  272,  272,  272,  272,
			  272,    0,  108,  108,  108,  108,  108,  108,  108,  115,
			  111,  113,  115,  407,  407,  407,  111,  111,  111,  111,
			  111,  111,  111,  116,    0,  112,  116,  408,  408,  408,

			  112,  112,  112,  112,  112,  112,  112,  112,  114,  117,
			    0,    0,  117,  113,  280,    0,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  122,    0,  115,  122,
			  121,  121,  121,  121,  121,  121,  121,  121,  123,    0,
			  114,  123,  116,  114,  114,  280,  114,  114,  114,  114,
			  114,  114,  114,  124,    0,    0,  124,    0,  117,    0,
			  115,  282,    0,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  125,  116,    0,  125,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,    0,  126,    0,
			  117,  126,    0,  117,    0,    0,  117,  117,  117,  117,

			  117,  117,  117,  273,  273,  273,  273,  273,  273,  273,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			    0,    0,  123,  123,    0,  123,  123,  123,  123,  123,
			  123,  123,    0,  281,    0,  281,  281,  124,  124,  124,
			  124,  124,  124,  124,  124,  124,  124,  130,  282,  282,
			  282,  282,  282,  282,  282,  131,    0,  125,  125,  125,
			  125,  125,  125,  125,  125,  125,  125,  132,  376,  376,
			  376,  376,  126,    0,  251,  126,  126,  126,  126,  126,
			  126,  126,  129,    0,    0,  129,  129,  129,  129,  281,
			  514,  514,  514,    0,  129,    0,  133,  515,  515,  515,

			    0,  129,    0,  129,    0,  129,  129,  129,  129,  134,
			  129,    0,  129,  516,  516,  516,  129,    0,  129,  135,
			  281,  129,  129,  129,  129,  129,  129,  130,  130,  130,
			  130,  130,  130,  130,  130,  130,  130,  131,  131,  131,
			  131,  131,  131,  131,  131,  136,    0,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  251,  251,  251,
			  251,  251,  251,  251,  517,  517,  517,    0,    0,  129,
			  129,  129,  129,  129,  129,  129,  133,  133,    0,  133,
			  133,  133,  133,  133,  133,  133,  518,  518,  518,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  135,

			  135,  135,  135,  135,  135,  135,  135,  135,  135,  274,
			  274,  274,  274,  274,  274,  274,  274,  519,  519,  519,
			    0,    0,  160,    0,    0,  136,  160,    0,  136,  136,
			  136,  136,  136,  136,  136,  150,  150,  150,  150,  160,
			  165,    0,  165,    0,    0,  150,  150,  150,  150,  150,
			  150,  161,  165,  162,  160,  161,  162,  162,  160,  161,
			    0,    0,  161,  288,    0,  288,  288,    0,  161,    0,
			  162,  160,  165,    0,  165,  150,    0,  150,  150,  150,
			  150,  150,  150,  161,  165,  162,  163,  161,  162,  162,
			  163,  161,  164,    0,  161,  180,  164,    0,  166,  180,

			  161,    0,  162,  163,  163,  166,  168,  166,    0,  164,
			  167,  164,  180,  167,  168,  167,  168,  166,  163,  288,
			    0,  170,  163,  170,  164,  167,  168,  180,  164,  170,
			  166,  180,    0,  170,    0,  163,  163,  166,  168,  166,
			    0,  164,  167,  164,  180,  167,  168,  167,  168,  166,
			  288,    0,  169,  170,  169,  170,  178,  167,  168,  169,
			  178,  170,    0,  181,  169,  170,  179,  181,  179,  520,
			  520,  520,  182,  178,  179,  178,  182,  183,  179,    0,
			  181,  183,    0,    0,  169,  182,  169,    0,  178,  182,
			    0,  169,  178,    0,  183,  181,  169,  184,  179,  181,

			  179,  184,    0,    0,  182,  178,  179,  178,  182,  183,
			  179,  185,  181,  183,  184,    0,    0,  182,  185,    0,
			  185,  182,    0,    0,  186,    0,  183,    0,    0,  184,
			  185,    0,  187,  184,  187,  186,  193,  186,  193,    0,
			    0,  191,  188,  185,  187,  191,  184,  186,  193,  188,
			  185,  188,  185,  189,    0,  189,  186,    0,  191,  189,
			    0,  188,  185,    0,  187,  189,  187,  186,  193,  186,
			  193,  194,    0,  191,  188,  194,  187,  191,    0,  186,
			  193,  188,    0,  188,    0,  189,    0,  189,  194,  194,
			  191,  189,  192,  188,  190,  190,  192,  189,  190,  190,

			    0,    0,  192,  194,  192,  195,    0,  194,  195,  195,
			  192,  190,    0,  190,  192,  201,  521,  521,  521,  201,
			  194,  194,  195,  195,  192,    0,  190,  190,  192,    0,
			  190,  190,  201,    0,  192,    0,  192,  195,    0,    0,
			  195,  195,  192,  190,  196,  190,  192,  201,  196,    0,
			  197,  201,  197,    0,  195,  195,    0,  197,  198,  196,
			    0,  196,  197,  196,  201,    0,  198,  199,  198,  199,
			  200,  199,    0,  198,  200,  199,  196,    0,  198,  199,
			  196,  200,  197,    0,  197,    0,    0,  200,    0,  197,
			  198,  196,    0,  196,  197,  196,    0,    0,  198,  199,

			  198,  199,  200,  199,  202,  198,  200,  199,  202,  204,
			  198,  199,  203,  200,  203,  625,  625,  625,  202,  200,
			  204,  202,  204,  205,  203,  205,  205,  626,  626,  626,
			  206,    0,  204,    0,  206,  205,  202,  727,  727,  727,
			  202,  204,    0,    0,  203,    0,  203,  206,    0,    0,
			  202,    0,  204,  202,  204,  205,  203,  205,  205,  207,
			    0,    0,  206,  207,  204,  209,  206,  205,  208,  209,
			  208,    0,  208,  210,  207,  210,  207,  208,  208,  206,
			    0,    0,  209,  208,    0,  210,  208,  597,  597,  597,
			  597,  207,  728,  728,  728,  207,    0,  209,    0,    0, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  208,  209,  208,    0,  208,  210,  207,  210,  207,  208,
			  208,    0,  214,    0,  209,  208,  214,  210,  208,  211,
			    0,  211,  214,  211,  215,  213,  215,  213,  215,  214,
			    0,  211,  599,  599,  599,  599,    0,  213,  215,    0,
			    0,  215,    0,    0,  214,    0,    0,    0,  214,    0,
			    0,  211,    0,  211,  214,  211,  215,  213,  215,  213,
			  215,  214,    0,  211,  212,    0,  212,    0,  212,  213,
			  215,    0,  212,  215,  212,  216,  216,  220,  216,  212,
			  217,  220,  212,    0,  212,  219,  218,  219,  216,  217,
			  218,  217,  217,  219,  220,  220,  212,  219,  212,    0,

			  212,  217,    0,  218,  212,  218,  212,  216,  216,  220,
			  216,  212,  217,  220,  212,    0,  212,  219,  218,  219,
			  216,  217,  218,  217,  217,  219,  220,  220,  221,  219,
			  252,  221,  221,  217,  222,  218,  222,  218,  222,  223,
			  224,    0,  224,  223,  226,  221,  227,  224,  227,  225,
			  228,  222,  224,  226,  228,  226,  223,  225,  227,  225,
			  221,    0,    0,  221,  221,  226,  222,  228,  222,  225,
			  222,  223,  224,    0,  224,  223,  226,  221,  227,  224,
			  227,  225,  228,  222,  224,  226,  228,  226,  223,  225,
			  227,  225,    0,  229,  230,    0,  230,  226,    0,  228,

			  229,  225,  229,  230,  230,    0,    0,  230,    0,  230,
			  230,    0,  229,  252,  252,  252,  252,  252,  252,  252,
			  602,  602,  602,  602,    0,  229,  230,    0,  230,    0,
			    0,    0,  229,    0,  229,  230,  230,    0,    0,  230,
			    0,  230,  230,    0,  229,  231,    0,  231,  603,  603,
			  603,  603,  232,  231,    0,  231,  232,    0,  231,    0,
			  231,  231,    0,  232,  233,  231,    0,  232,  233,  232,
			  234,    0,  234,    0,  234,    0,    0,  231,    0,  231,
			    0,  233,  234,    0,  232,  231,    0,  231,  232,    0,
			  231,    0,  231,  231,  236,  232,  233,  231,  236,  232,

			  233,  232,  234,  235,  234,  235,  234,    0,  237,  235,
			  238,  236,  237,  233,  234,  235,  242,  238,    0,  238,
			  242,    0,  239,    0,  239,  237,  236,    0,  237,  238,
			  236,  239,    0,  242,  239,  235,    0,  235,    0,    0,
			  237,  235,  238,  236,  237,    0,    0,  235,  242,  238,
			    0,  238,  242,    0,  239,    0,  239,  237,  246,    0,
			  237,  238,  246,  239,  240,  242,  239,  240,  240,  241,
			    0,    0,  240,    0,  241,  246,  243,  241,  248,  241,
			  243,  240,  248,  240,  243,  241,  244,    0,  244,  241,
			  246,    0,  244,  243,  246,  248,  240,  253,  244,  240,

			  240,  241,    0,    0,  240,    0,  241,  246,  243,  241,
			  248,  241,  243,  240,  248,  240,  243,  241,  244,  254,
			  244,  241,  247,  245,  244,  243,  245,  248,  245,  247,
			  244,  247,  255,  249,  392,  249,  392,    0,  245,  249,
			    0,  247,  256,    0,    0,  249,  392,  753,  753,  753,
			  753,    0,  257,    0,  247,  245,    0,    0,  245,    0,
			  245,  247,  258,  247,    0,  249,  392,  249,  392,    0,
			  245,  249,    0,  247,  609,  609,  609,  249,  392,  253,
			  253,  253,  253,  253,  253,  253,  253,  275,  275,  275,
			  275,  275,  275,  275,  275,  275,  275,    0,    0,  254,

			  254,  254,  254,  254,  254,  254,  254,  254,  254,  283,
			    0,    0,  255,  255,  609,  255,  255,  255,  255,  255,
			  255,  255,  256,  256,  256,  256,  256,  256,  256,  256,
			  256,  256,  257,  257,  257,  257,  257,  257,  257,  257,
			  257,  257,  258,    0,    0,  258,  258,  258,  258,  258,
			  258,  258,  276,  276,    0,  276,  276,  276,  276,  276,
			  276,  276,  277,  277,  277,  277,  277,  277,  277,  277,
			  277,  277,  278,  278,  278,  278,  278,  278,  278,  278,
			  278,  278,  279,    0,    0,  279,  279,  279,  279,  279,
			  279,  279,  285,    0,  285,  285,  283,  283,  283,  283,

			  283,  283,  283,  286,    0,    0,  286,    0,  286,    0,
			  287,  286,    0,  287,    0,  287,    0,    0,  287,  289,
			  289,  289,  289,  289,  289,  289,  290,    0,    0,  290,
			    0,  290,    0,    0,  290,  291,    0,    0,  291,    0,
			  291,    0,    0,  291,    0,    0,  292,    0,  285,  292,
			    0,  292,    0,    0,  292,    0,  293,    0,    0,  293,
			    0,  293,    0,    0,  293,    0,  294,    0,    0,  294,
			  375,  294,  375,    0,  294,  375,  375,  375,  375,  285,
			    0,  396,    0,  396,  285,  285,  285,  285,  285,  285,
			  285,    0,    0,  396,    0,  286,  286,  286,  286,  286,

			  286,  286,  287,  287,  287,  287,  287,  287,  287,  295,
			    0,    0,  295,  396,  295,  396,    0,  295,  290,  290,
			  290,  290,  290,  290,  290,  396,  291,  291,  291,  291,
			  291,  291,  291,  291,    0,  292,  292,  292,  292,  292,
			  292,  292,  292,  292,  292,  293,  293,    0,  293,  293,
			  293,  293,  293,  293,  293,  294,  294,  294,  294,  294,
			  294,  294,  294,  294,  294,  296,    0,    0,  296,    0,
			  296,    0,    0,  296,  297,  297,  297,  297,  297,  297,
			  297,  298,    0,    0,  298,  398,  298,  398,    0,  298,
			  305,  305,  305,  305,  305,  305,  305,  398,  295,  295,

			  295,  295,  295,  295,  295,  295,  295,  295,  299,    0,
			    0,  299,    0,  299,    0,    0,  299,  398,  300,  398,
			    0,  300,    0,  300,    0,    0,  300,    0,  301,  398,
			    0,  301,    0,  301,    0,    0,  301,    0,  302,    0,
			    0,  302,    0,  302,    0,    0,  302,    0,  303,    0,
			    0,  303,    0,  303,  296,    0,  303,  296,  296,  296,
			  296,  296,  296,  296,  304,    0,    0,  304,    0,  304,
			    0,    0,  304,  298,  298,  298,  298,  298,  298,  298,
			  306,  306,  306,  306,  306,  306,  306,  307,  307,  307,
			  307,  307,  307,  307,  754,  754,  754,  754,    0,  299,

			  299,  299,  299,  299,  299,  299,  299,  300,  300,  300,
			  300,  300,  300,  300,  300,  300,  300,  301,  301,    0,
			  301,  301,  301,  301,  301,  301,  301,  302,  302,  302,
			  302,  302,  302,  302,  302,  302,  302,  303,  303,  303,
			  303,  303,  303,  303,  303,  303,  303,  311,    0,    0,
			  311,    0,    0,  304,    0,    0,  304,  304,  304,  304,
			  304,  304,  304,  308,  308,  308,  308,  308,  308,  308,
			  309,  309,  309,  309,  309,  309,  309,  309,  309,  309,
			  310,  310,  310,  310,  310,  310,  310,  310,  310,  310,
			  312,    0,    0,  312,    0,    0,    0,  313,    0,    0, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  313,    0,    0,    0,  314,    0,    0,  314,    0,    0,
			    0,  315,    0,    0,  315,    0,    0,  314,  314,  314,
			  314,  316,    0,  381,  316,  381,  381,  381,  381,  317,
			    0,    0,  317,    0,  311,  311,  311,  311,  311,  311,
			  311,  318,    0,    0,  318,  756,  756,  756,  756,    0,
			  379,  319,  379,    0,  319,  379,  379,  379,  379,    0,
			    0,  320,    0,    0,  320,  381,  598,  598,  598,  598,
			    0,  321,    0,    0,  321,    0,    0,  312,  312,  312,
			  312,  312,  312,  312,  313,  313,  313,  313,  313,  313,
			  313,  314,  314,  314,  314,  314,  314,  314,  315,  315,

			  315,  315,  315,  315,  315,    0,  598,    0,  316,  316,
			  316,  316,  316,  316,  316,  317,  317,  317,  317,  317,
			  317,  317,  317,    0,    0,  318,  318,  318,  318,  318,
			  318,  318,  318,  318,  318,  319,  319,    0,  319,  319,
			  319,  319,  319,  319,  319,  320,  320,  320,  320,  320,
			  320,  320,  320,  320,  320,  321,  321,  321,  321,  321,
			  321,  321,  321,  321,  321,  322,    0,    0,  322,  374,
			  374,  374,  374,  323,    0,  323,  323,    0,  323,    0,
			    0,  323,    0,  374,    0,    0,  324,  400,  324,  324,
			  400,  324,  400,    0,  324,    0,  378,  378,  378,  378,

			    0,  389,  400,  389,  389,  389,  389,    0,    0,  374,
			  378,  325,    0,    0,  325,  374,    0,    0,    0,  400,
			    0,    0,  400,    0,  400,  326,    0,  323,  326,    0,
			  751,  751,  751,  751,  400,    0,  378,    0,  327,    0,
			  324,  327,  378,  389,  751,    0,    0,    0,  331,  322,
			    0,  331,  322,  322,  322,  322,  322,  322,  322,  323,
			  325,  328,    0,    0,  328,  323,  323,  323,  323,  323,
			  323,  323,  324,  393,  326,    0,  751,  393,  324,  324,
			  324,  324,  324,  324,  324,  329,    0,  327,  329,    0,
			  393,    0,  325,  332,    0,    0,  332,    0,  325,  325,

			  325,  325,  325,  325,  325,  393,  326,    0,  330,  393,
			  328,  330,  326,  326,  326,  326,  326,  326,  326,  327,
			  333,    0,  393,  333,    0,  327,  327,  327,  327,  327,
			  327,  327,  337,    0,  329,  331,  331,  331,  331,  331,
			  331,  331,  328,  334,    0,    0,  334,    0,  328,  328,
			  328,  328,  328,  328,  328,  335,    0,  330,  335,  758,
			  758,  758,  758,    0,    0,  336,  329,    0,  336,  329,
			  329,  329,  329,  329,  329,  329,  329,  329,  329,  339,
			  332,  332,  332,  332,  332,  332,  332,  340,    0,  330,
			    0,    0,  330,  330,  330,  330,  330,  330,  330,  330,

			  330,  330,  341,  760,  760,  760,  760,  333,  333,  333,
			  333,  333,  333,  333,  342,  337,  337,  337,  337,  337,
			  337,  337,    0,    0,  343,  861,  861,  861,  861,    0,
			  334,  334,  334,  334,  334,  334,  334,  344,    0,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  345,
			    0,    0,  339,  339,  339,  339,  339,  339,  339,  340,
			  340,  340,  340,  340,  340,  340,  340,  346,  865,  865,
			  865,  865,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  347,    0,  342,  342,    0,  342,  342,  342,

			  342,  342,  342,  342,  343,  343,  343,  343,  343,  343,
			  343,  343,  343,  343,  349,    0,    0,  344,  344,  344,
			  344,  344,  344,  344,  344,  344,  344,  350,  380,    0,
			  380,  380,  380,  380,  866,  866,  866,  866,    0,  345,
			  351,  380,  345,  345,  345,  345,  345,  345,  345,  351,
			  351,  351,  351,  352,  868,  868,  868,  868,    0,    0,
			  346,  346,  346,  346,  346,  346,  346,  353,    0,    0,
			  380,    0,    0,  380,  354,  347,  347,  347,  347,  347,
			  347,  347,  355,  941,  941,  941,  941,    0,    0,  356,
			  390,    0,  390,  390,  390,  390,  357,  349,  349,  349,

			  349,  349,  349,  349,  358,  604,  604,  604,  604,    0,
			  350,  350,  350,  350,  350,  350,  350,  359,  942,  942,
			  942,  942,    0,  351,  351,  351,  351,  351,  351,  351,
			  360,    0,  390,    0,    0,    0,  352,  352,  352,  352,
			  352,  352,  352,  361,    0,  604,  943,  943,  943,  943,
			  353,  353,  353,  353,  353,  353,  353,  354,  354,  354,
			  354,  354,  354,  354,  362,  355,  355,  355,  355,  355,
			  355,  355,  356,  356,  356,  356,  356,  356,  356,  357,
			  357,  357,  357,  357,  357,  357,  363,  358,  358,  358,
			  358,  358,  358,  358,  364,  596,  596,  596,  596,    0,

			  359,  359,  359,  359,  359,  359,  359,  365,  394,  596,
			    0,    0,  394,  360,  360,  360,  360,  360,  360,  360,
			  366,  752,  752,  752,  752,  394,  361,  361,  361,  361,
			  361,  361,  361,  367,    0,  596,  947,  947,  947,  947,
			  394,  596,    0,  368,  394,    0,    0,  362,  362,  362,
			  362,  362,  362,  362,  369,    0,    0,  394,    0,    0,
			  601,  752,  601,    0,  370,  601,  601,  601,  601,  363,
			  363,  363,  363,  363,  363,  363,  371,  364,  364,  364,
			  364,  364,  364,  364,    0,    0,  372,    0,    0,    0,
			  365,  365,  365,  365,  365,  365,  365,  373,  949,  949,

			  949,  949,    0,  366,  366,  366,  366,  366,  366,  366,
			  950,  950,  950,  950,    0,    0,  367,  367,  367,  367,
			  367,  367,  367,  368,  368,  368,  368,  368,  368,  368,
			  368,  368,  368,    0,  369,  369,  369,  369,  369,  369,
			  369,  369,  369,  369,  370,  370,  370,  370,  370,  370,
			  370,  370,  370,  370,    0,    0,  371,  371,  371,  371,
			  371,  371,  371,  371,  371,  371,  372,  372,  372,  372,
			  372,  372,  372,  372,  372,  372,    0,  373,  373,  373,
			  373,  373,  373,  373,  373,  373,  373,  387,  387,  387,
			  387,    0,  391,  395,    0,    0,  391,  387,  387,  387,

			  387,  387,  387,  397,  395,  391,  395,  397,    0,  391,
			    0,    0,  761,  761,  761,  761,  395,    0,    0,    0,
			  397,    0,    0,    0,  391,  395,  761,  387,  391,  387,
			  387,  387,  387,  387,  387,  397,  395,  391,  395,  397,
			  401,  391,  399,  402,  401,  409,  399,    0,  395,  409,
			  399,  410,  397,  410,  402,    0,  402,  401,  761,  399,
			  402,    0,  409,  410,    0,    0,  402,  411,    0,  411,
			    0,  411,  401,    0,  399,  402,  401,  409,  399,    0,
			    0,  409,  399,  410,  411,  410,  402,    0,  402,  401,
			    0,  399,  402,  412,  409,  410,    0,    0,  402,  411, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  411,  412,  411,  412,  413,  414,  415,  414,  413,
			    0,  415,    0,  414,  412,    0,  411,  416,  414,  416,
			    0,    0,  413,  413,  415,  412,    0,  416,  415,  416,
			    0,  417,    0,    0,  412,  417,  412,  413,  414,  415,
			  414,  413,    0,  415,    0,  414,  412,    0,  417,  416,
			  414,  416,    0,  418,  413,  413,  415,    0,  419,  416,
			  415,  416,  419,  417,  418,    0,  418,  417,    0,    0,
			    0,  420,    0,  420,  422,  419,  418,  420,  422,    0,
			  417,    0,  421,  420,  423,  418,  421,    0,  423,    0,
			  419,  422,    0,    0,  419,    0,  418,    0,  418,  421,

			    0,  423,  421,  420,    0,  420,  422,  419,  418,  420,
			  422,    0,    0,    0,  421,  420,  423,  424,  421,  424,
			  423,  425,    0,  422,  426,    0,  424,    0,  425,  424,
			  425,  421,    0,  423,  421,  426,    0,  426,  427,    0,
			  425,    0,  427,    0,    0,  428,  429,  426,    0,  424,
			  429,  424,  428,  425,  428,  427,  426,    0,  424,    0,
			  425,  424,  425,  429,  428,    0,    0,  426,    0,  426,
			  427,  430,  425,    0,  427,  430,    0,  428,  429,  426,
			    0,  431,  429,  431,  428,    0,  428,  427,  430,    0,
			  432,  430,  432,  431,  433,  429,  428,  434,  433,  432,

			    0,  434,  432,  430,    0,  435,    0,  430,  433,    0,
			    0,  433,    0,  431,  434,  431,  435,    0,  435,  435,
			  430,    0,  432,  430,  432,  431,  433,    0,  435,  434,
			  433,  432,    0,  434,  432,  436,    0,  435,    0,    0,
			  433,  437,  436,  433,  436,  437,  434,    0,  435,  439,
			  435,  435,    0,  439,  436,    0,    0,    0,  437,  437,
			  435,    0,    0,  438,    0,  438,  439,  436,  439,    0,
			  438,    0,    0,  437,  436,  438,  436,  437,    0,    0,
			  440,  439,  440,    0,    0,  439,  436,    0,  440,    0,
			  437,  437,  440,    0,    0,  438,    0,  438,  439,    0,

			  439,  441,  438,    0,    0,  441,    0,  438,    0,  442,
			  442,  442,  440,  441,  440,    0,    0,  444,  441,  444,
			  440,  442,    0,  442,  440,    0,  441,  443,    0,  444,
			  445,  443,    0,  441,  445,    0,    0,  441,  443,    0,
			    0,  442,  442,  442,  443,  441,    0,  445,  446,  444,
			  441,  444,  446,  442,    0,  442,  446,    0,  441,  443,
			  447,  444,  445,  443,  447,  446,  445,    0,  448,  449,
			  443,    0,  448,  449,    0,    0,  443,  447,    0,  445,
			  446,    0,    0,  448,  446,  448,  449,    0,  446,    0,
			    0,    0,  447,    0,    0,    0,  447,  446,    0,    0,

			  448,  449,  455,  450,  448,  449,  455,  452,  451,  447,
			  450,  451,  450,  451,  452,  448,  452,  448,  449,  455,
			    0,    0,  450,  451,    0,  453,  452,  453,    0,  453,
			  951,  951,  951,  951,  455,  450,    0,  453,  455,  452,
			  451,    0,  450,  451,  450,  451,  452,    0,  452,  454,
			    0,  455,    0,    0,  450,  451,  456,  453,  452,  453,
			  454,  453,  454,  456,    0,  456,  457,  458,    0,  453,
			  457,  458,  454,    0,    0,  456,  461,    0,  459,    0,
			  461,  454,  458,  457,  458,    0,    0,    0,  456,  459,
			    0,  459,  454,  461,  454,  456,  465,  456,  457,  458,

			  465,  459,  457,  458,  454,    0,    0,  456,  461,    0,
			  459,    0,  461,  465,  458,  457,  458,  462,  460,    0,
			  460,  459,  460,  459,  462,  461,  462,  463,  465,    0,
			  460,  463,  465,  459,    0,  464,  462,  464,  464,    0,
			    0,  463,    0,    0,  463,  465,    0,  464,    0,  462,
			  460,    0,  460,  466,  460,  466,  462,  467,  462,  463,
			    0,  467,  460,  463,    0,  466,    0,  464,  462,  464,
			  464,  468,    0,  463,  467,    0,  463,    0,  468,  464,
			  468,    0,    0,    0,  471,  466,    0,  466,  471,  467,
			  468,  472,    0,  467,  469,  472,  469,  466,  469,  469,

			    0,  471,    0,  468,  470,    0,  467,  470,  472,    0,
			  468,  469,  468,  470,    0,  470,  471,  473,    0,    0,
			  471,  473,  468,  472,    0,  470,  469,  472,  469,    0,
			  469,  469,    0,  471,  473,    0,  470,  476,  474,  470,
			  472,  476,  474,  469,  475,  470,  475,  470,  475,  473,
			    0,    0,    0,  473,  476,  474,  477,  470,  474,    0,
			    0,  475,    0,  477,  475,  477,  473,    0,    0,  476,
			  474,  479,  478,  476,  474,  477,  475,    0,  475,  478,
			  475,  478,  479,    0,  479,    0,  476,  474,  477,    0,
			  474,  478,    0,  475,  479,  477,  475,  477,    0,  481,

			  480,    0,  480,  479,  478,    0,    0,  477,  481,  480,
			  481,  478,  480,  478,  479,    0,  479,  481,  483,    0,
			  481,  484,  483,  478,    0,  484,  479,  482,    0,  482,
			    0,  481,  480,  482,  480,  483,  485,    0,  484,  482,
			  481,  480,  481,  485,  480,  485,    0,    0,    0,  481,
			  483,  486,  481,  484,  483,  485,    0,  484,    0,  482,
			    0,  482,  486,    0,  486,  482,    0,  483,  485,  489,
			  484,  482,  487,  489,  486,  485,  487,  485,    0,  490,
			  487,  490,  489,  486,    0,  488,  489,  485,  488,  487,
			  488,  490,    0,  491,  486,    0,  486,  491,  493,    0,

			  488,  489,  493,    0,  487,  489,  486,    0,  487,    0,
			  491,  490,  487,  490,  489,  493,    0,  488,  489,  492,
			  488,  487,  488,  490,    0,  491,  492,  494,  492,  491,
			  493,  494,  488,  495,  493,    0,    0,  495,  492,    0,
			    0,  495,  491,  494,  494,  496,    0,  493,    0,    0,
			  495,  492,  496,    0,  496,    0,    0,    0,  492,  494,
			  492,    0,    0,  494,  496,  495,  497,    0,  497,  495,
			  492,  497,    0,  495,    0,  494,  494,  496,  497,  504,
			  498,  504,  495,  498,  496,  498,  496,  500,    0,  499,
			  500,  504,  500,  499,  523,  498,  496,  499,  497,    0,

			  497,  501,  500,  497,  501,  501,  499,  508,    0,    0,
			  497,  504,  498,  504,  509,  498,    0,  498,  501,  500,
			  502,  499,  500,  504,  500,  499,  510,  498,  502,  499,
			  502,  503,    0,  501,  500,  503,  501,  501,  499,  505,
			  502,  511,    0,  505,  503,  506,    0,  506,  503,    0,
			  501,  512,  502,    0,    0,    0,  505,  506,    0,    0,
			  502,  513,  502,  503,    0,  524,    0,  503,    0,    0,
			    0,  505,  502,    0,    0,  505,  503,  506,  525,  506,
			  503,  523,  523,  523,  523,  523,  523,  523,  505,  506,
			  508,  508,  508,  508,  508,  508,  508,  509,  509,  509, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  509,  509,  509,  509,  526, 1002, 1002, 1002, 1002,  510,
			  510,  510,  510,  510,  510,  510,  527, 1004, 1004, 1004,
			 1004,    0,    0,  531,  511,  511,  511,  511,  511,  511,
			  511,  512,  512,  512,  512,  512,  512,  512,  512,  512,
			  512,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  524,  524,  524,  524,  524,  524,  524,  524,  528,
			    0,    0,  525,  525,  525,  525,  525,  525,  525,  525,
			  525,  525,  529,  550,  550,  550,  550,  550,  550,  550,
			  532,  551,  551,  551,  551,  551,  551,  551,  526,  526,
			  533,  526,  526,  526,  526,  526,  526,  526,    0,    0,

			  527,  527,  527,  527,  527,  527,  527,  527,  527,  527,
			  531,  531,  531,  531,  531,  531,  531,  534,  757,  757,
			  757,  757,    0,  859,    0,  859,    0,  535,  859,  859,
			  859,  859,    0,  869,    0,  869,    0,  536,  869,  869,
			  869,  869,    0,  528,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  537,    0,    0,  529,    0,  757,  529,
			  529,  529,  529,  529,  529,  529,  532,  532,  532,  532,
			  532,  532,  532,  532,  533,  533,  533,  533,  533,  533,
			  533,  533,  533,  533,  538,    0,    0,  538,    0,  538,
			    0,  539,  538,    0,  539,    0,  539,    0,    0,  539,

			    0,  534,  534,    0,  534,  534,  534,  534,  534,  534,
			  534,  535,  535,  535,  535,  535,  535,  535,  535,  535,
			  535,  536,  536,  536,  536,  536,  536,  536,  536,  536,
			  536,  540,    0,    0,  540,    0,  540,  537,    0,  540,
			  537,  537,  537,  537,  537,  537,  537,  541,    0,    0,
			  541,    0,  541,    0,    0,  541,    0,  542,    0,    0,
			  542,    0,  542,    0,    0,  542,    0,  543,    0,    0,
			  543,    0,  543,    0,    0,  543,  538,  538,  538,  538,
			  538,  538,  538,  539,  539,  539,  539,  539,  539,  539,
			  544,    0,    0,  544,    0,  544,    0,  545,  544,    0,

			  545,    0,  545,    0,  546,  545,    0,  546,    0,  546,
			    0,  547,  546,    0,  547,    0,  547,    0,    0,  547,
			    0,    0,    0,  540,  540,  540,  540,  540,  540,  540,
			  548,    0,    0,  548,    0,  548,    0,    0,  548,  541,
			  541,  541,  541,  541,  541,  541,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  543,  543,  543,  543,
			  543,  543,  543,  543,  543,  543,  549,    0,    0,  549,
			    0,  549,    0,    0,  549,    0,    0,    0,  552,    0,
			    0,  552,  544,  544,  544,  544,  544,  544,  544,  545,
			  545,  545,  545,  545,  545,  545,  546,  546,  546,  546,

			  546,  546,  546,  547,  547,  547,  547,  547,  547,  547,
			  553,    0,  606,  553,  606,  606,  606,  606,    0,  548,
			  548,  548,  548,  548,  548,  548,  548,  548,  548,  554,
			    0,    0,  554,    0,    0,    0,  556,    0,    0,  556,
			    0,  554,  554,  554,  554,  554,  555,    0,    0,  555,
			 1005, 1005, 1005, 1005,  606,  549,  549,  549,  549,  549,
			  549,  549,  549,  549,  549,  552,  552,  552,  552,  552,
			  552,  552,  555,  557,    0,    0,  557,    0,    0,    0,
			  558,    0,    0,  558,    0,    0,    0,  559,    0,  613,
			  559,  613,  613,  613,  613,    0,    0,  553,  553,  553,

			  553,  553,  553,  553,  560,    0,  614,  560,  614,  614,
			  614,  614,  759,  759,  759,  759,  554,  554,  554,  554,
			  554,  554,  554,  556,  556,  556,  556,  556,  556,  556,
			  566,  613,    0,  555,  555,  555,  555,  555,  555,  555,
			  561,    0,    0,  561, 1006, 1006, 1006, 1006,  614,    0,
			    0,    0,  759,  562,    0,    0,  562,    0,    0,    0,
			  557,  557,  557,  557,  557,  557,  557,  558,  558,  558,
			  558,  558,  558,  558,  559,  559,  559,  559,  559,  559,
			  559,  564,    0,    0,  564,    0,    0,    0,  560,  560,
			  560,  560,  560,  560,  560,  560,  560,  560,  563,    0,

			    0,  563,  562,    0,    0,  565,    0,    0,  565,  600,
			  600,  600,  600,  566,  566,  566,  566,  566,  566,  566,
			  567,    0,    0,  600,  561,  561,  561,  561,  561,  561,
			  561,  561,  561,  561,  562,  568,  860,  860,  860,  860,
			  562,  562,  562,  562,  562,  562,  562,  563,  569,  600,
			 1010, 1010, 1010, 1010,    0,  600,    0,  762,  570,  762,
			  762,  762,  762,    0,    0,  725,    0,    0,  564,  564,
			  564,  564,  564,  564,  564,  571,  860,    0,    0,  563,
			    0,    0,  726,    0,    0,  563,  563,  563,  563,  563,
			  563,  563,  565,  565,  565,  565,  565,  565,  565,  762,

			    0,    0,  577,  567,  567,  567,  567,  567,  567,  567,
			  577,  577,  577,  577,  577,  594,    0,    0,  568,  568,
			  568,  568,  568,  568,  568,  595, 1044, 1044, 1044, 1044,
			    0,  569,  569,  569,  569,  569,  569,  569,  570,  570,
			  570,  570,  570,  570,  570,  570,  570,  570,  725,  725,
			  725,  725,  725,  725,  725,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  726,  726,  726,  726,  726,
			  726,  726,    0,    0,    0,    0,    0,    0,    0,  605,
			    0,  605,  605,  605,  605,  577,  577,  577,  577,  577,
			  577,  577,  605,    0,    0,  594,  594,  594,  594,  594,

			  594,  594,  594,  594,  594,  595,  595,  595,  595,  595,
			  595,  595,  595,  595,  595,  615,    0,    0,  616,  615,
			  616,  605,    0,  617,  605,    0,  616,  617,    0,    0,
			  616,  618,  615,  618,  615,    0,    0,    0,  618,    0,
			  617,  617,    0,  618,    0,    0,    0,  615,    0,    0,
			  616,  615,  616,    0,    0,  617,    0,    0,  616,  617,
			    0,    0,  616,  618,  615,  618,  615,  621,  623,  621,
			  618,  621,  617,  617,  619,  618,  620,  623,  619,  623,
			  619,  620,  624,  620,  621,  624,    0,  624,  622,  623,
			    0,  619,  622,  620,    0,    0,  622,  624,    0,  621,

			  623,  621,    0,  621,    0,  622,  619,    0,  620,  623,
			  619,  623,  619,  620,  624,  620,  621,  624,    0,  624,
			  622,  623,  627,  619,  622,  620,  627,    0,  622,  624,
			  628,  628,  627,  628,  629,    0,  631,  622,  629,  627,
			  631,    0,    0,  628,    0,    0,    0,    0,  630,    0,
			  630,  629,  629,  631,  627,  630,    0,    0,  627,    0,
			  630,    0,  628,  628,  627,  628,  629,  632,  631,    0,
			  629,  627,  631,    0,  632,  628,  632,  633,    0,    0,
			  630,  633,  630,  629,  629,  631,  632,  630,  638,  634,
			    0,  634,  630,  638,  633,  638,  633,  634,  635,  632, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  634,  635,  636,    0,  638,  632,  639,  632,  633,
			  636,  639,  636,  633,    0,  635,    0,    0,  632,    0,
			  638,  634,  636,  634,  639,  638,  633,  638,  633,  634,
			  635,    0,  637,  634,  635,  636,  637,  638,  637,  639,
			    0,    0,  636,  639,  636,    0,  640,  635,  640,  637,
			    0,    0,  640,    0,  636,  641,  639,  641,  640,  641,
			    0,    0,  642,    0,  637,  645,    0,    0,  637,  645,
			  637,  642,  641,  642,    0,    0,    0,    0,  640,    0,
			  640,  637,  645,  642,  640,    0,    0,  641,    0,  641,
			  640,  641,  643,    0,  642,    0,  643,  645,    0,    0,

			  643,  645,  648,  642,  641,  642,  648,  644,    0,  643,
			  644,  646,  644,  646,  645,  642,  647,  646,    0,  648,
			  647,    0,  644,  646,  643,  649,    0,  649,  643,  647,
			    0,    0,  643,  647,  648,    0,    0,  649,  648,  644,
			    0,  643,  644,  646,  644,  646,  651,    0,  647,  646,
			  651,  648,  647,    0,  644,  646,  650,  649,  650,  649,
			    0,  647,  650,  651,  652,  647,  652,  653,  650,  649,
			  652,  653,  654,    0,    0,    0,  652,    0,  651,  654,
			    0,  654,  651,    0,  653,    0,    0,    0,  650,  655,
			  650,  654,    0,  655,  650,  651,  652,    0,  652,  653,

			  650,    0,  652,  653,  654,  656,  655,  656,  652,  655,
			    0,  654,    0,  654,  656,  657,  653,  656,  658,  657,
			    0,  655,  658,  654,  659,  655,  659,    0,    0,    0,
			    0,    0,  657,  660,    0,  658,  659,  656,  655,  656,
			  660,  655,  660,  664,    0,  664,  656,  657,    0,  656,
			  658,  657,  660,  661,  658,  664,  659,  661,  659,  663,
			    0,  661,    0,  663,  657,  660,  662,  658,  659,  662,
			  661,  662,  660,    0,  660,  664,  663,  664,  666,    0,
			  666,  662,  663,    0,  660,  661,    0,  664,  665,  661,
			  666,  663,  665,  661,    0,  663,    0,    0,  662,    0,

			  667,  662,  661,  662,  667,  665,    0,    0,  663,  670,
			  666,  665,  666,  662,  663,    0,  670,  667,  670,  668,
			  665,  668,  666,  669,  665,  668,    0,  669,  670,  671,
			  673,  668,  667,  671,  673,    0,  667,  665,    0,    0,
			  669,  670,    0,  665,    0,    0,  671,  673,  670,  667,
			  670,  668,  672,  668,  672,  669,    0,  668,  672,  669,
			  670,  671,  673,  668,  672,  671,  673,    0,  674,    0,
			  674,  675,  669,    0,    0,  675,    0,    0,  671,  673,
			  674,  676,  675,  676,  672,    0,  672,  677,  675,    0,
			  672,  677,    0,  676,  679,    0,  672,  678,  679,  678,

			  674,    0,  674,  675,  677,    0,  680,  675,  680,  678,
			    0,  679,  674,  676,  675,  676,    0,  681,  680,  677,
			  675,  681,    0,  677,    0,  676,  679,    0,  681,  678,
			  679,  678,    0,  682,  681,  682,  677,    0,  680,    0,
			  680,  678,  683,  679,    0,  682,  683,    0,    0,  681,
			  680,  685,  684,  681,  684,  685,    0,    0,    0,  683,
			  681,  687,    0,  687,  684,  682,  681,  682,  685,    0,
			  687,  685,  686,  687,  683,    0,  686,  682,  683,    0,
			  686,    0,    0,  685,  684,    0,  684,  685,    0,  686,
			    0,  683,    0,  687,  688,  687,  684,  688,    0,  688,

			  685,    0,  687,  685,  686,  687,  689,  690,  686,  688,
			  689,  689,  686,  690,    0,  690,  691,    0,    0,    0,
			  691,  686,  692,  689,  692,  690,  688,    0,  692,  688,
			    0,  688,  693,  691,  692,    0,  693,    0,  689,  690,
			    0,  688,  689,  689,  693,  690,    0,  690,  691,  693,
			    0,    0,  691,    0,  692,  689,  692,  690,    0,    0,
			  692,  694,  694,  694,  693,  691,  692,  695,  693,    0,
			    0,  695,    0,  694,  696,  695,  693,  696,    0,  696,
			    0,  693,    0,    0,  695,    0,    0,  698,    0,  696,
			    0,  698,    0,  694,  694,  694,    0,  697,  698,  695,

			  700,  697,  700,  695,  698,  694,  696,  695,    0,  696,
			    0,  696,  700,  699,  697,  699,  695,  697,    0,  698,
			    0,  696,  699,  698,  701,  699,    0,    0,  701,  697,
			  698,    0,  700,  697,  700,  703,  698,  703,  702,  703,
			  702,  701,    0,    0,  700,  699,  697,  699,  701,  697,
			  702,  702,  703,  704,  699,    0,  701,  699,    0,  705,
			  701,    0,  704,  705,  704,    0,    0,  703,    0,  703,
			  702,  703,  702,  701,  704,  706,  705,  706,    0,    0,
			  701,  706,  702,  702,  703,  704,  707,  706,  709,    0,
			  707,  705,  709,    0,  704,  705,  704,    0,  708,    0,

			  708,  707,  708,  707,    0,  709,  704,  706,  705,  706,
			  708,  711,    0,  706,  710,  711,  710,    0,  707,  706,
			  709,    0,  707,    0,  709,    0,  710,  712,  711,  712,
			  708,    0,  708,  707,  708,  707,  713,  709,    0,  712,
			  713,  713,  708,  711,  714,    0,  710,  711,  710,  944,
			  714,  944,  714,  713,  944,  944,  944,  944,  710,  712,
			  711,  712,  714,  715,    0,    0,    0,  715,  713,    0,
			  717,  712,  713,  713,  717,    0,  714,  716,    0,  716,
			  715,  717,  714,  715,  714,  713,  716,  717,  718,  716,
			  718,  729,    0,  719,  714,  715,    0,  719,  730,  715,

			  718,    0,  717,  720,    0,  722,  717,  722,  731,  716,
			  719,  716,  715,  717,  720,  715,  720,  722,  716,  717,
			  718,  716,  718,  721,  723,  719,  720,  721,  723,  719,
			  732,  724,  718,  724,    0,  720,    0,  722,    0,  722,
			  721,  723,  719,  724,  733,  945,  720,  945,  720,  722,
			  945,  945,  945,  945,  734,  721,  723,    0,  720,  721,
			  723,  735,    0,  724,    0,  724,    0,    0,  736,    0,
			    0,    0,  721,  723,    0,  724,  737,    0,  729,  729,
			  729,  729,  729,  729,  729,  730,  730,  730,  730,  730,
			  730,  730,  738,    0,    0,  731,  731,  731,  731,  731,

			  731,  731,  739,  954,    0,  954,    0,    0,  954,  954,
			  954,  954,  740,    0,    0,    0,    0,  732,  732,  732,
			  732,  732,  732,  732,    0,    0,    0,    0,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  734,  734,
			  734,  734,  734,  734,  734,  734,  734,  734,  735,  735,
			  735,  735,  735,  735,  735,  736,  736,  736,  736,  736,
			  736,  736,    0,  737,  737,  737,  737,  737,  737,  737,
			  741,  748,    0,  741,    0,  741,    0,    0,  741,  738,
			  738,  738,  738,  738,  738,  738,  739,  739,  739,  739,
			  739,  739,  739,  739,  739,  739,  740,  740,  740,  740, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  740,  740,  740,  740,  740,  740,  742,  749,    0,  742,
			    0,  742,    0,  743,  742,    0,  743,    0,  743,    0,
			  744,  743,    0,  744,    0,  744,    0,    0,  744,    0,
			    0,    0,  745,    0,    0,  745,    0,    0,  764,  746,
			  764,  766,  746,  766,  745,  745,  745,  745,  745,  747,
			  764,    0,  747,  766,  748,  748,  748,  748,  748,  748,
			  748,  750,  741,  741,  741,  741,  741,  741,  741,    0,
			  764,    0,  764,  766,    0,  766,    0,    0,    0,    0,
			    0, 1007,  764, 1007,    0,  766, 1007, 1007, 1007, 1007,
			  749,  749,  749,  749,  749,  749,  749,    0,  742,  742,

			  742,  742,  742,  742,  742,  743,  743,  743,  743,  743,
			  743,  743,  744,  744,  744,  744,  744,  744,  744,  745,
			  745,  745,  745,  745,  745,  745,  746,  746,  746,  746,
			  746,  746,  746,    0,    0,    0,  747,  747,  747,  747,
			  747,  747,  747,    0,  750,  750,  750,  750,  750,  750,
			  750,  755,  755,  755,  755,    0,  763,  765,  767,    0,
			  763,  765,  767,  769,  768,  755,  768,  769,  771,  771,
			  769,  767,  771,  763,  765,  767,  768,    0,    0,    0,
			  769,    0,    0,    0,    0,  771,    0,    0,  763,  765,
			  767,  755,  763,  765,  767,  769,  768,  755,  768,  769,

			  771,  771,  769,  767,  771,  763,  765,  767,  768,  770,
			  772,    0,  769,  770,  773,  770,    0,  771,  773,    0,
			  772,  774,  772,  774,    0,  770,  775,  776,    0,  776,
			  775,  773,  772,  774,  777,    0,    0,    0,  777,  776,
			    0,  770,  772,  775,    0,  770,  773,  770,    0,    0,
			  773,  777,  772,  774,  772,  774,    0,  770,  775,  776,
			    0,  776,  775,  773,  772,  774,  777,  778,  779,  778,
			  777,  776,  779,  778,  781,  775,  779,  780,  781,  778,
			  782,  780,  782,  777,  780,  779,  780,  781,    0,    0,
			  783,  781,  782,    0,  783,    0,  780,    0,  785,  778,

			  779,  778,  785,    0,  779,  778,  781,  783,  779,  780,
			  781,  778,  782,  780,  782,  785,  780,  779,  780,  781,
			    0,    0,  783,  781,  782,  784,  783,  784,  780,  786,
			  785,  786,    0,    0,  785,  786,  787,  784,  788,  783,
			  787,  786,  788,  787,  788,  789,    0,  785,  791,  789,
			  789,    0,  791,  787,  788,    0,    0,  784,    0,  784,
			    0,  786,  789,  786,    0,  791,    0,  786,  787,  784,
			  788,    0,  787,  786,  788,  787,  788,  789,    0,    0,
			  791,  789,  789,  790,  791,  787,  788,    0,    0,  790,
			    0,  790,  793,  792,  789,  793,  793,  791,  794,    0,

			  792,  790,  792,  795,    0,    0,  794,  795,  794,  793,
			    0,    0,  792,    0,  798,  790,  798,    0,  794,    0,
			  795,  790,  795,  790,  793,  792,  798,  793,  793,    0,
			  794,    0,  792,  790,  792,  795,    0,    0,  794,  795,
			  794,  793,    0,  796,  792,  796,  798,    0,  798,  797,
			  794,  796,  795,  797,  795,  796,  799,  800,  798,  800,
			  799,  801,  797,    0,    0,  801,  797,    0,  802,  800,
			  802,    0,    0,  799,  802,  796,    0,  796,  801,    0,
			  802,  797,  803,  796,    0,  797,  803,  796,  799,  800,
			    0,  800,  799,  801,  797,  803,    0,  801,  797,  803,

			  802,  800,  802,    0,  805,  799,  802,  804,  805,  804,
			  801,    0,  802,  806,  803,    0,    0,    0,  803,  804,
			  806,  805,  806,  808,    0,  807,  808,  803,  808,  807,
			  809,  803,  806,  807,  809,    0,  805,    0,  808,  804,
			  805,  804,  807,    0,  810,  806,  810,  809,    0,    0,
			    0,  804,  806,  805,  806,  808,  810,  807,  808,    0,
			  808,  807,  809,  811,  806,  807,  809,  811,    0,    0,
			  808,  811,  812,  814,  807,  812,  810,  812,  810,  809,
			  811,  813,  814,  813,  814,  813,    0,  812,  810,  815,
			    0,    0,    0,  815,  814,  811,    0,  815,  813,  811,

			    0,    0,    0,  811,  812,  814,  815,  812,  818,  812,
			  818,    0,  811,  813,  814,  813,  814,  813,  817,  812,
			  818,  815,  817,    0,    0,  815,  814,    0,  816,  815,
			  813,  816,  819,  816,    0,  817,  819,  820,  815,    0,
			  818,  821,  818,  816,  820,  821,  820,    0,    0,  819,
			  817,    0,  818,    0,  817,    0,  820,    0,  821,  824,
			  816,  824,  823,  816,  819,  816,  823,  817,  819,  820,
			    0,  824,    0,  821,    0,  816,  820,  821,  820,  823,
			  822,  819,  822,    0,  826,  823,  822,  826,  820,  826,
			  821,  824,  822,  824,  823,  838,  825,  838,  823,  826,

			  825,  828,    0,  824,  825,  827,    0,  838,  828,  827,
			  828,  823,  822,  825,  822,    0,  826,  823,  822,  826,
			  828,  826,  827,    0,  822,    0,  829,  838,  825,  838,
			  829,  826,  825,  828,    0,    0,  825,  827,    0,  838,
			  828,  827,  828,  829,  830,  825,  864,  864,  864,  864,
			    0,  830,  828,  830,  827,  831,  833,    0,  829,  831,
			  833,  834,  829,  830,    0,  832,    0,  832,  834,    0,
			  834,  832,  831,  833,    0,  829,  830,  832,    0,    0,
			  834,    0,    0,  830,    0,  830,  864,  831,  833,    0,
			    0,  831,  833,  834,  835,  830,    0,  832,  835,  832,

			  834,    0,  834,  832,  831,  833,  836,    0,  836,  832,
			    0,  835,  834,  835,  836,  837,  839,  841,  836,  837,
			  839,  841,    0,    0,    0,    0,  835,    0,    0,  840,
			  835,  840,  837,  839,  841,  839,    0,  840,  836,    0,
			  836,  840,    0,  835,    0,  835,  836,  837,  839,  841,
			  836,  837,  839,  841,  843,    0,    0,  842,  843,    0,
			  844,  840,  844,  840,  837,  839,  841,  839,  842,  840,
			  842,  843,  844,  840,  845,    0,    0,    0,  845,    0,
			  842,    0,  845,    0,  847,  850,  843,  850,  847,  842,
			  843,  845,  844,  846,  844,  853,  846,  850,  846,    0,

			  842,  847,  842,  843,  844,  854,  845,    0,  846,  849,
			  845,    0,  842,  849,  845,  848,  847,  850,  855,  850,
			  847,    0,  848,  845,  848,  846,  849,  856,  846,  850,
			  846,  851,    0,  847,  848,  851,    0,  852,    0,  852,
			  846,  849,    0,  857,  851,  849,  857,  848,  851,  852,
			  867,  867,  867,  867,  848,  857,  848,    0,  849,    0,
			    0,    0,    0,  851,    0,    0,  848,  851,    0,  852,
			    0,  852,  946,  946,  946,  946,  851,    0,    0,    0,
			  851,  852,  853,  853,  853,  853,  853,  853,  853,    0,
			  867,    0,  854,  854,  854,  854,  854,  854,  854,  863, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  863,  863,  863,    0,    0,  855,  855,  855,  855,  855,
			  855,  855,  946,  863,  856,  856,  856,  856,  856,  856,
			  856,    0,    0,  870,  870,  870,  870,  872,    0,  872,
			  857,  857,  857,  857,  857,  857,  857,  870,  871,  872,
			  873,  874,  871,    0,  873,  863,    0,  875,  874,    0,
			  874,  875,    0,    0,  876,  871,  876,  873,  877,  872,
			  874,  872,  877,  876,  875,    0,  876,  875,    0,  870,
			  871,  872,  873,  874,  871,  877,  873,  877,    0,  875,
			  874,    0,  874,  875,    0,    0,  876,  871,  876,  873,
			  877,    0,  874,  879,  877,  876,  875,  879,  876,  875,

			  878,  880,  878,    0,  881,  880,  881,  877,  878,  877,
			  879,  882,  878,  882,  882,  880,  881,    0,  880,  884,
			    0,  884,  883,  882,    0,  879,  883,  884,    0,  879,
			    0,  884,  878,  880,  878,    0,  881,  880,  881,  883,
			  878,  883,  879,  882,  878,  882,  882,  880,  881,  888,
			  880,  884,  885,  884,  883,  882,  885,  886,  883,  884,
			  888,  887,  888,  884,  886,  887,  886,    0,    0,  885,
			  889,  883,  888,  883,  889,    0,  886,    0,  887,    0,
			    0,  888,  891,  890,  885,  890,  891,  889,  885,  886,
			    0,    0,  888,  887,  888,  890,  886,  887,  886,  891,

			    0,  885,  889,  893,  888,    0,  889,  893,  886,  892,
			  887,  892,  895,    0,  891,  890,  895,  890,  891,  889,
			  893,  892,  896,  894,  896,    0,    0,  890,    0,  895,
			  894,  891,  894,  897,  896,  893,  898,  897,    0,  893,
			    0,  892,  894,  892,  895,    0,    0,  898,  895,  898,
			  897,  900,  893,  892,  896,  894,  896,    0,  900,  898,
			  900,  895,  894,  899,  894,  897,  896,  899,  898,  897,
			  900,  901,  911,    0,  894,  901,  911,    0,    0,  898,
			  899,  898,  897,  900,  902,    0,  902,    0,  901,  911,
			  900,  898,  900,  903,    0,  899,  902,  903,    0,  899,

			    0,    0,  900,  901,  911,    0,    0,  901,  911,    0,
			  903,  903,  899,    0,    0,  904,  902,  904,  902,  905,
			  901,  911,  904,  905,    0,  903,    0,  904,  902,  903,
			    0,    0,  905,  906,    0,  906,  905,    0,  908,    0,
			  908,    0,  903,  903,  907,  906,  908,  904,  907,  904,
			  908,  905,  909,    0,  904,  905,  909,    0,    0,  904,
			    0,  907,    0,  907,  905,  906,    0,  906,  905,  909,
			  908,  909,  908,  910,    0,  910,  907,  906,  908,  912,
			  907,  910,  908,    0,  909,  910,    0,  913,  909,    0,
			  912,  913,  912,  907,    0,  907,    0,    0,    0,    0,

			    0,  909,  912,  909,  913,  910,  913,  910,  914,    0,
			  914,  912,    0,  910,  915,    0,  914,  910,  915,  913,
			  914,    0,  912,  913,  912,    0,  917,    0,    0,    0,
			  917,  915,  915,  918,  912,  918,  913,  916,  913,  916,
			  914,    0,  914,  917,  916,  918,  915,    0,  914,  916,
			  915,    0,  914,  919,    0,    0,    0,  919,  917,    0,
			    0,    0,  917,  915,  915,  918,  919,  918,    0,  916,
			  919,  916,  920,    0,  920,  917,  916,  918,  921,  923,
			    0,  916,  921,  923,  920,  919,    0,    0,  922,  919,
			  922,  921,    0,    0,    0,  921,  923,  924,  919,  924,

			  922,  925,  919,    0,  920,  925,  920,    0,  927,  924,
			  921,  923,  927,    0,  921,  923,  920,  926,  925,    0,
			  922,    0,  922,  921,  926,  927,  926,  921,  923,  924,
			  929,  924,  922,  925,  929,  931,  926,  925,    0,  931,
			  927,  924,  933,  928,  927,  928,  933,  929,    0,  926,
			  925,  930,  931,  930,    0,  928,  926,  927,  926,  933,
			    0,  933,  929,  930,    0,    0,  929,  931,  926,    0,
			  932,  931,  932,    0,  933,  928,    0,  928,  933,  929,
			    0,    0,  932,  930,  931,  930,  934,  928,  934,    0,
			    0,  933,  935,  933,  934,  930,  935,    0,  934,  936,

			    0,  936,  932,    0,  932,  935,  937,    0,    0,  935,
			  937,  936,    0,  938,  932,  938,    0,  939,  934,    0,
			  934,  939,    0,  937,  935,  938,  934,  940,  935,  940,
			  934,  936,    0,  936,  939,  940,  939,  935,  937,  940,
			    0,  935,  937,  936,    0,  938,  960,  938,  960,  939,
			    0,    0,    0,  939,    0,  937,    0,  938,  960,  940,
			    0,  940,  953,  953,  953,  953,  939,  940,  939,  955,
			    0,  940,  955,  955,  956,    0,  953,    0,  960,  957,
			  960,    0,  956,  957,  956,  958,  955,  958,    0,    0,
			  960,    0,    0,  958,  956,  959,  957,  958,  957,  959,

			    0,  955,  953,    0,  955,  955,  956,    0,  953,    0,
			    0,  957,  959,    0,  956,  957,  956,  958,  955,  958,
			  961,    0,    0,    0,  961,  958,  956,  959,  957,  958,
			  957,  959,    0,  961,  962,    0,  962,  961,  963,  964,
			    0,  964,  963,    0,  959,  965,  962,    0,  965,  965,
			    0,  964,  961,    0,    0,  963,  961,    0,    0,    0,
			    0,    0,  965,    0,    0,  961,  962,    0,  962,  961,
			  963,  964,    0,  964,  963,    0,  966,  965,  962,    0,
			  965,  965,    0,  964,  966,  968,  966,  963,  967,  967,
			    0,    0,  967,    0,  965,  968,  966,  968,  969,    0,

			    0,  969,  969,  970,    0,  967,    0,  968,  966,    0,
			    0,  970,    0,  970,    0,  969,  966,  968,  966,    0,
			  967,  967,    0,  970,  967,    0,    0,  968,  966,  968,
			  969,    0,    0,  969,  969,  970,  972,  967,  972,  968,
			  971,    0,  973,  970,  971,  970,  973,  969,  972,  975,
			  974,  971,  974,  975,  977,  970,    0,  971,  977,  973,
			  977,  976,  974,  976,    0,    0,  975,  980,  972,  980,
			  972,  977,  971,  976,  973,  982,  971,  982,  973,  980,
			  972,  975,  974,  971,  974,  975,  977,  982,    0,  971,
			  977,  973,  977,  976,  974,  976,  979,  978,  975,  980,

			  979,  980,  978,  977,  978,  976,  981,  982,  983,  982,
			  981,  980,  983,  979,  978,  984,  985,  984,    0,  982,
			  985,  983,    0,  981,    0,  983,    0,  984,  979,  978,
			    0,    0,  979,  985,  978,    0,  978,    0,  981,  989,
			  983,    0,  981,  989,  983,  979,  978,  984,  985,  984,
			  987,  986,  985,  983,  987,  981,  989,  983,  986,  984,
			  986,    0,    0,    0,  987,  985,  988,  987,  988,  988,
			  986,  989,  990,    0,    0,  989,  992,    0,  988,  990,
			    0,  990,  987,  986,    0,  992,  987,  992,  989,  993,
			  986,  990,  986,  993,    0,    0,  987,  992,  988,  987, yy_Dummy>>,
			1, 1000, 8000)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  988,  988,  986,  991,  990,  991,  993,  991,  992,  996,
			  988,  990,  994,  990,  994,    0,  996,  992,  996,  992,
			  991,  993,    0,  990,  994,  993,  995,    0,  996,  992,
			  995,    0,  997,    0,    0,  991,  997,  991,  993,  991,
			    0,  996,    0,  995,  994,    0,  994,    0,  996,  997,
			  996,    0,  991,  999,  998, 1012,  994,  999,  995, 1012,
			  996,  998,  995,  998,  997, 1000,    0, 1000,  997,    0,
			  999,    0, 1012,  998,    0,  995,    0, 1000,    0,    0,
			    0,  997,    0,    0,    0,  999,  998, 1012,    0,  999,
			 1014, 1012,    0,  998, 1014,  998,    0, 1000,    0, 1000,

			    0,    0,  999,    0, 1012,  998,    0, 1014,    0, 1000,
			 1003, 1003, 1003, 1003, 1009, 1009, 1009, 1009, 1011, 1011,
			 1011, 1011, 1014, 1013, 1015, 1013, 1014,    0, 1009,    0,
			 1016, 1015,    0, 1015, 1016, 1013, 1017,    0, 1017, 1014,
			    0,    0, 1018, 1015,    0,    0, 1018, 1016, 1017, 1019,
			 1003, 1019,    0,    0, 1009, 1013, 1015, 1013, 1011, 1018,
			 1009, 1019, 1016, 1015,    0, 1015, 1016, 1013, 1017,    0,
			 1017,    0, 1022, 1020, 1018, 1015, 1022, 1020, 1018, 1016,
			 1017, 1019,    0, 1019, 1020, 1021, 1023, 1021, 1023, 1022,
			 1020, 1018,    0, 1019, 1025, 1024, 1025, 1021, 1023, 1024,

			    0, 1027,    0, 1027, 1022, 1020, 1025, 1026, 1022, 1020,
			    0, 1026, 1024, 1027,    0,    0, 1020, 1021, 1023, 1021,
			 1023, 1022, 1020,    0, 1026,    0, 1025, 1024, 1025, 1021,
			 1023, 1024, 1028, 1027,    0, 1027, 1028, 1030, 1025, 1026,
			 1029, 1030, 1029, 1026, 1024, 1027, 1032,    0, 1029, 1028,
			 1032, 1028, 1029, 1031, 1030, 1031, 1026,    0,    0, 1035,
			    0, 1035,    0, 1032, 1028, 1031,    0,    0, 1028, 1030,
			    0, 1035, 1029, 1030, 1029, 1034,    0,    0, 1032, 1034,
			 1029, 1028, 1032, 1028, 1029, 1031, 1030, 1031, 1033,    0,
			 1033, 1035, 1034, 1035, 1033, 1032,    0, 1031, 1036, 1037,

			 1033,    0, 1036, 1035,    0,    0, 1037, 1034, 1037,    0,
			 1038, 1034,    0,    0, 1038, 1036,    0, 1039, 1037, 1039,
			 1033, 1041, 1033, 1041, 1034,    0, 1033, 1038,    0, 1039,
			 1036, 1037, 1033, 1041, 1036, 1040,    0,    0, 1037, 1040,
			 1037,    0, 1038,    0,    0,    0, 1038, 1036,    0, 1039,
			 1037, 1039, 1040, 1041, 1048, 1041, 1048,    0,    0, 1038,
			    0, 1039,    0,    0,    0, 1041, 1048, 1040,    0,    0,
			    0, 1040, 1042, 1042, 1042, 1042, 1045, 1045, 1045, 1045,
			 1046, 1046, 1046, 1046, 1040, 1047, 1048, 1049, 1048, 1047,
			 1050, 1049,    0, 1052,    0, 1052, 1051, 1050, 1048, 1050,

			 1051,    0, 1047,    0, 1049, 1052, 1054, 1053, 1054, 1050,
			    0, 1053, 1042, 1051,    0,    0, 1045, 1047, 1054, 1049,
			 1046, 1047, 1050, 1049, 1053, 1052,    0, 1052, 1051, 1050,
			    0, 1050, 1051,    0, 1047,    0, 1049, 1052, 1054, 1053,
			 1054, 1050, 1055, 1053,    0, 1051, 1055,    0,    0, 1056,
			 1054, 1056, 1057, 1057, 1057, 1057, 1053,    0, 1058, 1055,
			    0, 1056, 1058,    0, 1059,    0, 1059,    0,    0,    0,
			    0,    0,    0,    0, 1055, 1058, 1059,    0, 1055,    0,
			    0, 1056,    0, 1056,    0,    0,    0,    0,    0,    0,
			 1058, 1055, 1057, 1056, 1058,    0, 1059,    0, 1059,    0,

			    0,    0,    0,    0,    0,    0,    0, 1058, 1059, 1061,
			 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061,
			 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061,
			 1061, 1061, 1062, 1062,    0, 1062, 1062, 1062, 1062, 1062,
			 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062,
			 1062, 1062, 1062, 1062, 1062, 1063,    0,    0,    0,    0,
			    0,    0, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063,
			 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1064, 1064,
			    0, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064,
			 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064,

			 1064, 1065, 1065,    0, 1065, 1065, 1065, 1065,    0, 1065,
			 1065, 1065, 1065, 1065, 1065, 1065, 1065, 1065, 1065, 1065,
			 1065, 1065, 1065, 1065, 1066, 1066, 1066, 1066, 1066, 1066,
			 1066, 1066, 1066, 1066, 1066, 1066, 1066, 1066, 1067, 1067,
			    0, 1067, 1067, 1067,    0,    0, 1067, 1067, 1067, 1067,
			 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1067,
			 1067, 1068, 1068, 1068, 1068, 1068, 1068, 1068, 1068, 1068,
			 1068, 1068, 1068, 1068, 1068, 1069,    0,    0, 1069,    0,
			 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1069,
			 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1070, 1070,

			    0, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070,
			 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070,
			 1070, 1071, 1071,    0, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1072, 1072,    0, 1072, 1072, 1072,
			 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072,
			 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1073,    0,    0,
			    0,    0, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073,
			 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073,
			 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074,    0, 1074,

			 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074,
			 1074, 1074, 1074, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1077,
			 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077,
			 1077, 1077, 1078, 1078,    0, 1078, 1078, 1078,    0, 1078,
			 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078, 1078, 1078, 1079, 1079,    0, 1079, 1079,
			 1079,    0, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079,
			 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1080, 1080,

			 1080, 1080, 1080, 1080, 1080, 1080,    0, 1080, 1080, 1080,
			 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080,
			 1080, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, yy_Dummy>>,
			1, 1000, 9000)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, yy_Dummy>>,
			1, 22, 10000)
		end

	yy_base_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1080)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,   99,  111,  419, 9921,  414,  406,  404,
			  401,  398,  124,    0, 9921,  131,  138, 9921, 9921, 9921,
			 9921, 9921,   89,   87,   92,  221,  102,  129,  349, 9921,
			  100, 9921,  101,  348,  287,  218,  352,  221,  362,  411,
			  124,  461,  406,  216,  458,  125,  217,  432,  360,  472,
			  482,  509,  515, 9921,  291, 9921, 9921,   79,  559,  515,
			  623,  523,  590,  663,  511,  691,  702,  706,  710,  727,
			  563,  628,  751,  743,  778,  760,  803, 9921, 9921, 9921,
			   44,  253,   53,   69,   75,   92,  225,  770,  212,  311,
			  837,  642,  850,  870,  787,  803,  813,  823,  860,  880,

			  890,  311,  308,  301,  299, 9921,  984, 9921, 1078, 1042,
			 1055, 1092, 1107, 1125, 1152, 1172, 1186, 1202,    0,  917,
			  931, 1137, 1219, 1231, 1246, 1266, 1281,  905,  291, 1375,
			 1336, 1344, 1356, 1385, 1398, 1408, 1434, 9921, 9921, 9921,
			  357, 9921, 9921, 9921,  975, 1001, 1015,  103,  252,  255,
			 1515, 1033,  121, 9921, 9921, 9921, 9921, 9921, 9921, 1039,
			 1492, 1521, 1523, 1556, 1562, 1499, 1564, 1572, 1573, 1611,
			 1580,  252,  196,  321,  110,  372,  378,  189, 1626, 1625,
			 1565, 1633, 1642, 1647, 1667, 1677, 1694, 1691, 1708, 1712,
			 1764, 1711, 1761, 1695, 1741, 1775, 1814, 1809, 1825, 1826,

			 1840, 1785, 1874, 1871, 1879, 1882, 1900, 1929, 1935, 1935,
			 1932, 1978, 2031, 1984, 1982, 1994, 2035, 2048, 2056, 2044,
			 2047, 2098, 2104, 2109, 2099, 2116, 2112, 2105, 2120, 2159,
			 2161, 2212, 2222, 2234, 2229, 2262, 2264, 2278, 2276, 2281,
			 2334, 2336, 2286, 2346, 2345, 2385, 2328, 2388, 2348, 2392,
			 9921, 1363, 2119, 2386, 2408, 2421, 2431, 2441, 2451,  477,
			  176,  481,  157,  533,  558,  154,  587,  669,  718,  757,
			  798,  801, 1070, 1209, 1416, 2396, 2461, 2471, 2481, 2491,
			 1156, 1331, 1254, 2502,  237, 2590, 2601, 2608, 1561, 2525,
			 2624, 2633, 2644, 2654, 2664, 2707, 2763, 2680, 2779, 2806,

			 2816, 2826, 2836, 2846, 2862, 2696, 2786, 2793, 2869, 2879,
			 2889, 2940, 2983, 2990, 2997, 3004, 3014, 3022, 3034, 3044,
			 3054, 3064, 3158, 3171, 3184, 3204, 3218, 3231, 3254, 3278,
			 3301, 3241, 3286, 3313, 3336, 3348, 3358, 3321, 9921, 3368,
			 3376, 3391, 3403, 3413, 3426, 3448, 3466, 3481,  202, 3503,
			 3516, 3529, 3542, 3556, 3563, 3571, 3578, 3585, 3593, 3606,
			 3619, 3632, 3653, 3675, 3683, 3696, 3709, 3722, 3732, 3743,
			 3753, 3765, 3775, 3786, 3149, 2655, 1348, 9921, 3176, 3035,
			 3510, 3005,  197,  454,  132, 1074,  110, 3867,  104, 3183,
			 3572, 3862, 2393, 3243, 3678, 3863, 2640, 3873, 2744, 3912,

			 3149, 3910, 3913,  837,  870,  915,  975, 1092, 1106, 3915,
			 3910, 3937, 3961, 3975, 3965, 3977, 3976, 4001, 4023, 4028,
			 4030, 4052, 4044, 4054, 4076, 4087, 4094, 4108, 4111, 4116,
			 4141, 4140, 4149, 4164, 4167, 4175, 4201, 4211, 4222, 4219,
			 4239, 4271, 4268, 4297, 4276, 4300, 4318, 4330, 4338, 4339,
			 4369, 4370, 4373, 4384, 4419, 4372, 4422, 4436, 4437, 4448,
			 4477, 4446, 4483, 4497, 4494, 4466, 4512, 4527, 4537, 4564,
			 4572, 4554, 4561, 4587, 4608, 4614, 4607, 4622, 4638, 4641,
			 4659, 4667, 4686, 4688, 4691, 4702, 4721, 4742, 4747, 4739,
			 4738, 4763, 4785, 4768, 4797, 4803, 4811, 4825, 4842, 4859,

			 4849, 4871, 4887, 4901, 4838, 4909, 4904, 9921, 4896, 4903,
			 4915, 4930, 4940, 4950, 1299, 1306, 1322, 1373, 1395, 1426,
			 1578, 1725, 9921, 4887, 4958, 4971, 4997, 5009, 5052, 5065,
			 9921, 5016, 5073, 5083, 5110, 5120, 5130, 5146, 5182, 5189,
			 5229, 5245, 5255, 5265, 5288, 5295, 5302, 5309, 5328, 5364,
			 4979, 4987, 5371, 5403, 5422, 5439, 5429, 5466, 5473, 5480,
			 5497, 5533, 5546, 5591, 5574, 5598, 5519, 5609, 5624, 5637,
			 5647, 5664, 9921, 9921, 9921, 9921, 9921, 5691, 9921, 9921,
			 9921, 9921, 9921, 9921, 9921, 9921, 9921, 9921, 9921, 9921,
			 9921, 9921, 9921, 9921, 5704, 5714, 3675, 1967, 3046, 2012,

			 5589, 3745, 2200, 2228, 3585, 5761, 5394,  545,   96, 2454,
			   93,    0,   72, 5471, 5488, 5785, 5777, 5793, 5790, 5844,
			 5840, 5837, 5858, 5836, 5844, 1824, 1836, 5892, 5890, 5904,
			 5907, 5906, 5933, 5947, 5948, 5968, 5969, 6002, 5952, 5977,
			 6005, 6025, 6030, 6062, 6069, 6035, 6070, 6086, 6072, 6084,
			 6115, 6116, 6123, 6137, 6138, 6159, 6164, 6185, 6188, 6183,
			 6199, 6223, 6228, 6229, 6202, 6258, 6237, 6270, 6278, 6293,
			 6275, 6299, 6311, 6300, 6327, 6341, 6340, 6357, 6356, 6364,
			 6365, 6387, 6392, 6412, 6411, 6421, 6442, 6420, 6456, 6476,
			 6472, 6486, 6481, 6502, 6520, 6537, 6536, 6567, 6557, 6572,

			 6559, 6594, 6597, 6605, 6621, 6629, 6634, 6656, 6657, 6658,
			 6673, 6681, 6686, 6706, 6709, 6733, 6736, 6740, 6747, 6763,
			 6773, 6793, 6764, 6794, 6790, 5654, 5671, 1846, 1901, 6784,
			 6791, 6801, 6823, 6837, 6847, 6854, 6861, 6869, 6885, 6895,
			 6905, 6968, 7004, 7011, 7018, 7025, 7032, 7042, 6960, 6996,
			 7050, 3210, 3701, 2427, 2874, 7131, 3025, 5098, 3339, 5492,
			 3383, 3892, 5639, 7126, 6997, 7127, 7000, 7128, 7123, 7133,
			 7172, 7138, 7179, 7184, 7180, 7196, 7186, 7204, 7226, 7238,
			 7243, 7244, 7239, 7260, 7284, 7268, 7288, 7306, 7301, 7315,
			 7348, 7318, 7359, 7362, 7365, 7373, 7402, 7419, 7373, 7426,

			 7416, 7431, 7427, 7452, 7466, 7474, 7479, 7495, 7485, 7500,
			 7503, 7533, 7534, 7551, 7541, 7559, 7590, 7588, 7567, 7602,
			 7603, 7611, 7639, 7632, 7618, 7666, 7646, 7675, 7667, 7696,
			 7710, 7725, 7724, 7726, 7727, 7764, 7765, 7785, 7654, 7786,
			 7788, 7787, 7827, 7824, 7819, 7844, 7855, 7854, 7881, 7879,
			 7844, 7901, 7896, 7888, 7898, 7911, 7920, 7936, 9921, 5108,
			 5616, 3405,  358, 7979, 7726, 3458, 3514, 7930, 3534, 5118,
			 8003, 8008, 7986, 8010, 8007, 8017, 8013, 8028, 8059, 8063,
			 8071, 8063, 8070, 8092, 8078, 8122, 8123, 8131, 8119, 8140,
			 8142, 8152, 8168, 8173, 8189, 8182, 8181, 8203, 8206, 8233,

			 8217, 8241, 8243, 8263, 8274, 8289, 8292, 8314, 8297, 8322,
			 8332, 8242, 8349, 8357, 8367, 8384, 8396, 8396, 8392, 8423,
			 8431, 8448, 8447, 8449, 8456, 8471, 8483, 8478, 8502, 8500,
			 8510, 8505, 8529, 8512, 8545, 8562, 8558, 8576, 8572, 8587,
			 8586, 3563, 3598, 3626, 6734, 6830, 7952, 3716,  516, 3778,
			 3790, 4410, 9921, 8642, 6888, 8639, 8641, 8649, 8644, 8665,
			 8605, 8690, 8693, 8708, 8698, 8715, 8743, 8758, 8754, 8768,
			 8770, 8810, 8795, 8812, 8809, 8819, 8820, 8824, 8861, 8866,
			 8826, 8876, 8834, 8878, 8874, 8886, 8917, 8920, 8925, 8909,
			 8938, 8973, 8944, 8959, 8971, 8996, 8975, 9002, 9020, 9023, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 9024,   70, 4985, 9090, 4997, 5430, 5524, 7066,   58, 9094,
			 5630, 9098, 9025, 9082, 9060, 9090, 9100, 9095, 9112, 9108,
			 9143, 9144, 9142, 9145, 9165, 9153, 9177, 9160, 9202, 9199,
			 9207, 9212, 9216, 9247, 9245, 9218, 9268, 9265, 9280, 9276,
			 9305, 9280, 9352,   52, 5706, 9356, 9360, 9355, 9313, 9357,
			 9356, 9366, 9352, 9377, 9365, 9412, 9408, 9432, 9428, 9423,
			 9921, 9508, 9531, 9554, 9577, 9600, 9615, 9637, 9651, 9674,
			 9697, 9720, 9743, 9766, 9789, 9803, 9816, 9829, 9851, 9874,
			 9897, yy_Dummy>>,
			1, 81, 1000)
		end

	yy_def_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1080)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0, 1060,    1, 1061, 1061, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1062, 1063, 1060, 1064, 1065, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1066, 1066, 1066, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060,   34,   34,   36,   34,   36,
			   39,   39,   39,   39,   39,   39,   39,   39,   39,   39,
			   39,   39,   39, 1060, 1060, 1060, 1060, 1067, 1068, 1068,
			 1068, 1068, 1068,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1069, 1060, 1060,
			 1069, 1060, 1070, 1071, 1069, 1069, 1069, 1069, 1069, 1069,

			 1069, 1060, 1060, 1060, 1060, 1060, 1062, 1060, 1072, 1062,
			 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1063, 1064,
			 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1073, 1060, 1073,
			 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1074, 1066, 1066, 1066, 1075, 1076,
			 1077, 1066, 1066, 1060, 1060, 1060, 1060, 1060, 1060,   39,
			   39,   39,   39,   39,   39,   62,   62,   62,   62,   62,
			   62, 1060, 1060, 1060, 1060, 1060, 1060, 1060,   39,   62,
			   39,   39,   39,   39,   39,   62,   62,   62,   62,   62,
			   39,   39,   62,   62,   39,   39,   39,   62,   62,   62,

			   39,   39,   39,   62,   62,   62,   39,   39,   41,   39,
			   62,   62,   62,   62,   39,   39,   62,   62,   39,   62,
			   39,   39,   39,   39,   62,   62,   62,   62,   39,   62,
			   41,   62,   39,   39,   62,   62,   39,   39,   62,   62,
			   39,   62,   39,   39,   62,   62,   39,   62,   39,   62,
			 1060, 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1069,
			 1060, 1060, 1078, 1079, 1060, 1069, 1070, 1071, 1060, 1069,
			 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1069, 1071, 1071,

			 1071, 1071, 1071, 1071, 1071, 1069, 1069, 1069, 1069, 1069,
			 1069, 1072, 1064, 1064, 1072, 1072, 1072, 1072, 1072, 1072,
			 1072, 1072, 1072, 1062, 1062, 1062, 1062, 1062, 1062, 1062,
			 1062, 1064, 1064, 1064, 1064, 1064, 1064, 1073, 1060, 1073,
			 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1060, 1073,
			 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073,
			 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073,
			 1073, 1073, 1073, 1073, 1060, 1060, 1060, 1060, 1060, 1060,
			 1066, 1066, 1066, 1075, 1075, 1076, 1076, 1077, 1077, 1066,
			 1066,   39,   62,   39,   39,   62,   62,   39,   62,   39,

			   62,   39,   62, 1060, 1060, 1060, 1060, 1060, 1060,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   39,   39,   62,   62,   62,   39,   62,   39,
			   39,   62,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   39,   39,   39,
			   62,   62,   62,   62,   62,   39,   62,   39,   39,   62,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   39,   39,   39,   39,   39,   62,   62,   62,
			   62,   62,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   39,   62,   62,   62,   39,

			   62,   39,   62,   39,   62,   39,   62, 1060, 1067, 1067,
			 1067, 1067, 1067, 1067, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1078, 1078, 1078, 1078, 1078, 1078, 1078,
			 1060, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1070, 1070,
			 1070, 1070, 1070, 1070, 1071, 1071, 1071, 1071, 1071, 1071,
			 1069, 1069, 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072,
			 1072, 1072, 1062, 1062, 1064, 1064, 1073, 1073, 1073, 1073,
			 1073, 1073, 1060, 1060, 1060, 1060, 1060, 1073, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1073, 1073, 1060, 1060, 1060, 1060,

			 1060, 1060, 1060, 1060, 1060, 1066, 1066, 1075, 1075, 1076,
			 1076,  387, 1077, 1066, 1066,   39,   62,   39,   62,   39,
			   62,   39,   39,   62,   62, 1060, 1060,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   62,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   62,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   62,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62, 1067, 1067, 1060, 1060, 1078,
			 1078, 1078, 1078, 1078, 1078, 1079, 1079, 1079, 1079, 1079,
			 1079, 1070, 1070, 1071, 1071, 1072, 1072, 1072, 1073, 1073,
			 1073, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1074, 1066,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62, 1078, 1078, 1079, 1079, 1072, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1080,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   62, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060,   39,   62,   39,   62,   39,   62,   39,   62,
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,
			   39,   62, 1060, 1060, 1060, 1060, 1060,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62, 1060,   39,   62,
			    0, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, yy_Dummy>>,
			1, 81, 1000)
		end

	yy_ec_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,    8,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,

			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,    8,   89,   90,    1,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,    1,    1,   94,   94,   94,   94,   94,   94,

			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   95,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   97,   98,   98,
			    1,   99,   99,   99,  100,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    5,    1,    6,    1,    1,
			    7,    8,    1,    1,    1,    1,    1,    1,    9,    1,
			   10,   11,   12,   13,    1,    1,    1,    1,    1,    1,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   14,   15,   16,   17,    1,    1,    1,    1,
			   18,    1,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   19,   20,   21,   22,    1,    1,
			    1,    1,    1,    1,   23,   23,   23,   23,   23,   23,

			   23, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1061)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    2,    3,    4,    6,    9,   11,
			   14,   17,   20,   23,   26,   29,   32,   34,   37,   40,
			   43,   46,   49,   52,   55,   58,   62,   66,   70,   73,
			   76,   79,   82,   85,   87,   91,   95,   99,  103,  107,
			  111,  115,  119,  123,  127,  131,  135,  139,  143,  147,
			  151,  155,  159,  163,  166,  168,  171,  174,  176,  179,
			  182,  185,  188,  191,  194,  197,  200,  203,  206,  209,
			  212,  215,  218,  221,  224,  227,  230,  233,  236,  239,
			  242,  244,  246,  248,  250,  252,  254,  256,  258,  260,
			  262,  265,  267,  269,  271,  273,  275,  277,  279,  281,

			  283,  285,  286,  287,  288,  289,  290,  291,  292,  293,
			  296,  299,  300,  301,  302,  303,  304,  305,  306,  307,
			  308,  309,  310,  311,  312,  313,  314,  315,  316,  316,
			  317,  318,  319,  320,  321,  322,  323,  324,  325,  326,
			  327,  329,  330,  331,  332,  332,  334,  336,  337,  339,
			  340,  341,  341,  343,  344,  345,  346,  347,  348,  349,
			  351,  353,  355,  357,  360,  362,  363,  364,  365,  366,
			  368,  369,  369,  369,  369,  369,  369,  369,  369,  371,
			  372,  374,  376,  378,  380,  382,  383,  384,  385,  386,
			  387,  389,  392,  393,  395,  397,  399,  401,  402,  403,

			  404,  406,  408,  410,  411,  412,  413,  416,  418,  420,
			  423,  425,  426,  427,  429,  431,  433,  434,  435,  437,
			  438,  440,  442,  444,  447,  448,  449,  450,  452,  454,
			  455,  457,  458,  460,  462,  463,  464,  466,  468,  469,
			  470,  472,  473,  475,  477,  478,  479,  481,  482,  484,
			  485,  486,  486,  486,  486,  486,  486,  486,  486,  486,
			  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,
			  486,  486,  486,  487,  488,  489,  490,  491,  492,  493,
			  494,  495,  495,  495,  495,  496,  498,  499,  500,  501,
			  503,  504,  505,  506,  507,  508,  509,  510,  512,  513,

			  514,  515,  516,  517,  518,  519,  520,  521,  522,  523,
			  524,  525,  525,  527,  529,  529,  529,  529,  529,  529,
			  529,  529,  529,  529,  531,  533,  534,  535,  536,  537,
			  538,  539,  540,  541,  542,  543,  544,  545,  546,  547,
			  548,  549,  550,  551,  552,  553,  554,  555,  556,  556,
			  557,  558,  559,  560,  561,  562,  563,  564,  565,  566,
			  567,  568,  569,  570,  571,  572,  573,  574,  575,  576,
			  577,  578,  579,  580,  581,  583,  583,  583,  584,  586,
			  587,  589,  591,  591,  594,  596,  599,  601,  604,  606,
			  608,  608,  610,  611,  613,  616,  617,  619,  622,  624,

			  626,  627,  629,  630,  630,  630,  630,  630,  630,  630,
			  633,  635,  637,  638,  640,  641,  643,  644,  646,  647,
			  649,  650,  652,  654,  656,  657,  658,  659,  661,  662,
			  665,  667,  669,  670,  672,  674,  675,  676,  678,  679,
			  681,  682,  684,  685,  687,  688,  690,  692,  694,  696,
			  698,  699,  700,  701,  702,  703,  705,  706,  708,  710,
			  711,  712,  715,  717,  719,  720,  723,  725,  727,  728,
			  730,  731,  733,  735,  737,  739,  741,  743,  744,  745,
			  746,  747,  748,  749,  751,  753,  754,  755,  757,  758,
			  760,  761,  763,  764,  766,  768,  770,  771,  772,  773,

			  775,  776,  778,  779,  781,  782,  785,  787,  788,  788,
			  788,  788,  788,  788,  788,  788,  788,  788,  788,  788,
			  788,  788,  788,  789,  789,  789,  789,  789,  789,  789,
			  789,  790,  790,  790,  790,  790,  790,  790,  790,  791,
			  792,  793,  794,  795,  796,  797,  798,  799,  800,  801,
			  802,  803,  804,  805,  806,  806,  807,  807,  807,  807,
			  807,  807,  807,  808,  809,  810,  811,  812,  813,  814,
			  815,  816,  817,  818,  819,  820,  821,  822,  823,  824,
			  825,  826,  827,  828,  829,  830,  831,  832,  833,  834,
			  835,  836,  837,  838,  839,  840,  841,  843,  843,  845,

			  845,  847,  847,  847,  847,  849,  851,  853,  853,  853,
			  853,  853,  853,  853,  855,  857,  859,  860,  862,  863,
			  865,  866,  868,  870,  871,  872,  872,  872,  874,  875,
			  877,  878,  880,  881,  883,  884,  886,  887,  889,  890,
			  892,  893,  895,  896,  899,  901,  903,  904,  906,  908,
			  909,  910,  912,  913,  915,  916,  918,  919,  922,  924,
			  926,  927,  929,  930,  932,  933,  935,  936,  938,  939,
			  941,  942,  944,  945,  948,  950,  952,  953,  956,  958,
			  961,  963,  965,  966,  969,  971,  973,  975,  976,  977,
			  979,  980,  982,  983,  985,  986,  988,  989,  991,  993,

			  994,  995,  997,  998, 1000, 1001, 1003, 1004, 1006, 1007,
			 1010, 1012, 1015, 1017, 1019, 1020, 1022, 1023, 1025, 1026,
			 1028, 1029, 1032, 1034, 1037, 1039, 1039, 1039, 1039, 1039,
			 1039, 1039, 1039, 1039, 1039, 1039, 1039, 1039, 1039, 1039,
			 1039, 1039, 1040, 1041, 1042, 1043, 1043, 1043, 1043, 1044,
			 1045, 1046, 1047, 1049, 1049, 1049, 1051, 1051, 1055, 1055,
			 1057, 1057, 1057, 1059, 1062, 1064, 1067, 1069, 1071, 1072,
			 1074, 1075, 1077, 1078, 1081, 1083, 1086, 1088, 1090, 1091,
			 1093, 1094, 1096, 1097, 1100, 1102, 1104, 1105, 1107, 1108,
			 1110, 1111, 1113, 1114, 1116, 1117, 1119, 1120, 1122, 1123,

			 1126, 1128, 1130, 1131, 1133, 1134, 1136, 1137, 1139, 1140,
			 1143, 1145, 1147, 1148, 1150, 1151, 1153, 1154, 1157, 1159,
			 1161, 1162, 1164, 1165, 1167, 1168, 1170, 1171, 1173, 1174,
			 1176, 1177, 1179, 1180, 1182, 1183, 1185, 1186, 1189, 1191,
			 1193, 1194, 1196, 1197, 1200, 1202, 1204, 1205, 1207, 1208,
			 1211, 1213, 1215, 1216, 1216, 1216, 1216, 1216, 1216, 1217,
			 1217, 1219, 1219, 1220, 1221, 1225, 1225, 1225, 1227, 1227,
			 1228, 1228, 1231, 1233, 1235, 1236, 1238, 1239, 1241, 1242,
			 1245, 1247, 1249, 1250, 1252, 1253, 1255, 1256, 1258, 1259,
			 1262, 1264, 1267, 1269, 1271, 1272, 1275, 1277, 1279, 1280,

			 1282, 1283, 1286, 1288, 1290, 1291, 1293, 1294, 1296, 1297,
			 1299, 1300, 1302, 1303, 1305, 1306, 1308, 1309, 1312, 1314,
			 1316, 1317, 1319, 1320, 1323, 1325, 1327, 1328, 1331, 1333,
			 1336, 1338, 1341, 1343, 1345, 1346, 1348, 1349, 1352, 1354,
			 1356, 1357, 1357, 1358, 1358, 1358, 1358, 1362, 1362, 1363,
			 1364, 1364, 1364, 1365, 1366, 1367, 1369, 1370, 1372, 1373,
			 1376, 1378, 1380, 1381, 1384, 1386, 1388, 1389, 1391, 1392,
			 1394, 1395, 1397, 1398, 1401, 1403, 1406, 1408, 1410, 1411,
			 1414, 1416, 1419, 1421, 1423, 1424, 1426, 1427, 1429, 1430,
			 1432, 1433, 1435, 1436, 1439, 1441, 1443, 1444, 1446, 1447, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1450, 1452, 1453, 1453, 1454, 1454, 1456, 1456, 1456, 1457,
			 1458, 1458, 1459, 1462, 1464, 1466, 1467, 1470, 1472, 1475,
			 1477, 1479, 1480, 1483, 1485, 1488, 1490, 1493, 1495, 1497,
			 1498, 1501, 1503, 1505, 1506, 1509, 1511, 1513, 1514, 1517,
			 1519, 1522, 1524, 1525, 1527, 1527, 1529, 1530, 1533, 1535,
			 1537, 1538, 1541, 1543, 1546, 1548, 1551, 1553, 1555, 1558,
			 1560, 1560, yy_Dummy>>,
			1, 62, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1559)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  143,  143,  164,  162,  163,    3,  162,  163,    4,
			  163,    1,  162,  163,    2,  162,  163,   10,  162,  163,
			  145,  162,  163,  110,  162,  163,   17,  162,  163,  145,
			  162,  163,  162,  163,   11,  162,  163,   12,  162,  163,
			   32,  162,  163,   31,  162,  163,    8,  162,  163,   30,
			  162,  163,    6,  162,  163,   33,  162,  163,  147,  154,
			  162,  163,  147,  154,  162,  163,  147,  154,  162,  163,
			    9,  162,  163,    7,  162,  163,   37,  162,  163,   35,
			  162,  163,   36,  162,  163,  162,  163,  108,  109,  162,
			  163,  108,  109,  162,  163,  108,  109,  162,  163,  108,

			  109,  162,  163,  108,  109,  162,  163,  108,  109,  162,
			  163,  108,  109,  162,  163,  108,  109,  162,  163,  108,
			  109,  162,  163,  108,  109,  162,  163,  108,  109,  162,
			  163,  108,  109,  162,  163,  108,  109,  162,  163,  108,
			  109,  162,  163,  108,  109,  162,  163,  108,  109,  162,
			  163,  108,  109,  162,  163,  108,  109,  162,  163,  108,
			  109,  162,  163,   15,  162,  163,  162,  163,   16,  162,
			  163,   34,  162,  163,  162,  163,  109,  162,  163,  109,
			  162,  163,  109,  162,  163,  109,  162,  163,  109,  162,
			  163,  109,  162,  163,  109,  162,  163,  109,  162,  163,

			  109,  162,  163,  109,  162,  163,  109,  162,  163,  109,
			  162,  163,  109,  162,  163,  109,  162,  163,  109,  162,
			  163,  109,  162,  163,  109,  162,  163,  109,  162,  163,
			  109,  162,  163,   13,  162,  163,   14,  162,  163,   38,
			  162,  163,  162,  163,  162,  163,  162,  163,  162,  163,
			  162,  163,  162,  163,  162,  163,  143,  163,  141,  163,
			  142,  163,  137,  143,  163,  140,  163,  143,  163,  143,
			  163,  143,  163,  143,  163,  143,  163,  143,  163,  143,
			  163,  143,  163,  143,  163,    3,    4,    1,    2,   39,
			  145,  144,  144, -135,  145, -298, -136,  145, -299,  145,

			  145,  145,  145,  145,  145,  145,  110,  145,  145,  145,
			  145,  145,  145,  145,  145,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,    5,   23,   24,  157,  160,   18,
			   20,   29,  147,  154,  147,  154,  154,  146,  154,  154,
			  154,  146,  154,   28,   25,   22,   21,   26,   27,  108,
			  109,  108,  109,  108,  109,  108,  109,   44,  108,  109,
			  108,  109,  109,  109,  109,  109,   44,  109,  109,  108,
			  109,  109,  108,  109,  108,  109,  108,  109,  108,  109,
			  108,  109,  109,  109,  109,  109,  109,  108,  109,   58,
			  108,  109,  109,   58,  109,  108,  109,  108,  109,  108,

			  109,  109,  109,  109,  108,  109,  108,  109,  108,  109,
			  109,  109,  109,   70,  108,  109,  108,  109,  108,  109,
			   77,  108,  109,   70,  109,  109,  109,   77,  109,  108,
			  109,  108,  109,  109,  109,  108,  109,  109,  108,  109,
			  108,  109,  108,  109,   86,  108,  109,  109,  109,  109,
			   86,  109,  108,  109,  109,  108,  109,  109,  108,  109,
			  108,  109,  109,  109,  108,  109,  108,  109,  109,  109,
			  108,  109,  109,  108,  109,  108,  109,  109,  109,  108,
			  109,  109,  108,  109,  109,   19,  143,  143,  143,  143,
			  143,  143,  143,  143,  141,  142,  137,  143,  143,  143,

			  140,  138,  143,  143,  143,  143,  143,  143,  143,  143,
			  139,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  144,  145,  144,  145, -135,
			  145, -136,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  134,  111,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  134,  157,  160,  155,  157,  160,  155,  147,  154,  147,
			  154,  150,  153,  154,  153,  154,  149,  152,  154,  152,

			  154,  148,  151,  154,  151,  154,  147,  154,  108,  109,
			  109,  108,  109,   42,  108,  109,  109,   42,  109,   43,
			  108,  109,   43,  109,  108,  109,  109,  108,  109,  109,
			   48,  108,  109,   48,  109,  108,  109,  109,  108,  109,
			  109,  108,  109,  109,  108,  109,  109,  108,  109,  109,
			  108,  109,  108,  109,  108,  109,  109,  109,  109,  108,
			  109,  109,   61,  108,  109,  108,  109,   61,  109,  109,
			  108,  109,  108,  109,  109,  109,  108,  109,  109,  108,
			  109,  109,  108,  109,  109,  108,  109,  109,  108,  109,
			  108,  109,  108,  109,  108,  109,  108,  109,  109,  109,

			  109,  109,  109,  108,  109,  109,  108,  109,  108,  109,
			  109,  109,   81,  108,  109,   81,  109,  108,  109,  109,
			   84,  108,  109,   84,  109,  108,  109,  109,  108,  109,
			  109,  108,  109,  108,  109,  108,  109,  108,  109,  108,
			  109,  108,  109,  109,  109,  109,  109,  109,  109,  108,
			  109,  108,  109,  109,  109,  108,  109,  109,  108,  109,
			  109,  108,  109,  109,  108,  109,  108,  109,  108,  109,
			  109,  109,  109,  108,  109,  109,  108,  109,  109,  108,
			  109,  109,  107,  108,  109,  107,  109,  161,  138,  139,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,

			  143,  143,  143,  143,  144,  144,  144,  145,  145,  145,
			  145,  134,  134,  134,  134,  134,  134,  128,  126,  127,
			  129,  130,  134,  131,  132,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  134,
			  134,  157,  160,  157,  160,  157,  160,  156,  159,  147,
			  154,  147,  154,  147,  154,  147,  154,  108,  109,  109,
			  108,  109,  109,  108,  109,  109,  108,  109,  108,  109,
			  109,  109,  108,  109,  109,  108,  109,  109,  108,  109,
			  109,  108,  109,  109,  108,  109,  109,  108,  109,  109,
			  108,  109,  109,  108,  109,  109,   59,  108,  109,   59,

			  109,  108,  109,  109,  108,  109,  108,  109,  109,  109,
			  108,  109,  109,  108,  109,  109,  108,  109,  109,   68,
			  108,  109,  108,  109,   68,  109,  109,  108,  109,  109,
			  108,  109,  109,  108,  109,  109,  108,  109,  109,  108,
			  109,  109,  108,  109,  109,   78,  108,  109,   78,  109,
			  108,  109,  109,   80,  108,  109,   80,  109,   82,  108,
			  109,   82,  109,  108,  109,  109,   85,  108,  109,   85,
			  109,  108,  109,  108,  109,  109,  109,  108,  109,  109,
			  108,  109,  109,  108,  109,  109,  108,  109,  109,  108,
			  109,  108,  109,  109,  109,  108,  109,  109,  108,  109, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  109,  108,  109,  109,  108,  109,  109,   99,  108,  109,
			   99,  109,  100,  108,  109,  100,  109,  108,  109,  109,
			  108,  109,  109,  108,  109,  109,  108,  109,  109,  105,
			  108,  109,  105,  109,  106,  108,  109,  106,  109,  143,
			  143,  143,  143,  134,  134,  134,  157,  157,  160,  157,
			  160,  156,  157,  159,  160,  156,  159,  147,  154,   40,
			  108,  109,   40,  109,   41,  108,  109,   41,  109,  108,
			  109,  109,  108,  109,  109,  108,  109,  109,   49,  108,
			  109,   49,  109,   50,  108,  109,   50,  109,  108,  109,
			  109,  108,  109,  109,  108,  109,  109,   55,  108,  109,

			   55,  109,  108,  109,  109,  108,  109,  109,  108,  109,
			  109,  108,  109,  109,  108,  109,  109,  108,  109,  109,
			  108,  109,  109,   66,  108,  109,   66,  109,  108,  109,
			  109,  108,  109,  109,  108,  109,  109,  108,  109,  109,
			   73,  108,  109,   73,  109,  108,  109,  109,  108,  109,
			  109,  108,  109,  109,   79,  108,  109,   79,  109,  108,
			  109,  109,  108,  109,  109,  108,  109,  109,  108,  109,
			  109,  108,  109,  109,  108,  109,  109,  108,  109,  109,
			  108,  109,  109,  108,  109,  109,   95,  108,  109,   95,
			  109,  108,  109,  109,  108,  109,  109,   98,  108,  109,

			   98,  109,  108,  109,  109,  108,  109,  109,  103,  108,
			  109,  103,  109,  108,  109,  109,  133,  157,  160,  160,
			  157,  156,  157,  159,  160,  156,  159,  155,   45,  108,
			  109,   45,  109,  108,  109,  109,  108,  109,  109,  108,
			  109,  109,   52,  108,  109,  108,  109,   52,  109,  109,
			  108,  109,  109,  108,  109,  109,  108,  109,  109,   60,
			  108,  109,   60,  109,   62,  108,  109,   62,  109,  108,
			  109,  109,   64,  108,  109,   64,  109,  108,  109,  109,
			  108,  109,  109,   69,  108,  109,   69,  109,  108,  109,
			  109,  108,  109,  109,  108,  109,  109,  108,  109,  109,

			  108,  109,  109,  108,  109,  109,  108,  109,  109,   88,
			  108,  109,   88,  109,  108,  109,  109,  108,  109,  109,
			   91,  108,  109,   91,  109,  108,  109,  109,   93,  108,
			  109,   93,  109,   94,  108,  109,   94,  109,   96,  108,
			  109,   96,  109,  108,  109,  109,  108,  109,  109,  102,
			  108,  109,  102,  109,  108,  109,  109,  157,  156,  157,
			  159,  160,  160,  156,  158,  160,  158,  108,  109,  109,
			  108,  109,  109,   51,  108,  109,   51,  109,  108,  109,
			  109,   54,  108,  109,   54,  109,  108,  109,  109,  108,
			  109,  109,  108,  109,  109,  108,  109,  109,   67,  108,

			  109,   67,  109,   71,  108,  109,   71,  109,  108,  109,
			  109,   74,  108,  109,   74,  109,   75,  108,  109,   75,
			  109,  108,  109,  109,  108,  109,  109,  108,  109,  109,
			  108,  109,  109,  108,  109,  109,   92,  108,  109,   92,
			  109,  108,  109,  109,  108,  109,  109,  104,  108,  109,
			  104,  109,  160,  160,  156,  157,  159,  160,  159,   46,
			  108,  109,   46,  109,  108,  109,  109,   53,  108,  109,
			   53,  109,   56,  108,  109,   56,  109,  108,  109,  109,
			   63,  108,  109,   63,  109,   65,  108,  109,   65,  109,
			   72,  108,  109,   72,  109,  108,  109,  109,   83,  108,

			  109,   83,  109,  108,  109,  109,   90,  108,  109,   90,
			  109,  108,  109,  109,   97,  108,  109,   97,  109,  101,
			  108,  109,  101,  109,  160,  159,  160,  159,  160,  159,
			   47,  108,  109,   47,  109,  108,  109,  109,   76,  108,
			  109,   76,  109,   87,  108,  109,   87,  109,   89,  108,
			  109,   89,  109,  159,  160,   57,  108,  109,   57,  109, yy_Dummy>>,
			1, 560, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 9921
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 1060
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 1061
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 163
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 164
			-- End of buffer rule code

	yyLine_used: BOOLEAN = false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
	VERBATIM_STR1: INTEGER = 1
			-- Start condition codes

feature -- User-defined features



note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- EDITOR_EIFFEL_SCANNER
