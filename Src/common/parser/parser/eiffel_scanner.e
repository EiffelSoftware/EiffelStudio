indexing

	description: "Scanners for Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_SCANNER

inherit

	EIFFEL_SCANNER_SKELETON

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
--|#line 38
current_position.go_to (text_count)
when 2 then
--|#line 43
current_position.go_to (text_count)
when 3 then
--|#line 44

				line_number := line_number + text_count
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 4 then
--|#line 53

				nb_tilde := text_count
				current_position.go_to (nb_tilde)
				last_token := TE_TILDE
			
when 5 then
--|#line 58

				current_position.go_to (1)
				last_token := TE_SEMICOLON
			
when 6 then
--|#line 62

				current_position.go_to (1)
				last_token := TE_COLON
			
when 7 then
--|#line 66

				current_position.go_to (1)
				last_token := TE_COMMA
			
when 8 then
--|#line 70

				current_position.go_to (2)
				last_token := TE_DOTDOT
			
when 9 then
--|#line 74

				current_position.go_to (1)
				last_token := TE_DOT
			
when 10 then
--|#line 78

				current_position.go_to (1)
				last_token := TE_ADDRESS
			
when 11 then
--|#line 82

				current_position.go_to (2)
				last_token := TE_ASSIGN
			
when 12 then
--|#line 86

				current_position.go_to (2)
				last_token := TE_ACCEPT
			
when 13 then
--|#line 90

				current_position.go_to (1)
				last_token := TE_EQ
			
when 14 then
--|#line 94

				current_position.go_to (1)
				last_token := TE_LT
			
when 15 then
--|#line 98

				current_position.go_to (1)
				last_token := TE_GT
			
when 16 then
--|#line 102

				current_position.go_to (2)
				last_token := TE_LE
			
when 17 then
--|#line 106

				current_position.go_to (2)
				last_token := TE_GE
			
when 18 then
--|#line 110

				current_position.go_to (2)
				last_token := TE_NE
			
when 19 then
--|#line 114

				current_position.go_to (1)
				last_token := TE_LPARAN
			
when 20 then
--|#line 118

				current_position.go_to (1)
				last_token := TE_RPARAN
			
when 21 then
--|#line 122

				current_position.go_to (1)
				last_token := TE_LCURLY
			
when 22 then
--|#line 126

				current_position.go_to (1)
				last_token := TE_RCURLY
			
when 23 then
--|#line 130

				current_position.go_to (1)
				last_token := TE_LSQURE
			
when 24 then
--|#line 134

				current_position.go_to (1)
				last_token := TE_RSQURE
			
when 25 then
--|#line 138

				current_position.go_to (1)
				last_token := TE_PLUS
			
when 26 then
--|#line 142

				current_position.go_to (1)
				last_token := TE_MINUS
			
when 27 then
--|#line 146

				current_position.go_to (1)
				last_token := TE_STAR
			
when 28 then
--|#line 150

				current_position.go_to (1)
				last_token := TE_SLASH
			
when 29 then
--|#line 154

				current_position.go_to (1)
				last_token := TE_POWER
			
when 30 then
--|#line 158

				current_position.go_to (2)
				last_token := TE_CONSTRAIN
			
when 31 then
--|#line 162

				current_position.go_to (1)
				last_token := TE_BANG
			
when 32 then
--|#line 166

				current_position.go_to (2)
				last_token := TE_LARRAY
			
when 33 then
--|#line 170

				current_position.go_to (2)
				last_token := TE_RARRAY
			
when 34 then
--|#line 174

				current_position.go_to (2)
				last_token := TE_DIV
			
when 35 then
--|#line 178

				current_position.go_to (2)
				last_token := TE_MOD
			
when 36 then
--|#line 186

					-- Note: Free operators are converted to lower-case.
				token_buffer.clear_all
				-- token_buffer.append_string (text)
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := TE_FREE
			
when 37 then
--|#line 199

				current_position.go_to (5)
				last_token := TE_ALIAS
			
when 38 then
--|#line 203

				current_position.go_to (3)
				last_token := TE_ALL
			
when 39 then
--|#line 207

				current_position.go_to (3)
				last_token := TE_AND
			
when 40 then
--|#line 211

				current_position.go_to (2)
				last_token := TE_AS
			
when 41 then
--|#line 215

				current_position.go_to (3)
				last_token := TE_BIT
			
when 42 then
--|#line 219

				current_position.go_to (5)
				last_token := TE_CHECK
			
when 43 then
--|#line 223

				current_position.go_to (5)
				last_token := TE_CLASS
			
when 44 then
--|#line 227

				current_position.go_to (6)
				last_token := TE_CREATION
			
when 45 then
--|#line 231

				current_position.go_to (8)
				last_token := TE_CREATION
			
when 46 then
--|#line 235

				current_position.go_to (7)
				last_token := TE_CURRENT
			
when 47 then
--|#line 239

				current_position.go_to (5)
				last_token := TE_DEBUG
			
when 48 then
--|#line 243

				current_position.go_to (8)
				last_token := TE_DEFERRED
			
when 49 then
--|#line 247

				current_position.go_to (2)
				last_token := TE_DO
			
when 50 then
--|#line 251

				current_position.go_to (4)
				last_token := TE_ELSE
			
when 51 then
--|#line 255

				current_position.go_to (6)
				last_token := TE_ELSEIF
			
when 52 then
--|#line 259

				current_position.go_to (3)
				last_token := TE_END
			
when 53 then
--|#line 263

				current_position.go_to (6)
				last_token := TE_ENSURE
			
when 54 then
--|#line 267

				current_position.go_to (8)
				last_token := TE_EXPANDED
			
when 55 then
--|#line 271

				current_position.go_to (6)
				last_token := TE_EXPORT
			
when 56 then
--|#line 275

				current_position.go_to (8)
				last_token := TE_EXTERNAL
			
when 57 then
--|#line 279

				current_position.go_to (5)
				last_token := TE_FALSE
			
when 58 then
--|#line 283

				current_position.go_to (7)
				last_token := TE_FEATURE
			
when 59 then
--|#line 287

				current_position.go_to (4)
				last_token := TE_FROM
			
when 60 then
--|#line 291

				current_position.go_to (6)
				last_token := TE_FROZEN
			
when 61 then
--|#line 295

				current_position.go_to (2)
				last_token := TE_IF
			
when 62 then
--|#line 299

				current_position.go_to (7)
				last_token := TE_IMPLIES
			
when 63 then
--|#line 303

				current_position.go_to (8)
				last_token := TE_INDEXING
			
when 64 then
--|#line 307

				current_position.go_to (5)
				last_token := TE_INFIX
			
when 65 then
--|#line 311

				current_position.go_to (7)
				last_token := TE_INHERIT
			
when 66 then
--|#line 315

				current_position.go_to (7)
				last_token := TE_INSPECT
			
when 67 then
--|#line 319

				current_position.go_to (9)
				last_token := TE_INVARIANT
			
when 68 then
--|#line 323

				current_position.go_to (2)
				last_token := TE_IS
			
when 69 then
--|#line 327

				current_position.go_to (4)
				last_token := TE_LIKE
			
when 70 then
--|#line 331

				current_position.go_to (5)
				last_token := TE_LOCAL
			
when 71 then
--|#line 335

				current_position.go_to (4)
				last_token := TE_LOOP
			
when 72 then
--|#line 339

				current_position.go_to (3)
				last_token := TE_NOT
			
when 73 then
--|#line 343

				current_position.go_to (8)
				last_token := TE_OBSOLETE
			
when 74 then
--|#line 347

				current_position.go_to (3)
				last_token := TE_OLD
			
when 75 then
--|#line 351

				current_position.go_to (4)
				last_token := TE_ONCE
			
when 76 then
--|#line 355

				current_position.go_to (2)
				last_token := TE_OR
			
when 77 then
--|#line 359

				current_position.go_to (9)
				last_token := TE_PRECURSOR
			
when 78 then
--|#line 363

				current_position.go_to (6)
				last_token := TE_PREFIX
			
when 79 then
--|#line 367

				current_position.go_to (8)
				last_token := TE_REDEFINE
			
when 80 then
--|#line 371

				current_position.go_to (6)
				last_token := TE_RENAME
			
when 81 then
--|#line 375

				current_position.go_to (7)
				last_token := TE_REQUIRE
			
when 82 then
--|#line 379

				current_position.go_to (6)
				last_token := TE_RESCUE
			
when 83 then
--|#line 383

				current_position.go_to (6)
				last_token := TE_RESULT
			
when 84 then
--|#line 387

				current_position.go_to (5)
				last_token := TE_RETRY
			
when 85 then
--|#line 391

				current_position.go_to (6)
				last_token := TE_SELECT
			
when 86 then
--|#line 395

				current_position.go_to (8)
				last_token := TE_SEPARATE
			
when 87 then
--|#line 399

				current_position.go_to (5)
				last_token := TE_STRIP
			
when 88 then
--|#line 403

				current_position.go_to (4)
				last_token := TE_THEN
			
when 89 then
--|#line 407

				current_position.go_to (4)
				last_token := TE_TRUE
			
when 90 then
--|#line 411

				current_position.go_to (8)
				last_token := TE_UNDEFINE
			
when 91 then
--|#line 415

				current_position.go_to (6)
				last_token := TE_UNIQUE
			
when 92 then
--|#line 419

				current_position.go_to (5)
				last_token := TE_UNTIL
			
when 93 then
--|#line 423

				current_position.go_to (7)
				last_token := TE_VARIANT
			
when 94 then
--|#line 427

				current_position.go_to (4)
				last_token := TE_WHEN
			
when 95 then
--|#line 431

				current_position.go_to (3)
				last_token := TE_XOR
			
when 96 then
--|#line 439

				current_position.go_to (7)
				last_token := TE_BOOLEAN_ID
			
when 97 then
--|#line 443

				current_position.go_to (9)
				last_token := TE_CHARACTER_ID
			
when 98 then
--|#line 447

				current_position.go_to (6)
				last_token := TE_DOUBLE_ID
			
when 99 then
--|#line 451

				current_position.go_to (7)
				last_token := TE_INTEGER_ID
			
when 100 then
--|#line 455

				current_position.go_to (4)
				last_token := TE_NONE_ID
			
when 101 then
--|#line 459

				current_position.go_to (7)
				last_token := TE_POINTER_ID
			
when 102 then
--|#line 463

				current_position.go_to (4)
				last_token := TE_REAL_ID
			
when 103 then
--|#line 467

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				--token_buffer.append_string (text)
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 104 then
--|#line 480

				token_buffer.clear_all
				--token_buffer.append_string (text_substring (1, text_count - 1))
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				current_position.go_to (token_buffer.count + 1)
				last_token := TE_A_BIT
			
when 105 then
--|#line 491
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				--token_buffer.append_string (text)
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_INTEGER
			
when 106 then
	yy_position := yy_position - 2
--|#line 492
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				--token_buffer.append_string (text)
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_INTEGER
			
when 107 then
--|#line 506

				token_buffer.clear_all
				append_without_underscores (text, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 108 then
--|#line 516

-- TO DO: remove '_'
--				return process_name(TE_REAL);
				token_buffer.clear_all
				--token_buffer.append_string (text)
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (text_count)
				last_token := TE_REAL
			
when 109 then
--|#line 530

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 110 then
--|#line 536

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 111 then
--|#line 543

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 112 then
--|#line 549

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 113 then
--|#line 555

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 114 then
--|#line 561

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 115 then
--|#line 567

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 116 then
--|#line 573

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 117 then
--|#line 579

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 118 then
--|#line 585

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 119 then
--|#line 591

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 120 then
--|#line 597

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 121 then
--|#line 603

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 122 then
--|#line 609

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 123 then
--|#line 615

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 124 then
--|#line 621

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 125 then
--|#line 627

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 126 then
--|#line 633

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 127 then
--|#line 639

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 128 then
--|#line 645

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 129 then
--|#line 651

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 130 then
--|#line 657

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 131 then
--|#line 663

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 132 then
--|#line 669

				current_position.go_to (text_count)
				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 133, 134 then
--|#line 673

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				current_position.go_to (text_count)
				last_token := EIF_ERROR5
			
when 135 then
--|#line 684

					-- Empty string.
				token_buffer.clear_all
				current_position.go_to (2)
				last_token := EIF_ERROR6
			
when 136 then
--|#line 690

				token_buffer.clear_all
				--token_buffer.append_string (text_substring (2, text_count - 1))
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STRING
			
when 137 then
--|#line 697

				token_buffer.clear_all
				if text_count > 1 then
					--token_buffer.append_string (text_substring (2, text_count))
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (IN_STR)
			
when 138 then
--|#line 707

				current_position.go_to (text_count)
				--token_buffer.append_string (text)
				append_text_to_string (token_buffer)
			
when 139 then
--|#line 712

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 140 then
--|#line 716

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 141 then
--|#line 720

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 142 then
--|#line 724

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 143 then
--|#line 728

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 144 then
--|#line 732

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 145 then
--|#line 736

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 146 then
--|#line 740

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 147 then
--|#line 744

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 148 then
--|#line 748

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 149 then
--|#line 752

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 150 then
--|#line 756

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 151 then
--|#line 760

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 152 then
--|#line 764

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 153 then
--|#line 768

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 154 then
--|#line 772

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 155 then
--|#line 776

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 156 then
--|#line 780

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 157 then
--|#line 784

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 158 then
--|#line 788

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 159 then
--|#line 792

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 160 then
--|#line 796

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 161 then
--|#line 800

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 162 then
--|#line 807

				if text_count > 1 then
					--token_buffer.append_string (text_substring (1, text_count - 1))
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (INITIAL)
				if token_buffer.empty then
						-- Empty string.
					last_token := EIF_ERROR6
				else
					last_token := TE_STRING
				end
			
when 163 then
--|#line 821

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				last_token := EIF_ERROR3
			
when 164 then
--|#line 827

					-- No final double-quote.
				line_number := line_number + 1
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				last_token := EIF_ERROR4
			
when 165 then
--|#line 853

				current_position.go_to (1)
				report_error ("")
			
when 166 then
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

				if inherit_context then
					inherit_context := False
					last_token := TE_END
				else
					terminate
				end
			
when 1 then
--|#line 0

					-- No final double-quote.
				set_start_condition (INITIAL)
				last_token := EIF_ERROR4
			
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
			    0,    6,    7,    8,    9,   10,   11,   12,    6,   11,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   25,   26,   27,   28,   29,   11,   30,   31,
			   32,   33,   34,   35,   36,   36,   37,   36,   36,   38,
			   36,   39,   40,   41,   36,   42,   43,   44,   45,   46,
			   47,   48,   36,   36,   49,   50,   51,   52,    6,    6,
			   30,   31,   32,   33,   34,   35,   36,   36,   37,   36,
			   36,   38,   36,   39,   40,   41,   36,   42,   43,   44,
			   45,   46,   47,   48,   36,   36,   53,   11,   54,   55,
			   57,   57,   58,   58,   68,   59,   59,   66,   70,   67,

			   71,   71,   73,   69,   81,   82,  330,   75,   74,   76,
			   77,  384,   75,   72,   77,   77,   83,   84,   87,   78,
			   88,  267,   90,   92,   96,   89,  101,   93,   91,   98,
			  102,   99,  266,   94,   97,  110,   95,  265,  108,  188,
			  188,  100,  117,  103,  109,   72,  245,  245,   79,  264,
			   87,   78,   88,   79,   90,   92,   96,   89,  101,   93,
			   91,   98,  102,   99,  104,   94,   97,  110,   95,  111,
			  108,  105,  106,  100,  117,  103,  109,  107,  118,  112,
			  115,  113,  120,  116,  122,  114,  123,  124,  125,  191,
			  192,  193,  121,  119,  179,  179,  104,  251,  251,  263,

			  181,  111,  181,  105,  106,  182,  182,  180,  196,  107,
			  118,  112,  115,  113,  120,  116,  122,  114,  123,  124,
			  125,  191,  192,  193,  121,  119,  130,  130,  183,  131,
			  184,  184,  132,  262,  133,  134,  135,  182,  182,  180,
			  196,  390,  136,  185,  197,  261,  198,  137,   75,  138,
			  187,  187,  139,  140,  141,  142,  201,  143,  189,  144,
			  260,  190,  259,  145,  202,  146,  182,  182,  147,  148,
			  149,  150,  151,  152,  156,  185,  197,  157,  198,  158,
			  159,  160,   79,   75,  258,  186,  187,  161,  201,   79,
			  189,  203,  162,  190,  163,   78,  202,  164,  165,  166,

			  167,  194,  168,  199,  169,  195,  204,  200,  170,  207,
			  171,  208,  209,  172,  173,  174,  175,  176,  177,  210,
			  217,  205,  222,  203,   79,  206,  223,   78,  218,  224,
			  211,  225,  212,  194,  213,  199,  220,  195,  204,  200,
			  219,  207,  221,  208,  209,  214,  215,  226,  216,  235,
			  236,  210,  217,  205,  222,  233,  257,  206,  223,  234,
			  218,  224,  211,  225,  212,  237,  213,  241,  220,  256,
			  227,  242,  219,  228,  221,  243,  255,  214,  215,  226,
			  216,  235,  236,  229,  278,  238,  230,  233,  231,  232,
			  239,  234,  130,  130,  279,  268,  268,  237,  244,  241,

			  254,  240,  227,  242,  269,  228,  269,  243,  180,  270,
			  270,  271,  271,  277,  277,  229,  278,  238,  230,  280,
			  231,  232,  239,  273,  272,  273,  279,  281,  274,  274,
			  282,  283,   75,  240,  275,  276,   75,  284,  276,  276,
			  180,  253,  285,  286,   78,  252,  287,  288,  289,  292,
			  290,  280,  293,  294,  295,  297,  272,  298,  299,  281,
			  300,  301,  282,  283,  291,  302,  303,  296,  304,  284,
			  305,  306,  307,   79,  285,  286,   78,   79,  287,  288,
			  289,  292,  290,  308,  293,  294,  295,  297,  309,  298,
			  299,  310,  300,  301,  313,  314,  291,  302,  303,  296,

			  304,  315,  305,  306,  307,  311,  316,  317,  312,  319,
			  320,  321,  322,  323,  324,  308,  325,  326,  327,  328,
			  309,  329,  250,  310,  340,  318,  313,  314,  330,  331,
			  331,  270,  270,  315,  332,  251,  251,  311,  316,  317,
			  312,  319,  320,  321,  322,  323,  324,  249,  325,  326,
			  327,  328,  248,  329,  333,  333,  340,  318,  270,  270,
			  335,  335,  341,  336,  342,  336,  343,  180,  337,  337,
			  274,  274,  344,  272,  274,  274,  338,  345,  275,  276,
			  338,  346,  276,  276,  339,  339,  347,  348,   78,  349,
			  350,  351,  352,  334,  341,  353,  342,  354,  343,  180,

			  355,  356,  357,  358,  344,  272,  359,  360,  361,  345,
			  362,  363,  364,  346,  365,  366,  367,  368,  347,  348,
			   78,  349,  350,  351,  352,  369,  370,  353,  371,  354,
			  372,  373,  355,  356,  357,  358,  374,  375,  359,  360,
			  361,  376,  362,  363,  364,  377,  365,  366,  367,  368,
			  378,  379,  380,  381,  382,  386,  386,  369,  370,  247,
			  371,  246,  372,  373,  330,  383,  383,  391,  374,  375,
			  337,  337,  392,  376,  333,  333,  395,  377,  387,  387,
			  337,  337,  378,  379,  380,  381,  382,  385,  396,  397,
			  183,  272,  387,  387,  393,  398,  399,  400,  394,  391,

			  401,  402,  403,  404,  392,  389,  405,  406,  395,  407,
			  408,  409,  410,  411,  412,  413,  414,  388,  415,  385,
			  396,  397,  416,  272,  417,  418,  393,  398,  399,  400,
			  394,  419,  401,  402,  403,  404,  420,  389,  405,  406,
			  421,  407,  408,  409,  410,  411,  412,  413,  414,  422,
			  415,  423,  424,  425,  416,  425,  417,  418,  426,  426,
			  427,  427,  433,  419,  387,  387,  429,  429,  420,  430,
			  434,  430,  421,   72,  431,  431,  435,  428,  429,  429,
			  436,  422,  437,  423,  424,  438,  439,  440,  441,  442,
			  443,  432,  444,  445,  433,  446,  447,  448,  449,  450,

			  451,  452,  434,  453,  454,   72,  426,  426,  435,  428,
			  426,  426,  436,  129,  437,  431,  431,  438,  439,  440,
			  441,  442,  443,  432,  444,  445,  461,  446,  447,  448,
			  449,  450,  451,  452,  462,  453,  454,  455,  455,  456,
			  463,  456,  458,  458,  457,  457,  431,  431,  464,  465,
			   72,  459,  466,  459,  467,  432,  460,  460,  461,  468,
			  469,  470,  471,  472,   72,  474,  462,  457,  457,  457,
			  457,  475,  463,  460,  460,  473,  473,  460,  460,  476,
			  464,  465,   72,  432,  466,  127,  467,  432,  432,  178,
			  334,  468,  469,  470,  471,  472,   72,  474,  155,  153,

			   61,   60,  129,  475,  127,  126,   85,   80,   63,  388,
			   61,  476,   60,  477,  477,  432,  477,  477,  477,  477,
			  432,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   62,  477,   62,  477,   62,   62,   62,   62,
			   62,   62,   62,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   65,  477,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   86,   86,   86,   86,   86,   86,   86,
			  128,  477,  128,  477,  128,  128,  128,  128,  128,  128,
			  128,  154,  477,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,   68,  477,   68,   68,   68,   68,   68,   68,

			   68,   68,   68,    5,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477>>)
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
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    4,    3,    4,   19,    3,    4,   13,   20,   13,

			   20,   20,   21,   19,   26,   26,  383,   22,   21,   22,
			   22,  332,   23,   20,   23,   23,   28,   28,   30,   22,
			   30,  177,   31,   32,   33,   30,   35,   32,   31,   34,
			   35,   34,  176,   32,   33,   39,   32,  175,   38,   79,
			   79,   34,   42,   35,   38,   20,  136,  136,   22,  174,
			   30,   22,   30,   23,   31,   32,   33,   30,   35,   32,
			   31,   34,   35,   34,   37,   32,   33,   39,   32,   40,
			   38,   37,   37,   34,   42,   35,   38,   37,   43,   40,
			   41,   40,   44,   41,   45,   40,   46,   47,   48,   88,
			   90,   91,   44,   43,   71,   71,   37,  161,  161,  173,

			   72,   40,   72,   37,   37,   72,   72,   71,   93,   37,
			   43,   40,   41,   40,   44,   41,   45,   40,   46,   47,
			   48,   88,   90,   91,   44,   43,   59,   59,   75,   59,
			   75,   75,   59,  172,   59,   59,   59,  181,  181,   71,
			   93,  339,   59,   75,   94,  171,   95,   59,   77,   59,
			   77,   77,   59,   59,   59,   59,   97,   59,   87,   59,
			  170,   87,  169,   59,   98,   59,  182,  182,   59,   59,
			   59,   59,   59,   59,   66,   75,   94,   66,   95,   66,
			   66,   66,  339,   76,  168,   76,   76,   66,   97,   77,
			   87,   99,   66,   87,   66,   76,   98,   66,   66,   66,

			   66,   92,   66,   96,   66,   92,   99,   96,   66,  101,
			   66,  102,  103,   66,   66,   66,   66,   66,   66,  105,
			  108,  100,  111,   99,   76,  100,  112,   76,  109,  113,
			  106,  115,  106,   92,  106,   96,  110,   92,   99,   96,
			  109,  101,  110,  102,  103,  106,  106,  116,  106,  119,
			  120,  105,  108,  100,  111,  118,  167,  100,  112,  118,
			  109,  113,  106,  115,  106,  121,  106,  123,  110,  166,
			  117,  124,  109,  117,  110,  125,  165,  106,  106,  116,
			  106,  119,  120,  117,  189,  122,  117,  118,  117,  117,
			  122,  118,  130,  130,  193,  179,  179,  121,  130,  123,

			  164,  122,  117,  124,  180,  117,  180,  125,  179,  180,
			  180,  184,  184,  188,  188,  117,  189,  122,  117,  194,
			  117,  117,  122,  185,  184,  185,  193,  195,  185,  185,
			  196,  197,  186,  122,  186,  186,  187,  198,  187,  187,
			  179,  163,  199,  200,  186,  162,  201,  202,  204,  206,
			  205,  194,  207,  208,  209,  210,  184,  211,  212,  195,
			  213,  214,  196,  197,  205,  215,  216,  209,  217,  198,
			  218,  219,  220,  186,  199,  200,  186,  187,  201,  202,
			  204,  206,  205,  222,  207,  208,  209,  210,  224,  211,
			  212,  225,  213,  214,  227,  228,  205,  215,  216,  209,

			  217,  229,  218,  219,  220,  226,  230,  231,  226,  232,
			  233,  234,  235,  236,  237,  222,  238,  239,  240,  241,
			  224,  242,  160,  225,  278,  231,  227,  228,  245,  245,
			  245,  269,  269,  229,  251,  251,  251,  226,  230,  231,
			  226,  232,  233,  234,  235,  236,  237,  159,  238,  239,
			  240,  241,  158,  242,  268,  268,  278,  231,  270,  270,
			  271,  271,  279,  272,  280,  272,  281,  268,  272,  272,
			  273,  273,  282,  271,  274,  274,  275,  283,  275,  275,
			  276,  284,  276,  276,  277,  277,  285,  286,  275,  287,
			  288,  289,  290,  268,  279,  291,  280,  292,  281,  268,

			  293,  294,  296,  297,  282,  271,  298,  299,  300,  283,
			  301,  302,  303,  284,  305,  308,  310,  311,  285,  286,
			  275,  287,  288,  289,  290,  312,  314,  291,  315,  292,
			  316,  317,  293,  294,  296,  297,  318,  319,  298,  299,
			  300,  320,  301,  302,  303,  321,  305,  308,  310,  311,
			  322,  325,  326,  327,  328,  334,  334,  312,  314,  157,
			  315,  156,  316,  317,  331,  331,  331,  341,  318,  319,
			  336,  336,  342,  320,  333,  333,  346,  321,  335,  335,
			  337,  337,  322,  325,  326,  327,  328,  333,  348,  349,
			  338,  335,  338,  338,  345,  350,  351,  352,  345,  341,

			  353,  354,  356,  357,  342,  338,  358,  359,  346,  361,
			  362,  363,  364,  366,  367,  368,  369,  335,  370,  333,
			  348,  349,  371,  335,  372,  373,  345,  350,  351,  352,
			  345,  374,  353,  354,  356,  357,  376,  338,  358,  359,
			  377,  361,  362,  363,  364,  366,  367,  368,  369,  379,
			  370,  380,  382,  385,  371,  385,  372,  373,  385,  385,
			  386,  386,  391,  374,  387,  387,  388,  388,  376,  389,
			  392,  389,  377,  386,  389,  389,  394,  387,  390,  390,
			  395,  379,  396,  380,  382,  400,  402,  403,  405,  406,
			  407,  390,  408,  409,  391,  410,  411,  412,  413,  415,

			  417,  421,  392,  422,  424,  386,  425,  425,  394,  387,
			  426,  426,  395,  128,  396,  430,  430,  400,  402,  403,
			  405,  406,  407,  390,  408,  409,  434,  410,  411,  412,
			  413,  415,  417,  421,  435,  422,  424,  427,  427,  428,
			  437,  428,  429,  429,  428,  428,  431,  431,  438,  439,
			  427,  432,  442,  432,  446,  429,  432,  432,  434,  447,
			  449,  450,  452,  453,  455,  461,  435,  456,  456,  457,
			  457,  467,  437,  459,  459,  458,  458,  460,  460,  469,
			  438,  439,  427,  473,  442,  127,  446,  429,  458,   67,
			  455,  447,  449,  450,  452,  453,  455,  461,   65,   62,

			   61,   60,   56,  467,   55,   50,   29,   24,   10,  473,
			    8,  469,    7,    5,    0,  473,    0,    0,    0,    0,
			  458,  478,  478,  478,  478,  478,  478,  478,  478,  478,
			  478,  478,  479,    0,  479,    0,  479,  479,  479,  479,
			  479,  479,  479,  480,  480,  480,  480,  480,  480,  480,
			  480,  480,  481,    0,  481,  481,  481,  481,  481,  481,
			  481,  481,  481,  482,  482,  482,  482,  482,  482,  482,
			  483,    0,  483,    0,  483,  483,  483,  483,  483,  483,
			  483,  484,    0,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  485,    0,  485,  485,  485,  485,  485,  485,

			  485,  485,  485,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   87,   88,  913, 1003,  910,  907, 1003,
			  903,    0, 1003,   89, 1003, 1003, 1003, 1003, 1003,   78,
			   81,   84,   90,   95,  883, 1003,   81, 1003,   92,  882,
			   79,   86,   88,   92,   90,   98,    0,  131,  102,   93,
			  140,  138,  110,  146,  147,  143,  158,  152,  146, 1003,
			  850, 1003, 1003, 1003, 1003,  815,  897, 1003, 1003,  224,
			  899,  897,  894, 1003,    0,  888,  269,  879,    0, 1003,
			 1003,  175,  186, 1003, 1003,  211,  266,  231, 1003,  120,
			 1003, 1003, 1003, 1003, 1003, 1003,    0,  222,  158,    0,
			  143,  149,  273,  180,  212,  201,  274,  208,  218,  260,

			  278,  270,  283,  270,    0,  276,  299,    0,  282,  298,
			  295,  276,  295,  299,    0,  295,  315,  342,  316,  304,
			  318,  317,  354,  322,  339,  330, 1003,  796,  808, 1003,
			  390, 1003, 1003, 1003, 1003, 1003,  127, 1003, 1003, 1003,
			 1003, 1003, 1003, 1003, 1003, 1003, 1003, 1003, 1003, 1003,
			 1003, 1003, 1003, 1003, 1003, 1003,  651,  649,  542,  537,
			  512,  178,  435,  431,  390,  366,  359,  346,  274,  252,
			  250,  235,  223,  189,  139,  127,  122,  111, 1003,  376,
			  390,  218,  247, 1003,  392,  409,  415,  419,  394,  356,
			    0,    0,    0,  355,  374,  397,  384,  403,  392,  394,

			  411,  417,  415,    0,  400,  422,  417,  406,  406,  414,
			  416,  425,  422,  428,  418,  433,  438,  436,  442,  428,
			  440,    0,  441,    0,  456,  450,  475,  455,  463,  473,
			  458,  477,  464,  478,  483,  476,  472,  482,  484,  473,
			  482,  483,  480,    0, 1003,  510, 1003, 1003, 1003, 1003,
			 1003,  516, 1003, 1003, 1003, 1003, 1003, 1003, 1003, 1003,
			 1003, 1003, 1003, 1003, 1003, 1003, 1003, 1003,  535,  512,
			  539,  541,  549,  551,  555,  559,  563,  565,  478,  530,
			  536,  528,  526,  530,  549,  552,  542,  550,  554,  546,
			  551,  550,  552,  568,  553,    0,  570,  567,  555,  556,

			  563,  578,  577,  567,    0,  575,    0,    0,  576,    0,
			  569,  569,  589,    0,  593,  588,  594,  583,  597,  585,
			  611,  600,  607,    0,    0,  618,  604,  614,  626,    0,
			 1003,  646,  101,  655,  636,  659,  651,  661,  673,  224,
			    0,  639,  642,    0,    0,  662,  635,    0,  643,  657,
			  662,  664,  666,  653,  660,    0,  657,  662,  674,  671,
			    0,  673,  680,  679,  676,    0,  681,  682,  670,  665,
			  682,  690,  679,  693,  684,    0,  689,  712,    0,  713,
			  719,    0,  711,   88, 1003,  739,  741,  745,  747,  755,
			  759,  721,  723,    0,  734,  733,  750,    0,    0,    0,

			  753,    0,  758,  755,    0,  742,  748,  743,  745,  748,
			  767,  749,  752,  752,    0,  758,    0,  768,    0,    0,
			    0,  754,  762,    0,  757,  787,  791,  818,  825,  823,
			  796,  827,  837,    0,  794,  793,    0,  809,  817,  810,
			    0,    0,  818,    0,    0,    0,  813,  827,    0,  818,
			  829,    0,  830,  831,    0,  832,  848,  850,  856,  854,
			  858,  820,    0,    0,    0,    0,    0,  824,    0,  834,
			    0,    0,    0,  851,    0,    0,    0, 1003,  920,  931,
			  940,  951,  958,  969,  980,  991>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  477,    1,  478,  478,  477,  477,  477,  477,  477,
			  479,  480,  477,  481,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  477,
			  477,  477,  477,  477,  477,  477,  483,  477,  477,  477,
			  477,  477,  479,  477,  480,  484,  484,  484,  485,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,

			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  477,  477,  483,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,

			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,

			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  477,  477,  477,  477,  477,  477,  477,
			  477,  482,  482,  482,  482,  482,  482,  482,  482,  482,

			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  477,  477,  477,  477,  477,
			  477,  477,  477,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  477,  477,  477,  477,  477,
			  477,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  477,  482,  482,  482,    0,  477,  477,
			  477,  477,  477,  477,  477,  477>>)
		end

	yy_ec_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   19,
			   20,   20,   20,   20,   20,   20,   20,   20,   21,   22,
			   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   40,   41,   42,
			   43,   44,   45,   46,   47,   48,   49,   50,   51,   52,
			   53,   54,   55,   56,   57,   58,   59,   60,   61,   62,

			   63,   64,   65,   66,   67,   68,   69,   70,   71,   72,
			   73,   74,   75,   76,   77,   78,   79,   80,   81,   82,
			   83,   84,   85,   86,   87,   88,   89,    1,    1,    1,
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
			    0,    1,    1,    2,    3,    3,    3,    3,    4,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    5,
			    6,    3,    3,    3,    3,    3,    3,    3,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    7,    8,    3,    3,    3,    3,    9,    3,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,   10,   11,    3,    3,    3,    3>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,  167,  165,    2,    3,   31,
			  137,   36,   10,  133,   19,   20,   27,   25,    7,   26,
			    9,   28,  105,  105,    6,    5,   14,   13,   15,  165,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,   23,
			  165,   24,   29,   21,   22,    4,  138,  164,  162,  163,
			    2,    3,  137,  135,   36,  133,  133,  133,    1,   30,
			    8,  108,    0,   34,   18,  108,  105,  105,  104,    0,
			   11,   32,   16,   17,   33,   12,  103,  103,  103,   40,
			  103,  103,  103,  103,  103,  103,  103,   49,  103,  103,

			  103,  103,  103,  103,   61,  103,  103,   68,  103,  103,
			  103,  103,  103,  103,   76,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,   35,    4,  138,  162,
			    0,  155,  153,  154,  156,  157,    0,  158,  159,  139,
			  140,  141,  142,  143,  144,  145,  146,  147,  148,  149,
			  150,  151,  152,  136,  133,  109,  133,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  133,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  133,  133,  110,  108,
			    0,    0,  108,  106,  108,    0,  105,  105,    0,  103,
			   38,   39,   41,  103,  103,  103,  103,  103,  103,  103,

			  103,  103,  103,   52,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,   72,  103,   74,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,   95,  161,    0,  127,  125,  126,  128,
			  129,  134,  130,  131,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  108,    0,
			  108,  108,    0,    0,  108,  105,  105,    0,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,   50,  103,
			  103,  103,  103,  103,  103,   59,  103,  103,  103,  103,

			  103,  103,  103,  103,   69,  103,   71,  100,  103,   75,
			  103,  103,  103,  102,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,   88,   89,  103,  103,  103,  103,   94,
			  160,    0,  134,  108,    0,  108,    0,  108,  108,  107,
			   37,  103,  103,   42,   43,  103,  103,   47,  103,  103,
			  103,  103,  103,  103,  103,   57,  103,  103,  103,  103,
			   64,  103,  103,  103,  103,   70,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,   84,  103,  103,   87,  103,
			  103,   92,  103,    0,  132,    0,  108,  108,    0,    0,
			  108,  103,  103,   44,  103,  103,  103,   98,   51,   53,

			  103,   55,  103,  103,   60,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,   78,  103,   80,  103,   82,   83,
			   85,  103,  103,   91,  103,    0,  108,  108,    0,  108,
			    0,  108,    0,   96,  103,  103,   46,  103,  103,  103,
			   58,   62,  103,   65,   66,   99,  103,  103,  101,  103,
			  103,   81,  103,  103,   93,  108,    0,  108,  108,    0,
			  108,  103,   45,   48,   54,   56,   63,  103,   73,  103,
			   79,   86,   90,  108,   97,   67,   77,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1003
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 477
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 478
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

	yyNb_rules: INTEGER is 166
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 167
			-- End of buffer rule code

	INITIAL: INTEGER is 0
	IN_STR: INTEGER is 1
			-- Start condition codes

feature -- User-defined features



end -- class EIFFEL_SCANNER


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
