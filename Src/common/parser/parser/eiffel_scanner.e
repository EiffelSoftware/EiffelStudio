indexing

	description: "Scanners for Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_SCANNER

inherit

	EIFFEL_SCANNER_SKELETON
	STRING_HANDLER

creation

	make


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= VERBATIM_STR3)
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
			yy_acclist ?= yy_acclist_template
		end

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line 40
current_position.go_to (text_count)
when 2 then
--|#line 45
current_position.go_to (text_count)
when 3 then
--|#line 46

				line_number := line_number + text_count
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 4 then
--|#line 55

				current_position.go_to (1)
				last_token := TE_SEMICOLON
			
when 5 then
--|#line 59

				current_position.go_to (1)
				last_token := TE_COLON
			
when 6 then
--|#line 63

				current_position.go_to (1)
				last_token := TE_COMMA
			
when 7 then
--|#line 67

				current_position.go_to (2)
				last_token := TE_DOTDOT
			
when 8 then
--|#line 71

				current_position.go_to (1)
				last_token := TE_QUESTION
			
when 9 then
--|#line 75

				current_position.go_to (1)
				last_token := TE_TILDE
			
when 10 then
--|#line 79

				current_position.go_to (2)
				last_token := TE_CURLYTILDE
			
when 11 then
--|#line 83

				current_position.go_to (1)
				last_token := TE_DOT
			
when 12 then
--|#line 87

				current_position.go_to (1)
				last_token := TE_ADDRESS
			
when 13 then
--|#line 91

				current_position.go_to (2)
				last_token := TE_ASSIGN
			
when 14 then
--|#line 95

				current_position.go_to (2)
				last_token := TE_ACCEPT
			
when 15 then
--|#line 99

				current_position.go_to (1)
				last_token := TE_EQ
			
when 16 then
--|#line 103

				current_position.go_to (1)
				last_token := TE_LT
			
when 17 then
--|#line 107

				current_position.go_to (1)
				last_token := TE_GT
			
when 18 then
--|#line 111

				current_position.go_to (2)
				last_token := TE_LE
			
when 19 then
--|#line 115

				current_position.go_to (2)
				last_token := TE_GE
			
when 20 then
--|#line 119

				current_position.go_to (2)
				last_token := TE_NE
			
when 21 then
--|#line 123

				current_position.go_to (1)
				last_token := TE_LPARAN
			
when 22 then
--|#line 127

				current_position.go_to (1)
				last_token := TE_RPARAN
			
when 23 then
--|#line 131

				current_position.go_to (1)
				last_token := TE_LCURLY
			
when 24 then
--|#line 135

				current_position.go_to (1)
				last_token := TE_RCURLY
			
when 25 then
--|#line 139

				current_position.go_to (1)
				last_token := TE_LSQURE
			
when 26 then
--|#line 143

				current_position.go_to (1)
				last_token := TE_RSQURE
			
when 27 then
--|#line 147

				current_position.go_to (1)
				last_token := TE_PLUS
			
when 28 then
--|#line 151

				current_position.go_to (1)
				last_token := TE_MINUS
			
when 29 then
--|#line 155

				current_position.go_to (1)
				last_token := TE_STAR
			
when 30 then
--|#line 159

				current_position.go_to (1)
				last_token := TE_SLASH
			
when 31 then
--|#line 163

				current_position.go_to (1)
				last_token := TE_POWER
			
when 32 then
--|#line 167

				current_position.go_to (2)
				last_token := TE_CONSTRAIN
			
when 33 then
--|#line 171

				current_position.go_to (1)
				last_token := TE_BANG
			
when 34 then
--|#line 175

				current_position.go_to (2)
				last_token := TE_LARRAY
			
when 35 then
--|#line 179

				current_position.go_to (2)
				last_token := TE_RARRAY
			
when 36 then
--|#line 183

				current_position.go_to (2)
				last_token := TE_DIV
			
when 37 then
--|#line 187

				current_position.go_to (2)
				last_token := TE_MOD
			
when 38 then
--|#line 195


					-- Note: Free operators are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := TE_FREE
			
when 39 then
--|#line 208

				current_position.go_to (5)
				last_token := TE_AGENT
			
when 40 then
--|#line 212

				current_position.go_to (5)
				last_token := TE_ALIAS
			
when 41 then
--|#line 216

				current_position.go_to (3)
				last_token := TE_ALL
			
when 42 then
--|#line 220

				current_position.go_to (3)
				last_token := TE_AND
			
when 43 then
--|#line 224

				current_position.go_to (2)
				last_token := TE_AS
			
when 44 then
--|#line 228

				current_position.go_to (3)
				last_token := TE_BIT
			
when 45 then
--|#line 232

				current_position.go_to (5)
				last_token := TE_CHECK
			
when 46 then
--|#line 236

				current_position.go_to (5)
				last_token := TE_CLASS
			
when 47 then
--|#line 240

				current_position.go_to (6)
				last_token := TE_CREATE
			
when 48 then
--|#line 244

				current_position.go_to (8)
				last_token := TE_CREATION
			
when 49 then
--|#line 248

				current_position.go_to (7)
				last_token := TE_CURRENT
			
when 50 then
--|#line 252

				current_position.go_to (5)
				last_token := TE_DEBUG
			
when 51 then
--|#line 256

				current_position.go_to (8)
				last_token := TE_DEFERRED
			
when 52 then
--|#line 260

				current_position.go_to (2)
				last_token := TE_DO
			
when 53 then
--|#line 264

				current_position.go_to (4)
				last_token := TE_ELSE
			
when 54 then
--|#line 268

				current_position.go_to (6)
				last_token := TE_ELSEIF
			
when 55 then
--|#line 272

				current_position.go_to (3)
				last_token := TE_END
			
when 56 then
--|#line 276

				current_position.go_to (6)
				last_token := TE_ENSURE
			
when 57 then
--|#line 280

				current_position.go_to (8)
				last_token := TE_EXPANDED
			
when 58 then
--|#line 284

				current_position.go_to (6)
				last_token := TE_EXPORT
			
when 59 then
--|#line 288

				current_position.go_to (8)
				last_token := TE_EXTERNAL
			
when 60 then
--|#line 292

				current_position.go_to (5)
				last_token := TE_FALSE
			
when 61 then
--|#line 296

				current_position.go_to (7)
				last_token := TE_FEATURE
			
when 62 then
--|#line 300

				current_position.go_to (4)
				last_token := TE_FROM
			
when 63 then
--|#line 304

				current_position.go_to (6)
				last_token := TE_FROZEN
			
when 64 then
--|#line 308

				current_position.go_to (2)
				last_token := TE_IF
			
when 65 then
--|#line 312

				current_position.go_to (7)
				last_token := TE_IMPLIES
			
when 66 then
--|#line 316

				current_position.go_to (8)
				last_token := TE_INDEXING
			
when 67 then
--|#line 320

				current_position.go_to (5)
				last_token := TE_INFIX
			
when 68 then
--|#line 324

				current_position.go_to (7)
				last_token := TE_INHERIT
			
when 69 then
--|#line 328

				current_position.go_to (7)
				last_token := TE_INSPECT
			
when 70 then
--|#line 332

				current_position.go_to (9)
				last_token := TE_INVARIANT
			
when 71 then
--|#line 336

				current_position.go_to (2)
				last_token := TE_IS
			
when 72 then
--|#line 340

				current_position.go_to (4)
				last_token := TE_LIKE
			
when 73 then
--|#line 344

				current_position.go_to (5)
				last_token := TE_LOCAL
			
when 74 then
--|#line 348

				current_position.go_to (4)
				last_token := TE_LOOP
			
when 75 then
--|#line 352

				current_position.go_to (3)
				last_token := TE_NOT
			
when 76 then
--|#line 356

				current_position.go_to (8)
				last_token := TE_OBSOLETE
			
when 77 then
--|#line 360

				current_position.go_to (3)
				last_token := TE_OLD
			
when 78 then
--|#line 364

				current_position.go_to (4)
				last_token := TE_ONCE
			
when 79 then
--|#line 368

				current_position.go_to (2)
				last_token := TE_OR
			
when 80 then
--|#line 372

				current_position.go_to (9)
				last_token := TE_PRECURSOR
			
when 81 then
--|#line 376

				current_position.go_to (6)
				last_token := TE_PREFIX
			
when 82 then
--|#line 380

				current_position.go_to (8)
				last_token := TE_REDEFINE
			
when 83 then
--|#line 384

				current_position.go_to (6)
				last_token := TE_RENAME
			
when 84 then
--|#line 388

				current_position.go_to (7)
				last_token := TE_REQUIRE
			
when 85 then
--|#line 392

				current_position.go_to (6)
				last_token := TE_RESCUE
			
when 86 then
--|#line 396

				current_position.go_to (6)
				last_token := TE_RESULT
			
when 87 then
--|#line 400

				current_position.go_to (5)
				last_token := TE_RETRY
			
when 88 then
--|#line 404

				current_position.go_to (6)
				last_token := TE_SELECT
			
when 89 then
--|#line 408

				current_position.go_to (8)
				last_token := TE_SEPARATE
			
when 90 then
--|#line 412

				current_position.go_to (5)
				last_token := TE_STRIP
			
when 91 then
--|#line 416

				current_position.go_to (4)
				last_token := TE_THEN
			
when 92 then
--|#line 420

				current_position.go_to (4)
				last_token := TE_TRUE
			
when 93 then
--|#line 424

				current_position.go_to (8)
				last_token := TE_UNDEFINE
			
when 94 then
--|#line 428

				current_position.go_to (6)
				last_token := TE_UNIQUE
			
when 95 then
--|#line 432

				current_position.go_to (5)
				last_token := TE_UNTIL
			
when 96 then
--|#line 436

				current_position.go_to (7)
				last_token := TE_VARIANT
			
when 97 then
--|#line 440

				current_position.go_to (4)
				last_token := TE_WHEN
			
when 98 then
--|#line 444

				current_position.go_to (3)
				last_token := TE_XOR
			
when 99 then
--|#line 452

				current_position.go_to (7)
				last_token := TE_BOOLEAN_ID
			
when 100 then
--|#line 456

				current_position.go_to (9)
				last_token := TE_CHARACTER_ID
			
when 101 then
--|#line 460

				current_position.go_to (6)
				last_token := TE_DOUBLE_ID
			
when 102 then
--|#line 464

				current_position.go_to (9)
				last_token := TE_INTEGER_8_ID
			
when 103 then
--|#line 468

				current_position.go_to (10)
				last_token := TE_INTEGER_16_ID
			
when 104 then
--|#line 472

				current_position.go_to (7)
				last_token := TE_INTEGER_ID
			
when 105 then
--|#line 476

				current_position.go_to (10)
				last_token := TE_INTEGER_64_ID
			
when 106 then
--|#line 480

				current_position.go_to (4)
				last_token := TE_NONE_ID
			
when 107 then
--|#line 484

				current_position.go_to (7)
				last_token := TE_POINTER_ID
			
when 108 then
--|#line 488

				current_position.go_to (4)
				last_token := TE_REAL_ID
			
when 109 then
--|#line 492

				current_position.go_to (14)
				last_token := TE_WIDE_CHAR_ID
			
when 110 then
--|#line 496

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 111 then
--|#line 508

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				current_position.go_to (token_buffer.count + 1)
				last_token := TE_A_BIT
			
when 112 then
--|#line 518
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_INTEGER
			
when 113 then
	yy_position := yy_position - 2
--|#line 519
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_INTEGER
			
when 114 then
--|#line 532

				token_buffer.clear_all
				append_without_underscores (text, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 115 then
--|#line 539
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 116 then
--|#line 548

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (text_count)
				last_token := TE_REAL
			
when 117 then
--|#line 559

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 118 then
--|#line 565

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 119 then
--|#line 572

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 120 then
--|#line 578

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 121 then
--|#line 584

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 122 then
--|#line 590

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 123 then
--|#line 596

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 124 then
--|#line 602

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 125 then
--|#line 608

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 126 then
--|#line 614

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 127 then
--|#line 620

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 128 then
--|#line 626

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 129 then
--|#line 632

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 130 then
--|#line 638

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 131 then
--|#line 644

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 132 then
--|#line 650

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 133 then
--|#line 656

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 134 then
--|#line 662

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 135 then
--|#line 668

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 136 then
--|#line 674

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 137 then
--|#line 680

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 138 then
--|#line 686

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 139 then
--|#line 692

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 140 then
--|#line 698

				current_position.go_to (text_count)
				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 141, 142 then
--|#line 702

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				current_position.go_to (text_count)
				report_character_missing_quote_error (text)
			
when 143 then
--|#line 713

				current_position.go_to (3)
				last_token := TE_STR_LT
			
when 144 then
--|#line 717

				current_position.go_to (3)
				last_token := TE_STR_GT
			
when 145 then
--|#line 721

				current_position.go_to (4)
				last_token := TE_STR_LE
			
when 146 then
--|#line 725

				current_position.go_to (4)
				last_token := TE_STR_GE
			
when 147 then
--|#line 729

				current_position.go_to (3)
				last_token := TE_STR_PLUS
			
when 148 then
--|#line 733

				current_position.go_to (3)
				last_token := TE_STR_MINUS
			
when 149 then
--|#line 737

				current_position.go_to (3)
				last_token := TE_STR_STAR
			
when 150 then
--|#line 741

				current_position.go_to (3)
				last_token := TE_STR_SLASH
			
when 151 then
--|#line 745

				current_position.go_to (3)
				last_token := TE_STR_POWER
			
when 152 then
--|#line 749

				current_position.go_to (4)
				last_token := TE_STR_DIV
			
when 153 then
--|#line 753

				current_position.go_to (4)
				last_token := TE_STR_MOD
			
when 154 then
--|#line 757

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_AND
			
when 155 then
--|#line 763

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				current_position.go_to (10)
				last_token := TE_STR_AND_THEN
			
when 156 then
--|#line 769

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_IMPLIES
			
when 157 then
--|#line 775

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_NOT
			
when 158 then
--|#line 781

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				current_position.go_to (4)
				last_token := TE_STR_OR
			
when 159 then
--|#line 787

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_OR_ELSE
			
when 160 then
--|#line 793

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_XOR
			
when 161 then
--|#line 799

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STR_FREE
			
when 162 then
--|#line 805

					-- Empty string.
				current_position.go_to (2)
				last_token := TE_EMPTY_STRING
			
when 163 then
--|#line 810

					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STRING
			
when 164 then
--|#line 817

					-- Verbatim string.
				token_buffer.clear_all
				verbatim_marker.clear_all
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				current_position.go_to (text_count)
				set_start_condition (VERBATIM_STR3)
			
when 165 then
--|#line 828

				line_number := line_number + 1
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				set_start_condition (VERBATIM_STR1)
			
when 166 then
--|#line 834

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 167 then
--|#line 850

				if is_verbatim_string_closer then
					current_position.go_to (text_count)
					set_start_condition (INITIAL)
						-- Remove the trailing new-line.
					if token_buffer.count >= 2 then
						check new_line: token_buffer.item (token_buffer.count) = '%N' end
						if token_buffer.item (token_buffer.count - 1) = '%R' then
								-- Under Windows a we have \r\n.
								-- Remove both characters.
							token_buffer.set_count (token_buffer.count - 2)
						else
							token_buffer.set_count (token_buffer.count - 1)
						end
					elseif token_buffer.count = 1 then
						check new_line: token_buffer.item (1) = '%N' end
						token_buffer.clear_all
					end
					if token_buffer.is_empty then
							-- Empty string.
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_token := TE_VERBATIM_STRING
					end
				else
					current_position.go_to (text_count)
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			
when 168 then
--|#line 880

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 169 then
--|#line 885

				line_number := line_number + 1
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
			
when 170 then
--|#line 891

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 171 then
--|#line 907

				line_number := line_number + 1
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR1)
			
when 172 then
--|#line 914

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 173 then
--|#line 927

					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (SPECIAL_STR)
			
when 174 then
--|#line 937

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			
when 175 then
--|#line 941

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 176 then
--|#line 945

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 177 then
--|#line 949

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 178 then
--|#line 953

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 179 then
--|#line 957

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 180 then
--|#line 961

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 181 then
--|#line 965

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 182 then
--|#line 969

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 183 then
--|#line 973

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 184 then
--|#line 977

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 185 then
--|#line 981

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 186 then
--|#line 985

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 187 then
--|#line 989

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 188 then
--|#line 993

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 189 then
--|#line 997

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 190 then
--|#line 1001

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 191 then
--|#line 1005

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 192 then
--|#line 1009

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 193 then
--|#line 1013

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 194 then
--|#line 1017

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 195 then
--|#line 1021

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 196 then
--|#line 1025

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 197 then
--|#line 1029

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 198 then
--|#line 1036

				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
						-- Empty string.
					last_token := TE_EMPTY_STRING
				else
					last_token := TE_STRING
				end
			
when 199 then
--|#line 1049

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 200 then
--|#line 1055

					-- No final double-quote.
				line_number := line_number + 1
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 201 then
--|#line 1081

				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			
when 202 then
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
				report_string_missing_quote_error (token_buffer)
			
when 2 then
--|#line 0

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 3 then
--|#line 0

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 4 then
--|#line 0

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
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
			    0,   12,   13,   14,   13,   15,   16,   17,   18,   12,
			   17,   19,   20,   21,   22,   23,   24,   25,   26,   27,
			   28,   29,   30,   30,   30,   30,   31,   32,   33,   34,
			   35,   36,   17,   37,   38,   39,   40,   41,   42,   43,
			   43,   44,   43,   43,   45,   43,   46,   47,   48,   43,
			   49,   50,   51,   52,   53,   54,   55,   43,   43,   56,
			   57,   58,   59,   12,   12,   37,   38,   39,   40,   41,
			   42,   43,   43,   44,   43,   43,   45,   43,   46,   47,
			   48,   43,   49,   50,   51,   52,   53,   54,   55,   43,
			   43,   60,   17,   61,   62,   64,   64,  188,   65,   65,

			  189,   66,   66,   68,   69,   68,  143,   70,   68,   69,
			   68,  100,   70,   75,   76,   75,   75,   76,   75,   77,
			   98,   77,   99,  102,  101,  103,  103,  103,  103,  103,
			  103,  104,  113,  114,  115,  116,  590,  589,  143,  150,
			  106,  105,  107,  107,  108,  108,  108,  108,  106,  567,
			  107,  107,  108,  108,  108,  108,  109,  155,   77,  123,
			   77,  407,   71,  472,  109,  124,  156,   71,   80,   81,
			  159,  150,   81,  129,  153,  119,   82,   83,  110,   84,
			  120,   85,  121,  130,  154,  111,  197,  122,  109,  155,
			   86,  123,   87,  111,   81,   88,  109,  124,  156,  195,

			  196,  195,  159,   89,  252,  129,  153,  119,   90,   91,
			  110,  131,  120,  132,  121,  130,  154,  188,   92,  122,
			  189,   93,   94,  133,   95,  467,  106,   88,  108,  108,
			  108,  108,  108,  108,  125,   89,  252,  255,  126,   93,
			   90,   91,  134,  131,  127,  132,  135,  128,  200,  137,
			   92,  144,  141,  201,   81,  133,  138,  139,  142,  136,
			  151,  145,  140,  146,  256,  148,  125,  147,  149,  255,
			  126,  111,  157,  158,  134,  152,  127,  342,  135,  128,
			  202,  137,  341,  144,  141,  203,  340,  339,  138,  139,
			  142,  136,  151,  145,  140,  146,  256,  148,  204,  147,

			  149,   93,  338,  337,  157,  158,   93,  152,  164,  164,
			  164,  197,  165,  217,  205,  166,  336,  167,  168,  169,
			  190,  188,  190,  188,  189,  170,  192,   79,   79,  187,
			   79,  207,  198,   93,  171,  197,  172,  206,   93,  173,
			  174,  175,  176,  197,  177,  197,  178,  311,  197,  197,
			  179,  209,  180,  335,  208,  181,  182,  183,  184,  185,
			  186,  195,  196,  195,   93,  257,   93,   93,  214,  215,
			  214,  312,  197,  253,  210,  260,  254,  261,  478,  191,
			  334,  313,  333,  209,   93,  199,  211,  212,   93,  213,
			  251,  251,  251,  251,  251,  251,   93,  257,   93,  332,

			   93,   93,   93,  216,  262,  253,  210,  260,  254,  261,
			  243,  243,  243,  243,  243,  243,  331,  265,  211,  212,
			  266,  213,  330,  111,   93,   93,  220,  244,  329,  221,
			  271,  222,  223,  224,   93,  272,  262,  328,  245,  225,
			  246,  246,  246,  246,  246,  246,  327,  325,  226,  265,
			  227,  324,  266,  228,  229,  230,  231,  247,  232,  244,
			  233,  323,  271,  322,  234,  321,  235,  272,  194,  236,
			  237,  238,  239,  240,  241,  106,  273,  248,  248,  249,
			  249,  249,  249,  258,  267,  274,  281,  259,  163,  247,
			  106,  109,  249,  249,  249,  249,  249,  249,  263,  268,

			  269,  284,  264,  242,  270,  286,  287,  285,  273,  275,
			  282,  276,  288,  277,  289,  258,  267,  274,  281,  259,
			  111,  290,  283,  109,  278,  279,  299,  280,  219,  300,
			  263,  268,  269,  284,  264,  111,  270,  286,  287,  285,
			  301,  275,  282,  276,  288,  277,  289,  291,  297,  305,
			  292,  306,  298,  290,  283,  307,  278,  279,  299,  280,
			  293,  300,  302,  294,  308,  295,  296,  303,  164,  164,
			  164,  188,  301,  197,  192,  309,  197,  187,  304,  291,
			  297,  305,  292,  306,  298,  197,  317,  307,  318,  190,
			  188,  190,  293,  189,  302,  294,  308,  295,  296,  303,

			  310,  310,  310,  310,  310,  310,   79,  214,  215,  214,
			  304,  198,  197,  320,  353,  314,   78,  354,  315,  316,
			  214,  215,  214,  355,  197,  194,   93,  163,  161,   93,
			  326,  326,  326,  326,  326,  326,  412,  160,   93,  582,
			  117,   93,  583,  584,  356,  112,  353,  314,  191,  354,
			  315,  316,   78,  596,  357,  355,  319,  343,  343,  343,
			  343,  343,  343,   73,  199,   93,   93,  346,  346,  346,
			  346,  346,  346,  344,  244,  344,  356,   93,  345,  345,
			  345,  345,  345,  345,  347,  348,  357,  348,  319,   93,
			  349,  349,  349,  349,  349,  349,  106,  358,  350,  350,

			  351,  351,  351,  351,  359,  360,  244,  361,  362,   73,
			  363,  364,  109,  365,  596,  106,  347,  351,  351,  351,
			  351,  351,  351,  352,  352,  352,  352,  352,  352,  358,
			  368,  369,  366,  370,  371,  373,  359,  360,  374,  361,
			  362,  111,  363,  364,  109,  365,  367,  372,  375,  376,
			  377,  378,  379,  380,  381,  382,  383,  384,  385,  386,
			  111,  389,  368,  369,  366,  370,  371,  373,  387,  390,
			  374,  388,  391,  392,  393,  395,  396,  397,  367,  372,
			  375,  376,  377,  378,  379,  380,  381,  382,  383,  384,
			  385,  386,  394,  389,  398,  399,  400,  401,  402,  403,

			  387,  390,  404,  388,  391,  392,  393,  395,  396,  397,
			  405,  406,  407,  408,  408,  408,  408,  408,  408,  409,
			  197,  410,  197,  414,  394,  423,  398,  399,  400,  401,
			  402,  403,  596,  596,  404,  415,  326,  326,  326,  326,
			  326,  326,  405,  406,  416,  416,  416,  416,  416,  416,
			  596,  424,  425,  413,  426,  596,  427,  423,  411,  428,
			  429,  244,  345,  345,  345,  345,  345,  345,  596,  430,
			  596,  431,  432,   93,   93,   93,   93,  345,  345,  345,
			  345,  345,  345,  424,  425,  413,  426,  417,  427,  596,
			  411,  428,  429,  244,  418,  418,  418,  418,  418,  418,

			  419,  430,  419,  431,  432,  420,  420,  420,  420,  420,
			  420,  347,  349,  349,  349,  349,  349,  349,  349,  349,
			  349,  349,  349,  349,  421,  433,  350,  350,  351,  351,
			  351,  351,  421,  434,  351,  351,  351,  351,  351,  351,
			  109,  435,  436,  347,  422,  422,  422,  422,  422,  422,
			  437,  438,  439,  440,  441,  442,  443,  433,  444,  445,
			  446,  447,  448,  449,  450,  434,  451,  452,  453,  454,
			  455,  456,  109,  435,  436,  457,  458,  459,  460,  461,
			  462,  463,  437,  438,  439,  440,  441,  442,  443,  464,
			  444,  445,  446,  447,  448,  449,  450,  465,  451,  452,

			  453,  454,  455,  456,  466,  197,  197,  457,  458,  459,
			  460,  461,  462,  463,  407,  468,  468,  468,  468,  468,
			  468,  464,  197,  416,  416,  416,  416,  416,  416,  465,
			  474,  474,  474,  474,  474,  474,  466,  479,  480,  483,
			  473,  470,  596,  596,  475,  475,  475,  475,  475,  475,
			  484,  469,  420,  420,  420,  420,  420,  420,   93,   93,
			  471,  347,  420,  420,  420,  420,  420,  420,  596,  479,
			  480,  483,  473,  470,  481,   93,  485,  486,  482,  487,
			  488,  596,  484,  469,  489,  490,  491,  476,  492,  493,
			  494,  495,  471,  347,  245,  496,  475,  475,  475,  475,

			  475,  475,  497,  498,  499,  500,  481,  501,  485,  486,
			  482,  487,  488,  477,  502,  503,  489,  490,  491,  504,
			  492,  493,  494,  495,  505,  506,  507,  496,  508,  509,
			  510,  511,  512,  513,  497,  498,  499,  500,  197,  501,
			  197,  197,  250,  250,  250,  477,  502,  503,  596,  596,
			  596,  504,  596,  526,  596,  527,  505,  506,  507,  596,
			  508,  509,  510,  511,  512,  513,  596,  596,  517,  596,
			  517,  515,  514,  518,  518,  518,  518,  518,  518,  519,
			  519,  519,  519,  519,  519,  526,  516,  527,  596,  596,
			  596,   93,  596,   93,   93,  528,  520,  475,  475,  475,

			  475,  475,  475,  515,  514,  522,  522,  522,  522,  522,
			  522,  529,  530,  531,  521,  523,  532,  523,  516,  533,
			  524,  524,  524,  524,  524,  524,  534,  528,  520,  535,
			  522,  522,  522,  522,  522,  522,  536,  537,  538,  539,
			  540,  541,  542,  529,  530,  531,  521,  525,  532,  543,
			  544,  533,  545,  546,  547,  548,  197,  197,  534,  197,
			  596,  535,  518,  518,  518,  518,  518,  518,  536,  537,
			  538,  539,  540,  541,  542,  596,  561,  596,  596,  525,
			  596,  543,  544,  576,  545,  546,  547,  548,  549,  596,
			  551,  518,  518,  518,  518,  518,  518,  596,  596,  596,

			  596,  550,  552,  552,  552,  552,  552,  552,  561,   93,
			   93,  596,   93,  524,  524,  524,  524,  524,  524,  520,
			  549,  553,  551,  553,  596,  577,  554,  554,  554,  554,
			  554,  554,  555,  550,  555,  596,   93,  556,  556,  556,
			  556,  556,  556,  557,  557,  557,  557,  557,  557,  562,
			  563,  520,  524,  524,  524,  524,  524,  524,  564,  559,
			  558,  559,  565,  566,  560,  560,  560,  560,  560,  560,
			  568,  569,  570,  571,  572,  573,  574,  197,   93,  581,
			  585,  562,  563,  520,  554,  554,  554,  554,  554,  554,
			  564,  596,  558,  596,  565,  566,  554,  554,  554,  554,

			  554,  554,  568,  569,  570,  571,  572,  573,  574,  417,
			  588,  581,  585,  596,  596,  520,  596,  575,  556,  556,
			  556,  556,  556,  556,  556,  556,  556,  556,  556,  556,
			   93,  578,  578,  578,  578,  578,  578,  579,  586,  579,
			  587,  558,  580,  580,  580,  580,  580,  580,  558,  575,
			  560,  560,  560,  560,  560,  560,  560,  560,  560,  560,
			  560,  560,  591,   93,  592,  593,  594,  476,  595,  596,
			  586,  596,  587,  558,  580,  580,  580,  580,  580,  580,
			  558,  580,  580,  580,  580,  580,  580,  596,  596,  596,
			  596,  596,  596,  596,  591,  596,  592,  593,  594,  596,

			  595,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   79,  596,   79,  596,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   96,  596,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   97,  596,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  162,

			  596,  162,  596,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  187,  187,  187,  187,  187,  187,  187,  187,
			  187,  187,  187,  187,  187,  191,  191,  191,  191,  191,
			  191,  191,  191,  191,  191,  191,  191,  191,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,   81,  596,   81,  596,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,  218,  596,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  218,  100,  596,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			   11,  596,  596,  596,  596,  596,  596,  596,  596,  596,

			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596>>)
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
			    1,    1,    1,    1,    1,    3,    4,   67,    3,    4,

			   67,    3,    4,    5,    5,    5,   46,    5,    6,    6,
			    6,   25,    6,    9,    9,    9,   10,   10,   10,   13,
			   19,   13,   19,   26,   25,   26,   26,   26,   26,   26,
			   26,   27,   33,   33,   35,   35,  583,  582,   46,   49,
			   28,   27,   28,   28,   28,   28,   28,   28,   29,  538,
			   29,   29,   29,   29,   29,   29,   28,   52,   77,   38,
			   77,  468,    5,  415,   29,   38,   53,    6,   16,   16,
			   55,   49,   16,   40,   51,   37,   16,   16,   28,   16,
			   37,   16,   37,   40,   51,   28,   79,   37,   28,   52,
			   16,   38,   16,   29,   16,   16,   29,   38,   53,   75,

			   75,   75,   55,   16,  119,   40,   51,   37,   16,   16,
			   28,   41,   37,   41,   37,   40,   51,  187,   16,   37,
			  187,   16,   16,   41,   16,  406,   30,   16,   30,   30,
			   30,   30,   30,   30,   39,   16,  119,  121,   39,   79,
			   16,   16,   42,   41,   39,   41,   42,   39,   82,   44,
			   16,   47,   45,   83,   16,   41,   44,   44,   45,   42,
			   50,   47,   44,   47,  123,   48,   39,   47,   48,  121,
			   39,   30,   54,   54,   42,   50,   39,  241,   42,   39,
			   84,   44,  240,   47,   45,   85,  239,  238,   44,   44,
			   45,   42,   50,   47,   44,   47,  123,   48,   85,   47,

			   48,   82,  237,  236,   54,   54,   83,   50,   66,   66,
			   66,   88,   66,   95,   86,   66,  235,   66,   66,   66,
			   68,   68,   68,   71,   68,   66,   71,   81,   81,   71,
			   81,   87,   81,   84,   66,   89,   66,   86,   85,   66,
			   66,   66,   66,   91,   66,   90,   66,  204,   92,   94,
			   66,   88,   66,  234,   87,   66,   66,   66,   66,   66,
			   66,  195,  195,  195,   88,  124,   95,   86,   93,   93,
			   93,  206,   93,  120,   89,  126,  120,  127,  422,   68,
			  233,  208,  232,   88,   87,   81,   90,   91,   89,   92,
			  111,  111,  111,  111,  111,  111,   91,  124,   90,  231,

			  204,   92,   94,   94,  128,  120,   89,  126,  120,  127,
			  103,  103,  103,  103,  103,  103,  230,  130,   90,   91,
			  131,   92,  229,  422,  206,   93,   98,  103,  228,   98,
			  134,   98,   98,   98,  208,  135,  128,  227,  106,   98,
			  106,  106,  106,  106,  106,  106,  226,  224,   98,  130,
			   98,  223,  131,   98,   98,   98,   98,  106,   98,  103,
			   98,  222,  134,  221,   98,  220,   98,  135,  193,   98,
			   98,   98,   98,   98,   98,  107,  136,  107,  107,  107,
			  107,  107,  107,  125,  132,  138,  141,  125,  162,  106,
			  108,  107,  108,  108,  108,  108,  108,  108,  129,  132,

			  133,  143,  129,   99,  133,  144,  145,  143,  136,  139,
			  142,  139,  146,  139,  148,  125,  132,  138,  141,  125,
			  107,  149,  142,  107,  139,  139,  152,  139,   97,  153,
			  129,  132,  133,  143,  129,  108,  133,  144,  145,  143,
			  154,  139,  142,  139,  146,  139,  148,  150,  151,  156,
			  150,  157,  151,  149,  142,  158,  139,  139,  152,  139,
			  150,  153,  155,  150,  159,  150,  150,  155,  164,  164,
			  164,  191,  154,  211,  191,  164,  210,  191,  155,  150,
			  151,  156,  150,  157,  151,  209,  212,  158,  212,  190,
			  190,  190,  150,  190,  155,  150,  159,  150,  150,  155,

			  170,  170,  170,  170,  170,  170,  199,  199,  199,  199,
			  155,  199,  213,  216,  252,  209,   78,  253,  210,  211,
			  214,  214,  214,  257,  214,   72,  211,   63,   61,  210,
			  225,  225,  225,  225,  225,  225,  316,   57,  209,  567,
			   36,  212,  567,  567,  258,   31,  252,  209,  190,  253,
			  210,  211,   14,   11,  259,  257,  213,  243,  243,  243,
			  243,  243,  243,    8,  199,  213,  216,  246,  246,  246,
			  246,  246,  246,  244,  243,  244,  258,  214,  244,  244,
			  244,  244,  244,  244,  246,  247,  259,  247,  213,  316,
			  247,  247,  247,  247,  247,  247,  248,  260,  248,  248,

			  248,  248,  248,  248,  261,  262,  243,  263,  264,    7,
			  265,  266,  248,  268,    0,  249,  246,  249,  249,  249,
			  249,  249,  249,  251,  251,  251,  251,  251,  251,  260,
			  270,  271,  269,  272,  273,  274,  261,  262,  275,  263,
			  264,  248,  265,  266,  248,  268,  269,  273,  276,  277,
			  278,  279,  280,  281,  282,  283,  284,  286,  288,  289,
			  249,  291,  270,  271,  269,  272,  273,  274,  290,  292,
			  275,  290,  293,  294,  295,  296,  297,  298,  269,  273,
			  276,  277,  278,  279,  280,  281,  282,  283,  284,  286,
			  288,  289,  295,  291,  299,  300,  301,  302,  303,  304,

			  290,  292,  305,  290,  293,  294,  295,  296,  297,  298,
			  306,  307,  310,  310,  310,  310,  310,  310,  310,  314,
			  315,  314,  317,  319,  295,  353,  299,  300,  301,  302,
			  303,  304,    0,    0,  305,  326,  326,  326,  326,  326,
			  326,  326,  306,  307,  343,  343,  343,  343,  343,  343,
			    0,  354,  355,  317,  356,    0,  357,  353,  315,  358,
			  359,  343,  344,  344,  344,  344,  344,  344,    0,  360,
			    0,  361,  362,  315,  314,  317,  319,  345,  345,  345,
			  345,  345,  345,  354,  355,  317,  356,  343,  357,    0,
			  315,  358,  359,  343,  346,  346,  346,  346,  346,  346,

			  347,  360,  347,  361,  362,  347,  347,  347,  347,  347,
			  347,  346,  348,  348,  348,  348,  348,  348,  349,  349,
			  349,  349,  349,  349,  350,  363,  350,  350,  350,  350,
			  350,  350,  351,  364,  351,  351,  351,  351,  351,  351,
			  350,  365,  366,  346,  352,  352,  352,  352,  352,  352,
			  367,  368,  369,  370,  372,  373,  374,  363,  375,  376,
			  377,  378,  379,  381,  384,  364,  386,  387,  388,  390,
			  391,  392,  350,  365,  366,  393,  394,  395,  396,  397,
			  398,  401,  367,  368,  369,  370,  372,  373,  374,  402,
			  375,  376,  377,  378,  379,  381,  384,  403,  386,  387,

			  388,  390,  391,  392,  404,  409,  411,  393,  394,  395,
			  396,  397,  398,  401,  408,  408,  408,  408,  408,  408,
			  408,  402,  413,  416,  416,  416,  416,  416,  416,  403,
			  417,  417,  417,  417,  417,  417,  404,  425,  426,  430,
			  416,  411,    0,    0,  418,  418,  418,  418,  418,  418,
			  432,  409,  419,  419,  419,  419,  419,  419,  409,  411,
			  413,  418,  420,  420,  420,  420,  420,  420,    0,  425,
			  426,  430,  416,  411,  429,  413,  433,  434,  429,  435,
			  436,    0,  432,  409,  437,  438,  440,  418,  441,  442,
			  443,  445,  413,  418,  421,  446,  421,  421,  421,  421,

			  421,  421,  447,  448,  450,  451,  429,  452,  433,  434,
			  429,  435,  436,  421,  453,  454,  437,  438,  440,  455,
			  441,  442,  443,  445,  456,  457,  458,  446,  460,  461,
			  463,  464,  466,  467,  447,  448,  450,  451,  469,  452,
			  470,  471,  612,  612,  612,  421,  453,  454,    0,    0,
			    0,  455,    0,  479,    0,  480,  456,  457,  458,    0,
			  460,  461,  463,  464,  466,  467,    0,    0,  473,    0,
			  473,  470,  469,  473,  473,  473,  473,  473,  473,  474,
			  474,  474,  474,  474,  474,  479,  471,  480,    0,    0,
			    0,  469,    0,  470,  471,  482,  474,  475,  475,  475,

			  475,  475,  475,  470,  469,  476,  476,  476,  476,  476,
			  476,  483,  484,  488,  475,  477,  490,  477,  471,  491,
			  477,  477,  477,  477,  477,  477,  493,  482,  474,  494,
			  478,  478,  478,  478,  478,  478,  495,  496,  497,  498,
			  499,  500,  501,  483,  484,  488,  475,  478,  490,  503,
			  505,  491,  509,  510,  512,  513,  515,  514,  493,  516,
			    0,  494,  517,  517,  517,  517,  517,  517,  495,  496,
			  497,  498,  499,  500,  501,    0,  527,    0,    0,  478,
			    0,  503,  505,  550,  509,  510,  512,  513,  514,    0,
			  516,  518,  518,  518,  518,  518,  518,    0,    0,    0,

			    0,  515,  519,  519,  519,  519,  519,  519,  527,  515,
			  514,    0,  516,  523,  523,  523,  523,  523,  523,  519,
			  514,  520,  516,  520,    0,  551,  520,  520,  520,  520,
			  520,  520,  521,  515,  521,    0,  550,  521,  521,  521,
			  521,  521,  521,  522,  522,  522,  522,  522,  522,  528,
			  530,  519,  524,  524,  524,  524,  524,  524,  531,  525,
			  522,  525,  532,  535,  525,  525,  525,  525,  525,  525,
			  539,  540,  542,  543,  545,  546,  548,  549,  551,  561,
			  568,  528,  530,  552,  553,  553,  553,  553,  553,  553,
			  531,    0,  522,    0,  532,  535,  554,  554,  554,  554,

			  554,  554,  539,  540,  542,  543,  545,  546,  548,  552,
			  575,  561,  568,    0,    0,  552,    0,  549,  555,  555,
			  555,  555,  555,  555,  556,  556,  556,  556,  556,  556,
			  549,  557,  557,  557,  557,  557,  557,  558,  570,  558,
			  574,  578,  558,  558,  558,  558,  558,  558,  557,  549,
			  559,  559,  559,  559,  559,  559,  560,  560,  560,  560,
			  560,  560,  587,  575,  591,  592,  593,  578,  594,    0,
			  570,    0,  574,  578,  579,  579,  579,  579,  579,  579,
			  557,  580,  580,  580,  580,  580,  580,    0,    0,    0,
			    0,    0,    0,    0,  587,    0,  591,  592,  593,    0,

			  594,  597,  597,  597,  597,  597,  597,  597,  597,  597,
			  597,  597,  597,  597,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  599,  599,  599,
			  599,  599,  599,  599,  599,  599,  599,  599,  599,  599,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  601,    0,  601,    0,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  602,    0,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  603,    0,  603,
			  603,  603,  603,  603,  603,  603,  603,  603,  603,  603,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  605,

			    0,  605,    0,  605,  605,  605,  605,  605,  605,  605,
			  605,  605,  606,  606,  606,  606,  606,  606,  606,  606,
			  606,  606,  606,  606,  606,  607,  607,  607,  607,  607,
			  607,  607,  607,  607,  607,  607,  607,  607,  608,  608,
			  608,  608,  608,  608,  608,  608,  608,  608,  608,  608,
			  608,  609,    0,  609,    0,  609,  609,  609,  609,  609,
			  609,  609,  609,  609,  610,    0,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  611,    0,  611,
			  611,  611,  611,  611,  611,  611,  611,  611,  611,  611,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,

			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   92,   93,  101,  106,  706,  660,  111,
			  114,  653, 1690,  117,  649, 1690,  162,    0, 1690,  111,
			 1690, 1690, 1690, 1690, 1690,   94,  105,  112,  122,  130,
			  208,  616, 1690,  104, 1690,  105,  611,  136,  118,  194,
			  136,  167,  209,    0,  211,  211,   59,  217,  218,  102,
			  223,  134,  111,  133,  232,  123, 1690,  577, 1690, 1690,
			 1690,  534, 1690,  621, 1690, 1690,  306,   94,  318, 1690,
			 1690,  320,  622, 1690, 1690,  197, 1690,  156,  613,  180,
			 1690,  326,  242,  247,  274,  279,  308,  325,  305,  329,
			  339,  337,  342,  366,  343,  307,    0,  517,  420,  492,

			    0, 1690, 1690,  390, 1690, 1690,  420,  457,  472, 1690,
			    0,  370, 1690, 1690, 1690, 1690, 1690, 1690,    0,  167,
			  332,  201,    0,  212,  318,  450,  342,  340,  354,  464,
			  364,  369,  448,  452,  386,  402,  429,    0,  437,  473,
			    0,  443,  475,  455,  454,  470,  477,    0,  473,  484,
			  514,  504,  476,  492,  487,  526,  499,  514,  519,  514,
			 1690, 1690,  482, 1690,  566, 1690, 1690, 1690, 1690, 1690,
			  580, 1690, 1690, 1690, 1690, 1690, 1690, 1690, 1690, 1690,
			 1690, 1690, 1690, 1690, 1690, 1690, 1690,  214, 1690, 1690,
			  587,  568, 1690,  465, 1690,  359, 1690, 1690, 1690,  605,

			 1690, 1690, 1690, 1690,  341, 1690,  365, 1690,  375,  579,
			  570,  567,  582,  606,  618, 1690,  607, 1690, 1690, 1690,
			  454,  452,  450,  440,  436,  610,  435,  426,  417,  411,
			  405,  388,  371,  369,  342,  305,  292,  291,  276,  275,
			  271,  266, 1690,  637,  658, 1690,  647,  670,  678,  697,
			    0,  703,  568,  584,    0,    0,    0,  579,  594,  619,
			  646,  671,  655,  654,  671,  676,  674,    0,  660,  699,
			  693,  680,  681,  689,  691,  701,  707,  712,  702,  714,
			  719,  716,  721,  707,  719,    0,  710,    0,  721,  713,
			  733,  717,  732,  739,  720,  739,  725,  739,  744,  753,

			  749,  759,  760,  749,  758,  761,  764,  774,    0, 1690,
			  793, 1690, 1690, 1690,  815,  814,  630,  816, 1690,  817,
			 1690, 1690, 1690, 1690, 1690, 1690,  816, 1690, 1690, 1690,
			 1690, 1690, 1690, 1690, 1690, 1690, 1690, 1690, 1690, 1690,
			 1690, 1690, 1690,  824,  842,  857,  874,  885,  892,  898,
			  906,  914,  924,  773,  800,  815,  821,  813,  808,  808,
			  832,  832,  822,  881,  892,  891,  896,  900,  901,  915,
			  900,    0,  917,  914,  900,  902,  909,  923,  922,  912,
			    0,  919,    0,    0,  920,    0,  914,  914,  927,    0,
			  931,  925,  930,  922,  932,  920,  943,  929,  932,    0,

			    0,  943,  936,  953,  971,    0,  162, 1690,  995,  999,
			 1690, 1000, 1690, 1016, 1690,  152, 1003, 1010, 1024, 1032,
			 1042, 1076,  360,    0,    0, 1004, 1003,    0,    0, 1037,
			  993,    0, 1000, 1039, 1039, 1042, 1044, 1032, 1039,    0,
			 1036, 1042, 1052, 1049,    0, 1050, 1060, 1065, 1062,    0,
			 1067, 1068, 1057, 1058, 1074, 1082, 1074, 1088, 1074,    0,
			 1076, 1096,    0, 1089, 1094,    0, 1086, 1098,  142, 1132,
			 1134, 1135, 1690, 1153, 1159, 1177, 1185, 1200, 1210, 1107,
			 1103,    0, 1148, 1159, 1175,    0,    0,    0, 1176,    0,
			 1183, 1182,    0, 1175, 1183, 1184, 1185, 1188, 1206, 1188,

			 1191, 1191,    0, 1203,    0, 1213,    0,    0,    0, 1200,
			 1207,    0, 1202, 1215, 1251, 1250, 1253, 1242, 1271, 1282,
			 1306, 1317, 1323, 1293, 1332, 1344,    0, 1239, 1303,    0,
			 1314, 1322, 1318,    0,    0, 1324,    0,    0,   86, 1324,
			 1334,    0, 1325, 1336,    0, 1337, 1338,    0, 1343, 1371,
			 1277, 1319, 1346, 1364, 1376, 1398, 1404, 1411, 1422, 1430,
			 1436, 1329,    0,    0,    0,    0,    0,  618, 1328,    0,
			 1388,    0,    0,    0, 1390, 1404, 1690, 1690, 1404, 1454,
			 1461,    0,  113,  113,    0,    0,    0, 1429, 1690,    0,
			    0, 1429, 1413, 1429, 1418,    0, 1690, 1500, 1513, 1526,

			 1539, 1552, 1563, 1576, 1585, 1598, 1611, 1624, 1637, 1650,
			 1663, 1676, 1137>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  596,    1,  597,  597,  598,  598,  599,  599,  600,
			  600,  596,  596,  596,  596,  596,  601,  602,  596,  603,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  596,  596,  596,  596,
			  596,  596,  596,  605,  596,  596,  596,  606,  606,  596,
			  596,  607,  608,  596,  596,  596,  596,  596,  596,  601,
			  596,  609,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  602,  610,  610,  610,

			  611,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  612,  596,  596,  596,  596,  596,  596,  596,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  596,  596,  605,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  606,  596,  596,
			  606,  607,  596,  608,  596,  596,  596,  596,  596,  609,

			  596,  596,  596,  596,  601,  596,  601,  596,  601,  601,
			  601,  601,  601,  601,  601,  596,  601,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  612,  596,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,

			  604,  604,  604,  604,  604,  604,  604,  604,  604,  596,
			  596,  596,  596,  596,  601,  601,  601,  601,  596,  601,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,

			  604,  604,  604,  604,  604,  604,  604,  596,  596,  601,
			  596,  601,  596,  601,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  596,  601,
			  601,  601,  596,  596,  596,  596,  596,  596,  596,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,

			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  601,  601,  601,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  601,
			  601,  601,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  601,  596,  596,  596,  596,
			  596,  604,  604,  604,  604,  604,  604,  604,  596,  604,
			  604,  604,  604,  604,  604,  604,    0,  596,  596,  596,

			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596>>)
		end

	yy_ec_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   23,   22,   24,   22,   25,   22,   26,   27,
			   28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
			   38,   39,   40,   41,   42,   43,   44,   45,   46,   47,
			   48,   49,   50,   51,   52,   53,   54,   55,   56,   57,
			   58,   59,   60,   61,   62,   63,   64,   65,   66,   67,

			   68,   69,   70,   71,   72,   73,   74,   75,   76,   77,
			   78,   79,   80,   81,   82,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,   94,    1,    1,    1,
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
			    0,    1,    1,    2,    1,    3,    1,    3,    3,    4,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    5,    5,    5,    5,    6,    7,    3,    3,    3,    3,
			    3,    3,    3,    5,    5,    5,    5,    5,    5,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    9,   10,    3,
			    3,    3,    3,   11,    3,    5,    5,    5,    5,    5,
			    5,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,   12,
			   13,    3,    3,    3,    3>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    2,    3,    4,    5,
			    5,    5,    6,    8,   11,   13,   16,   19,   22,   25,
			   28,   31,   34,   37,   40,   43,   46,   49,   52,   56,
			   60,   64,   67,   70,   73,   76,   79,   82,   85,   88,
			   91,   94,   97,  100,  103,  106,  109,  112,  115,  118,
			  121,  124,  127,  130,  133,  136,  139,  142,  144,  147,
			  150,  153,  156,  159,  161,  163,  165,  167,  169,  171,
			  173,  175,  177,  179,  181,  183,  185,  187,  188,  189,
			  190,  191,  192,  193,  194,  195,  196,  197,  198,  199,
			  200,  201,  202,  203,  205,  206,  207,  208,  209,  210,

			  211,  212,  213,  214,  215,  216,  217,  218,  220,  222,
			  223,  223,  223,  224,  225,  226,  227,  228,  229,  230,
			  231,  232,  233,  235,  236,  237,  238,  239,  240,  241,
			  242,  244,  245,  246,  247,  248,  249,  250,  252,  253,
			  254,  256,  257,  258,  259,  260,  261,  262,  264,  265,
			  266,  267,  268,  269,  270,  271,  272,  273,  274,  275,
			  276,  277,  278,  279,  280,  280,  281,  282,  283,  284,
			  285,  285,  286,  287,  288,  289,  290,  291,  292,  293,
			  294,  295,  296,  297,  298,  299,  300,  301,  302,  303,
			  304,  305,  306,  308,  309,  310,  310,  311,  312,  314,

			  316,  318,  320,  322,  324,  325,  327,  328,  330,  331,
			  332,  333,  334,  335,  336,  337,  338,  339,  341,  342,
			  344,  345,  346,  347,  348,  349,  350,  351,  352,  353,
			  354,  355,  356,  357,  358,  359,  360,  361,  362,  363,
			  364,  365,  366,  368,  369,  369,  370,  371,  371,  373,
			  375,  376,  376,  377,  378,  380,  382,  384,  385,  386,
			  387,  388,  389,  390,  391,  392,  393,  394,  396,  397,
			  398,  399,  400,  401,  402,  403,  404,  405,  406,  407,
			  408,  409,  410,  411,  412,  413,  415,  416,  418,  419,
			  420,  421,  422,  423,  424,  425,  426,  427,  428,  429,

			  430,  431,  432,  433,  434,  435,  436,  437,  438,  440,
			  441,  441,  443,  445,  447,  448,  449,  450,  451,  453,
			  454,  456,  457,  458,  459,  460,  461,  462,  463,  464,
			  465,  466,  467,  468,  469,  470,  471,  472,  473,  474,
			  475,  476,  477,  478,  479,  479,  480,  481,  481,  481,
			  482,  483,  484,  484,  485,  486,  487,  488,  489,  490,
			  491,  492,  493,  494,  495,  497,  498,  499,  500,  501,
			  502,  503,  505,  506,  507,  508,  509,  510,  511,  512,
			  513,  515,  516,  518,  520,  521,  523,  524,  525,  526,
			  528,  529,  530,  531,  532,  533,  534,  535,  536,  537,

			  539,  541,  542,  543,  544,  545,  547,  548,  549,  549,
			  550,  552,  553,  555,  556,  558,  559,  560,  560,  561,
			  561,  562,  563,  564,  566,  568,  569,  570,  572,  574,
			  575,  576,  578,  579,  580,  581,  582,  583,  584,  585,
			  587,  588,  589,  590,  591,  593,  594,  595,  596,  597,
			  599,  600,  601,  602,  603,  604,  605,  606,  607,  608,
			  610,  611,  612,  614,  615,  616,  618,  619,  620,  620,
			  621,  622,  623,  624,  624,  625,  626,  626,  626,  627,
			  628,  629,  631,  632,  633,  634,  636,  638,  640,  641,
			  643,  644,  645,  647,  648,  649,  650,  651,  652,  653,

			  654,  655,  656,  658,  659,  661,  662,  664,  666,  668,
			  669,  670,  672,  673,  674,  675,  676,  677,  677,  678,
			  679,  679,  679,  680,  680,  681,  681,  683,  684,  685,
			  687,  688,  689,  690,  692,  694,  695,  697,  699,  701,
			  702,  703,  705,  706,  707,  709,  710,  711,  713,  714,
			  715,  716,  717,  718,  718,  719,  719,  720,  721,  721,
			  721,  722,  723,  725,  727,  729,  731,  733,  734,  735,
			  737,  738,  740,  742,  744,  745,  746,  748,  750,  751,
			  751,  752,  754,  755,  756,  758,  760,  762,  763,  765,
			  767,  769,  770,  771,  772,  773,  775,  775>>)
		end

	yy_acclist_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  170,  170,  172,  172,  203,  201,  202,    2,  201,
			  202,    3,  202,   33,  201,  202,  173,  201,  202,   38,
			  201,  202,   12,  201,  202,  141,  201,  202,   21,  201,
			  202,   22,  201,  202,   29,  201,  202,   27,  201,  202,
			    6,  201,  202,   28,  201,  202,   11,  201,  202,   30,
			  201,  202,  112,  114,  201,  202,  112,  114,  201,  202,
			  112,  114,  201,  202,    5,  201,  202,    4,  201,  202,
			   16,  201,  202,   15,  201,  202,   17,  201,  202,    8,
			  201,  202,  110,  201,  202,  110,  201,  202,  110,  201,
			  202,  110,  201,  202,  110,  201,  202,  110,  201,  202,

			  110,  201,  202,  110,  201,  202,  110,  201,  202,  110,
			  201,  202,  110,  201,  202,  110,  201,  202,  110,  201,
			  202,  110,  201,  202,  110,  201,  202,  110,  201,  202,
			  110,  201,  202,  110,  201,  202,  110,  201,  202,   25,
			  201,  202,  201,  202,   26,  201,  202,   31,  201,  202,
			   23,  201,  202,   24,  201,  202,    9,  201,  202,  174,
			  202,  200,  202,  198,  202,  199,  202,  170,  202,  170,
			  202,  169,  202,  168,  202,  170,  202,  172,  202,  171,
			  202,  166,  202,  166,  202,  165,  202,    2,    3,  173,
			  162,  173,  173,  173,  173,  173,  173,  173,  173,  173,

			  173,  173,  173,  173, -366,  173,  173,   38,  141,  141,
			  141,    1,   32,    7,  116,   36,   20,  116,  112,  114,
			  112,  114,  111,   13,   34,   18,   19,   35,   14,  110,
			  110,  110,  110,   43,  110,  110,  110,  110,  110,  110,
			  110,  110,   52,  110,  110,  110,  110,  110,  110,  110,
			   64,  110,  110,  110,   71,  110,  110,  110,  110,  110,
			  110,  110,   79,  110,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,   37,   10,  174,  198,
			  191,  189,  190,  192,  193,  194,  195,  175,  176,  177,
			  178,  179,  180,  181,  182,  183,  184,  185,  186,  187,

			  188,  170,  169,  168,  170,  170,  167,  168,  172,  171,
			  165,  163,  161,  163,  173, -366,  149,  163,  147,  163,
			  148,  163,  150,  163,  173,  143,  163,  173,  144,  163,
			  173,  173,  173,  173,  173,  173,  173, -164,  173,  151,
			  163,  141,  117,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  118,  141,  116,  113,
			  116,  112,  114,  112,  114,  115,  110,  110,   41,  110,
			   42,  110,   44,  110,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,   55,  110,  110,  110,  110,  110,

			  110,  110,  110,  110,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,   75,  110,  110,   77,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  110,  110,   98,  110,
			  197,  152,  163,  145,  163,  146,  163,  173,  173,  173,
			  173,  158,  163,  173,  153,  163,  135,  133,  134,  136,
			  137,  142,  138,  139,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  116,  116,
			  116,  116,  112,  112,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,   53,  110,  110,  110,  110,

			  110,  110,  110,   62,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,   72,  110,  110,   74,  110,  106,  110,
			  110,   78,  110,  110,  110,  110,  108,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  110,   91,  110,   92,
			  110,  110,  110,  110,  110,   97,  110,  110,  196,  173,
			  154,  163,  173,  157,  163,  173,  160,  163,  142,  116,
			  116,  116,  116,  114,   39,  110,   40,  110,  110,  110,
			   45,  110,   46,  110,  110,  110,   50,  110,  110,  110,
			  110,  110,  110,  110,  110,   60,  110,  110,  110,  110,
			  110,   67,  110,  110,  110,  110,  110,   73,  110,  110,

			  110,  110,  110,  110,  110,  110,  110,  110,   87,  110,
			  110,  110,   90,  110,  110,  110,   95,  110,  110,  110,
			  173,  173,  173,  140,  116,  116,  116,  110,  110,   47,
			  110,  110,  110,  110,  101,  110,   54,  110,   56,  110,
			  110,   58,  110,  110,  110,   63,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,   81,  110,  110,   83,
			  110,  110,   85,  110,   86,  110,   88,  110,  110,  110,
			   94,  110,  110,  110,  173,  173,  173,  116,  116,  116,
			  116,   99,  110,  110,  110,   49,  110,  110,  110,  110,
			   61,  110,   65,  110,  110,   68,  110,   69,  110,  104,

			  110,  110,  110,  107,  110,  110,  110,   84,  110,  110,
			  110,   96,  110,  110,  173,  173,  173,  116,  116,  116,
			  116,  116,  110,   48,  110,   51,  110,   57,  110,   59,
			  110,   66,  110,  110,  110,   76,  110,  110,   82,  110,
			   89,  110,   93,  110,  110,  173,  156,  163,  159,  163,
			  116,  116,  100,  110,  110,  110,  102,  110,   70,  110,
			   80,  110,  110,  155,  163,  103,  110,  105,  110,  110,
			  110,  110,  110,  109,  110>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1690
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 596
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 597
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 202
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 203
			-- End of buffer rule code

	INITIAL: INTEGER is 0
	SPECIAL_STR: INTEGER is 1
	VERBATIM_STR1: INTEGER is 2
	VERBATIM_STR2: INTEGER is 3
	VERBATIM_STR3: INTEGER is 4
			-- Start condition codes

feature -- User-defined features



end -- class EIFFEL_SCANNER


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
