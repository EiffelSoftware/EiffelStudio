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

				current_position.go_to (1)
				last_token := TE_SEMICOLON
			
when 5 then
--|#line 57

				current_position.go_to (1)
				last_token := TE_COLON
			
when 6 then
--|#line 61

				current_position.go_to (1)
				last_token := TE_COMMA
			
when 7 then
--|#line 65

				current_position.go_to (2)
				last_token := TE_DOTDOT
			
when 8 then
--|#line 69

				current_position.go_to (1)
				last_token := TE_QUESTION
			
when 9 then
--|#line 73

				current_position.go_to (1)
				last_token := TE_TILDE
			
when 10 then
--|#line 77

				current_position.go_to (2)
				last_token := TE_CURLYTILDE
			
when 11 then
--|#line 81

				current_position.go_to (1)
				last_token := TE_DOT
			
when 12 then
--|#line 85

				current_position.go_to (1)
				last_token := TE_ADDRESS
			
when 13 then
--|#line 89

				current_position.go_to (2)
				last_token := TE_ASSIGN
			
when 14 then
--|#line 93

				current_position.go_to (2)
				last_token := TE_ACCEPT
			
when 15 then
--|#line 97

				current_position.go_to (1)
				last_token := TE_EQ
			
when 16 then
--|#line 101

				current_position.go_to (1)
				last_token := TE_LT
			
when 17 then
--|#line 105

				current_position.go_to (1)
				last_token := TE_GT
			
when 18 then
--|#line 109

				current_position.go_to (2)
				last_token := TE_LE
			
when 19 then
--|#line 113

				current_position.go_to (2)
				last_token := TE_GE
			
when 20 then
--|#line 117

				current_position.go_to (2)
				last_token := TE_NE
			
when 21 then
--|#line 121

				current_position.go_to (1)
				last_token := TE_LPARAN
			
when 22 then
--|#line 125

				current_position.go_to (1)
				last_token := TE_RPARAN
			
when 23 then
--|#line 129

				current_position.go_to (1)
				last_token := TE_LCURLY
			
when 24 then
--|#line 133

				current_position.go_to (1)
				last_token := TE_RCURLY
			
when 25 then
--|#line 137

				current_position.go_to (1)
				last_token := TE_LSQURE
			
when 26 then
--|#line 141

				current_position.go_to (1)
				last_token := TE_RSQURE
			
when 27 then
--|#line 145

				current_position.go_to (1)
				last_token := TE_PLUS
			
when 28 then
--|#line 149

				current_position.go_to (1)
				last_token := TE_MINUS
			
when 29 then
--|#line 153

				current_position.go_to (1)
				last_token := TE_STAR
			
when 30 then
--|#line 157

				current_position.go_to (1)
				last_token := TE_SLASH
			
when 31 then
--|#line 161

				current_position.go_to (1)
				last_token := TE_POWER
			
when 32 then
--|#line 165

				current_position.go_to (2)
				last_token := TE_CONSTRAIN
			
when 33 then
--|#line 169

				current_position.go_to (1)
				last_token := TE_BANG
			
when 34 then
--|#line 173

				current_position.go_to (2)
				last_token := TE_LARRAY
			
when 35 then
--|#line 177

				current_position.go_to (2)
				last_token := TE_RARRAY
			
when 36 then
--|#line 181

				current_position.go_to (2)
				last_token := TE_DIV
			
when 37 then
--|#line 185

				current_position.go_to (2)
				last_token := TE_MOD
			
when 38 then
--|#line 193

					-- Note: Free operators are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := TE_FREE
			
when 39 then
--|#line 205

				current_position.go_to (5)
				last_token := TE_ALIAS
			
when 40 then
--|#line 209

				current_position.go_to (3)
				last_token := TE_ALL
			
when 41 then
--|#line 213

				current_position.go_to (3)
				last_token := TE_AND
			
when 42 then
--|#line 217

				current_position.go_to (2)
				last_token := TE_AS
			
when 43 then
--|#line 221

				current_position.go_to (3)
				last_token := TE_BIT
			
when 44 then
--|#line 225

				current_position.go_to (5)
				last_token := TE_CHECK
			
when 45 then
--|#line 229

				current_position.go_to (5)
				last_token := TE_CLASS
			
when 46 then
--|#line 233

				current_position.go_to (6)
				last_token := TE_CREATION
			
when 47 then
--|#line 237

				current_position.go_to (8)
				last_token := TE_CREATION
			
when 48 then
--|#line 241

				current_position.go_to (7)
				last_token := TE_CURRENT
			
when 49 then
--|#line 245

				current_position.go_to (5)
				last_token := TE_DEBUG
			
when 50 then
--|#line 249

				current_position.go_to (8)
				last_token := TE_DEFERRED
			
when 51 then
--|#line 253

				current_position.go_to (2)
				last_token := TE_DO
			
when 52 then
--|#line 257

				current_position.go_to (4)
				last_token := TE_ELSE
			
when 53 then
--|#line 261

				current_position.go_to (6)
				last_token := TE_ELSEIF
			
when 54 then
--|#line 265

				current_position.go_to (3)
				last_token := TE_END
			
when 55 then
--|#line 269

				current_position.go_to (6)
				last_token := TE_ENSURE
			
when 56 then
--|#line 273

				current_position.go_to (8)
				last_token := TE_EXPANDED
			
when 57 then
--|#line 277

				current_position.go_to (6)
				last_token := TE_EXPORT
			
when 58 then
--|#line 281

				current_position.go_to (8)
				last_token := TE_EXTERNAL
			
when 59 then
--|#line 285

				current_position.go_to (5)
				last_token := TE_FALSE
			
when 60 then
--|#line 289

				current_position.go_to (7)
				last_token := TE_FEATURE
			
when 61 then
--|#line 293

				current_position.go_to (4)
				last_token := TE_FROM
			
when 62 then
--|#line 297

				current_position.go_to (6)
				last_token := TE_FROZEN
			
when 63 then
--|#line 301

				current_position.go_to (2)
				last_token := TE_IF
			
when 64 then
--|#line 305

				current_position.go_to (7)
				last_token := TE_IMPLIES
			
when 65 then
--|#line 309

				current_position.go_to (8)
				last_token := TE_INDEXING
			
when 66 then
--|#line 313

				current_position.go_to (5)
				last_token := TE_INFIX
			
when 67 then
--|#line 317

				current_position.go_to (7)
				last_token := TE_INHERIT
			
when 68 then
--|#line 321

				current_position.go_to (7)
				last_token := TE_INSPECT
			
when 69 then
--|#line 325

				current_position.go_to (9)
				last_token := TE_INVARIANT
			
when 70 then
--|#line 329

				current_position.go_to (2)
				last_token := TE_IS
			
when 71 then
--|#line 333

				current_position.go_to (4)
				last_token := TE_LIKE
			
when 72 then
--|#line 337

				current_position.go_to (5)
				last_token := TE_LOCAL
			
when 73 then
--|#line 341

				current_position.go_to (4)
				last_token := TE_LOOP
			
when 74 then
--|#line 345

				current_position.go_to (3)
				last_token := TE_NOT
			
when 75 then
--|#line 349

				current_position.go_to (8)
				last_token := TE_OBSOLETE
			
when 76 then
--|#line 353

				current_position.go_to (3)
				last_token := TE_OLD
			
when 77 then
--|#line 357

				current_position.go_to (4)
				last_token := TE_ONCE
			
when 78 then
--|#line 361

				current_position.go_to (2)
				last_token := TE_OR
			
when 79 then
--|#line 365

				current_position.go_to (9)
				last_token := TE_PRECURSOR
			
when 80 then
--|#line 369

				current_position.go_to (6)
				last_token := TE_PREFIX
			
when 81 then
--|#line 373

				current_position.go_to (8)
				last_token := TE_REDEFINE
			
when 82 then
--|#line 377

				current_position.go_to (6)
				last_token := TE_RENAME
			
when 83 then
--|#line 381

				current_position.go_to (7)
				last_token := TE_REQUIRE
			
when 84 then
--|#line 385

				current_position.go_to (6)
				last_token := TE_RESCUE
			
when 85 then
--|#line 389

				current_position.go_to (6)
				last_token := TE_RESULT
			
when 86 then
--|#line 393

				current_position.go_to (5)
				last_token := TE_RETRY
			
when 87 then
--|#line 397

				current_position.go_to (6)
				last_token := TE_SELECT
			
when 88 then
--|#line 401

				current_position.go_to (8)
				last_token := TE_SEPARATE
			
when 89 then
--|#line 405

				current_position.go_to (5)
				last_token := TE_STRIP
			
when 90 then
--|#line 409

				current_position.go_to (4)
				last_token := TE_THEN
			
when 91 then
--|#line 413

				current_position.go_to (4)
				last_token := TE_TRUE
			
when 92 then
--|#line 417

				current_position.go_to (8)
				last_token := TE_UNDEFINE
			
when 93 then
--|#line 421

				current_position.go_to (6)
				last_token := TE_UNIQUE
			
when 94 then
--|#line 425

				current_position.go_to (5)
				last_token := TE_UNTIL
			
when 95 then
--|#line 429

				current_position.go_to (7)
				last_token := TE_VARIANT
			
when 96 then
--|#line 433

				current_position.go_to (4)
				last_token := TE_WHEN
			
when 97 then
--|#line 437

				current_position.go_to (3)
				last_token := TE_XOR
			
when 98 then
--|#line 445

				current_position.go_to (7)
				last_token := TE_BOOLEAN_ID
			
when 99 then
--|#line 449

				current_position.go_to (9)
				last_token := TE_CHARACTER_ID
			
when 100 then
--|#line 453

				current_position.go_to (6)
				last_token := TE_DOUBLE_ID
			
when 101 then
--|#line 457

				current_position.go_to (7)
				last_token := TE_INTEGER_ID
			
when 102 then
--|#line 461

				current_position.go_to (4)
				last_token := TE_NONE_ID
			
when 103 then
--|#line 465

				current_position.go_to (7)
				last_token := TE_POINTER_ID
			
when 104 then
--|#line 469

				current_position.go_to (4)
				last_token := TE_REAL_ID
			
when 105 then
--|#line 473

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 106 then
--|#line 485

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				current_position.go_to (token_buffer.count + 1)
				last_token := TE_A_BIT
			
when 107 then
--|#line 495
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
			
when 108 then
	yy_position := yy_position - 2
--|#line 496
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
			
when 109 then
--|#line 509

				token_buffer.clear_all
				append_without_underscores (text, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 110 then
--|#line 519

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (text_count)
				last_token := TE_REAL
			
when 111 then
--|#line 530

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 112 then
--|#line 536

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 113 then
--|#line 543

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 114 then
--|#line 549

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 115 then
--|#line 555

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 116 then
--|#line 561

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 117 then
--|#line 567

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 118 then
--|#line 573

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 119 then
--|#line 579

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 120 then
--|#line 585

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 121 then
--|#line 591

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 122 then
--|#line 597

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 123 then
--|#line 603

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 124 then
--|#line 609

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 125 then
--|#line 615

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 126 then
--|#line 621

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 127 then
--|#line 627

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 128 then
--|#line 633

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 129 then
--|#line 639

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 130 then
--|#line 645

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 131 then
--|#line 651

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 132 then
--|#line 657

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 133 then
--|#line 663

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 134 then
--|#line 669

				current_position.go_to (text_count)
				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 135, 136 then
--|#line 673

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				current_position.go_to (text_count)
				report_character_missing_quote_error (text)
			
when 137 then
--|#line 684

				current_position.go_to (3)
				last_token := TE_STR_LT
			
when 138 then
--|#line 688

				current_position.go_to (3)
				last_token := TE_STR_GT
			
when 139 then
--|#line 692

				current_position.go_to (4)
				last_token := TE_STR_LE
			
when 140 then
--|#line 696

				current_position.go_to (4)
				last_token := TE_STR_GE
			
when 141 then
--|#line 700

				current_position.go_to (3)
				last_token := TE_STR_PLUS
			
when 142 then
--|#line 704

				current_position.go_to (3)
				last_token := TE_STR_MINUS
			
when 143 then
--|#line 708

				current_position.go_to (3)
				last_token := TE_STR_STAR
			
when 144 then
--|#line 712

				current_position.go_to (3)
				last_token := TE_STR_SLASH
			
when 145 then
--|#line 716

				current_position.go_to (3)
				last_token := TE_STR_POWER
			
when 146 then
--|#line 720

				current_position.go_to (4)
				last_token := TE_STR_DIV
			
when 147 then
--|#line 724

				current_position.go_to (4)
				last_token := TE_STR_MOD
			
when 148 then
--|#line 728

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_AND
			
when 149 then
--|#line 734

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				current_position.go_to (10)
				last_token := TE_STR_AND_THEN
			
when 150 then
--|#line 740

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_IMPLIES
			
when 151 then
--|#line 746

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_NOT
			
when 152 then
--|#line 752

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				current_position.go_to (4)
				last_token := TE_STR_OR
			
when 153 then
--|#line 758

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_OR_ELSE
			
when 154 then
--|#line 764

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_XOR
			
when 155 then
--|#line 770

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STR_FREE
			
when 156 then
--|#line 777

					-- Empty string.
				current_position.go_to (2)
				last_token := TE_EMPTY_STRING
			
when 157 then
--|#line 782

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STRING
			
when 158 then
--|#line 788

				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (IN_STR)
			
when 159 then
--|#line 797

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			
when 160 then
--|#line 801

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 161 then
--|#line 805

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 162 then
--|#line 809

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 163 then
--|#line 813

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 164 then
--|#line 817

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 165 then
--|#line 821

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 166 then
--|#line 825

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 167 then
--|#line 829

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 168 then
--|#line 833

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 169 then
--|#line 837

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 170 then
--|#line 841

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 171 then
--|#line 845

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 172 then
--|#line 849

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 173 then
--|#line 853

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 174 then
--|#line 857

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 175 then
--|#line 861

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 176 then
--|#line 865

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 177 then
--|#line 869

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 178 then
--|#line 873

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 179 then
--|#line 877

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 180 then
--|#line 881

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 181 then
--|#line 885

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 182 then
--|#line 889

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 183 then
--|#line 896

				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (INITIAL)
				if token_buffer.empty then
						-- Empty string.
					last_token := TE_EMPTY_STRING
				else
					last_token := TE_STRING
				end
			
when 184 then
--|#line 909

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 185 then
--|#line 915

					-- No final double-quote.
				line_number := line_number + 1
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 186 then
--|#line 941

				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			
when 187 then
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
			    0,    6,    7,    8,    7,    9,   10,   11,   12,    6,
			   11,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   27,   28,   29,   11,   30,
			   31,   32,   33,   34,   35,   36,   36,   37,   36,   36,
			   38,   36,   39,   40,   41,   36,   42,   43,   44,   45,
			   46,   47,   48,   36,   36,   49,   50,   51,   52,    6,
			    6,   30,   31,   32,   33,   34,   35,   36,   36,   37,
			   36,   36,   38,   36,   39,   40,   41,   36,   42,   43,
			   44,   45,   46,   47,   48,   36,   36,   53,   11,   54,
			   55,   57,   57,  541,   58,   58,  166,   59,   59,   60,

			   82,   60,   63,   64,  534,   80,   64,   81,  533,   83,
			   65,   66,   86,   67,   84,   68,   85,   85,   87,   60,
			   69,   60,   70,  103,   64,   71,   94,   95,   88,  104,
			   89,   90,   88,   72,   90,   90,   96,   97,   73,   74,
			   91,  370,  100,  105,  101,  121,  182,  106,   75,  102,
			  109,  122,   76,  107,   77,  103,  108,   71,  433,  123,
			  110,  104,  130,  216,  216,   72,  111,  377,  112,   92,
			   73,   74,   91,   92,  100,  105,  101,  121,  113,  106,
			   75,  102,  109,  122,   64,  107,  114,  135,  108,  117,
			  115,  123,  110,  131,  130,  124,  118,  119,  111,  133,

			  112,  128,  120,  116,  129,  125,  136,  126,  132,  134,
			  113,  127,  137,  138,  273,  273,  375,  171,  114,  135,
			  439,  117,  115,  173,  275,  131,  166,  124,  118,  119,
			  172,  133,  175,  128,  120,  116,  129,  125,  136,  126,
			  132,  134,  174,  127,  137,  138,  143,  143,  143,  166,
			  144,  176,  166,  145,  275,  146,  147,  148,  166,   62,
			   62,   92,   62,  149,  167,  166,  180,  307,  150,   88,
			  151,  214,  215,  152,  153,  154,  155,  219,  156,  217,
			  157,   91,  218,  220,  158,  177,  159,  178,  221,  160,
			  161,  162,  163,  164,  165,  179,  224,  222,  180,  209,

			  209,  223,  181,  211,  225,  212,  212,  226,  306,  219,
			   92,  217,  210,   91,  218,  220,  305,  177,  213,  178,
			  221,   88,  229,  215,  215,  230,  304,  179,  224,  222,
			  143,  143,  143,  223,  181,  186,  225,  272,  187,  226,
			  188,  189,  190,  282,  210,  283,  291,  291,  191,  231,
			  213,  235,  227,  192,  229,  193,  228,  230,  194,  195,
			  196,  197,   92,  198,  232,  199,  233,  236,  237,  200,
			  234,  201,  238,  303,  202,  203,  204,  205,  206,  207,
			  245,  231,  250,  235,  227,  246,  251,  248,  228,  252,
			  239,  253,  240,  249,  241,  254,  232,  247,  233,  236,

			  237,  263,  234,  261,  238,  242,  243,  262,  244,  166,
			  264,  265,  245,  166,  250,  166,  269,  246,  251,  248,
			  270,  252,  239,  253,  240,  249,  241,  254,  255,  247,
			  271,  256,  166,  263,  372,  261,  373,  242,  243,  262,
			  244,  257,  264,  265,  258,  266,  259,  260,  269,  284,
			  267,  280,  270,  308,  308,  311,  311,  281,  279,  302,
			  255,  268,  271,  256,  301,  309,  210,  309,  312,  300,
			  310,  310,   88,  257,  315,  316,  258,  266,  259,  260,
			  318,  284,  267,  280,   91,  319,  313,  320,  313,  281,
			  279,  314,  314,  268,   88,  321,  316,  316,  210,  322,

			  312,  317,  317,  299,  323,  324,  325,  326,  327,  328,
			  329,  330,  318,   92,  332,  333,   91,  319,  334,  320,
			  335,  337,  338,  339,  340,  331,  341,  321,  342,  343,
			  344,  322,  345,  336,  346,   92,  323,  324,  325,  326,
			  327,  328,  329,  330,  347,  348,  332,  333,  349,  350,
			  334,  353,  335,  337,  338,  339,  340,  331,  341,  354,
			  342,  343,  344,  355,  345,  336,  346,  351,  356,  357,
			  352,  359,  360,  361,  362,  363,  347,  348,  364,  365,
			  349,  350,  366,  353,  367,  368,  369,  358,  370,  371,
			  371,  354,  166,  166,  298,  355,  378,  291,  291,  351,

			  356,  357,  352,  359,  360,  361,  362,  363,  379,  379,
			  364,  365,  310,  310,  366,  297,  367,  368,  369,  358,
			  376,  210,  310,  310,  381,  381,  374,  382,  386,  382,
			  314,  314,  383,  383,  314,  314,  384,  312,  315,  316,
			  384,  387,  316,  316,  385,  385,  388,  380,   91,  389,
			  390,  391,  376,  210,  392,  393,  394,  395,  374,  396,
			  386,  397,  398,  399,  400,  401,  402,  403,  404,  312,
			  405,  406,  407,  387,  408,  409,  410,  411,  388,  412,
			   91,  389,  390,  391,  413,  414,  392,  393,  394,  395,
			  415,  396,  416,  397,  398,  399,  400,  401,  402,  403,

			  404,  417,  405,  406,  407,  418,  408,  409,  410,  411,
			  419,  412,  420,  421,  422,  423,  413,  414,  424,  425,
			  426,  427,  415,  428,  416,  370,  429,  429,  166,  166,
			  166,  435,  435,  417,  440,  379,  379,  418,  383,  383,
			  383,  383,  419,  441,  420,  421,  422,  423,  434,  444,
			  424,  425,  426,  427,  442,  428,  436,  436,  443,  211,
			  431,  436,  436,  296,  432,  445,  440,  446,  447,  312,
			  430,  448,  449,  450,  438,  441,  451,  452,  453,  454,
			  434,  444,  455,  456,  457,  458,  442,  459,  460,  461,
			  443,  462,  431,  463,  464,  437,  432,  445,  465,  446,

			  447,  312,  430,  448,  449,  450,  438,  466,  451,  452,
			  453,  454,  467,  468,  455,  456,  457,  458,  469,  459,
			  460,  461,  470,  462,  471,  463,  464,  472,  473,  166,
			  465,  166,  477,  295,  477,  166,  294,  478,  478,  466,
			  479,  479,  436,  436,  467,  468,  482,  482,  486,  487,
			  469,  482,  482,  480,  470,  481,  471,  488,  489,  472,
			  473,  474,  475,  483,  485,  483,  490,  491,  484,  484,
			  476,  492,  493,  494,  495,  496,  497,  498,  499,  500,
			  486,  487,  501,  502,  503,  480,  504,  481,  505,  488,
			  489,  506,  507,  474,  475,  166,  485,  166,  490,  491,

			  166,  293,  476,  492,  493,  494,  495,  496,  497,  498,
			  499,  500,  478,  478,  501,  502,  503,  520,  504,  521,
			  505,  522,  508,  506,  507,  478,  478,  510,  511,  511,
			  512,  523,  512,  516,  516,  513,  513,  514,  509,  514,
			  524,  480,  515,  515,  484,  484,  517,  484,  484,  520,
			  518,  521,  518,  522,  508,  519,  519,  525,  526,  510,
			  527,  528,  529,  523,  530,  531,  166,  513,  513,  480,
			  509,  292,  524,  480,  513,  513,  515,  515,  517,  515,
			  515,  538,  536,  539,  536,  535,  535,  537,  537,  525,
			  526,  540,  527,  528,  529,  380,  530,  531,  517,  519,

			  519,  480,  532,  519,  519,  517,  537,  537,  537,  537,
			  290,  289,  288,  538,  287,  539,  286,  285,  278,  277,
			  276,  275,  142,  540,  208,  185,  183,  170,  169,  168,
			  517,  437,  166,   61,  532,  142,  140,  517,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   62,  139,   62,   98,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   78,   93,   78,   78,   78,   78,   78,   78,
			   78,   78,   78,   78,   78,   78,   78,   79,   61,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,

			   79,   79,   79,   79,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  141,  542,  141,
			  542,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,   64,  542,   64,  542,   64,   64,
			   64,   64,   64,   64,   64,   64,   64,   64,   64,   64,
			   64,  184,  542,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,   82,  542,
			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,   82,   82,   82,   82,  274,  542,  274,  274,  274,
			  274,  274,  274,  274,  274,  274,  274,  274,  274,  274,

			    5,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542>>)
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
			    1,    3,    4,  532,    3,    4,   76,    3,    4,    7,

			   19,    7,   10,   10,  510,   13,   10,   13,  509,   19,
			   10,   10,   21,   10,   20,   10,   20,   20,   21,   60,
			   10,   60,   10,   31,   10,   10,   26,   26,   22,   31,
			   22,   22,   23,   10,   23,   23,   28,   28,   10,   10,
			   22,  429,   30,   32,   30,   38,   76,   32,   10,   30,
			   33,   38,   10,   32,   10,   31,   32,   10,  378,   39,
			   33,   31,   42,   92,   92,   10,   34,  284,   34,   22,
			   10,   10,   22,   23,   30,   32,   30,   38,   34,   32,
			   10,   30,   33,   38,   10,   32,   35,   45,   32,   37,
			   35,   39,   33,   43,   42,   40,   37,   37,   34,   44,

			   34,   41,   37,   35,   41,   40,   46,   40,   43,   44,
			   34,   40,   47,   48,  149,  149,  281,   68,   35,   45,
			  385,   37,   35,   69,  275,   43,   74,   40,   37,   37,
			   68,   44,   70,   41,   37,   35,   41,   40,   46,   40,
			   43,   44,   69,   40,   47,   48,   59,   59,   59,   71,
			   59,   70,   72,   59,  274,   59,   59,   59,   73,   64,
			   64,  385,   64,   59,   64,   75,   74,  207,   59,   89,
			   59,   89,   89,   59,   59,   59,   59,  101,   59,  100,
			   59,   89,  100,  103,   59,   71,   59,   72,  104,   59,
			   59,   59,   59,   59,   59,   73,  106,  105,   74,   85,

			   85,  105,   75,   88,  107,   88,   88,  108,  206,  101,
			   89,  100,   85,   89,  100,  103,  205,   71,   88,   72,
			  104,   90,  110,   90,   90,  111,  204,   73,  106,  105,
			  143,  143,  143,  105,   75,   80,  107,  143,   80,  108,
			   80,   80,   80,  180,   85,  180,  191,  191,   80,  112,
			   88,  114,  109,   80,  110,   80,  109,  111,   80,   80,
			   80,   80,   90,   80,  112,   80,  113,  115,  116,   80,
			  113,   80,  118,  203,   80,   80,   80,   80,   80,   80,
			  121,  112,  124,  114,  109,  122,  125,  123,  109,  126,
			  119,  128,  119,  123,  119,  129,  112,  122,  113,  115,

			  116,  132,  113,  131,  118,  119,  119,  131,  119,  181,
			  133,  134,  121,  178,  124,  179,  136,  122,  125,  123,
			  137,  126,  119,  128,  119,  123,  119,  129,  130,  122,
			  138,  130,  177,  132,  279,  131,  279,  119,  119,  131,
			  119,  130,  133,  134,  130,  135,  130,  130,  136,  181,
			  135,  178,  137,  209,  209,  212,  212,  179,  177,  202,
			  130,  135,  138,  130,  201,  210,  209,  210,  212,  200,
			  210,  210,  214,  130,  214,  214,  130,  135,  130,  130,
			  217,  181,  135,  178,  214,  221,  213,  222,  213,  179,
			  177,  213,  213,  135,  215,  223,  215,  215,  209,  224,

			  212,  216,  216,  199,  225,  226,  227,  228,  229,  230,
			  232,  233,  217,  214,  234,  235,  214,  221,  236,  222,
			  237,  238,  239,  240,  241,  233,  242,  223,  243,  244,
			  245,  224,  246,  237,  247,  215,  225,  226,  227,  228,
			  229,  230,  232,  233,  248,  250,  234,  235,  252,  253,
			  236,  255,  237,  238,  239,  240,  241,  233,  242,  256,
			  243,  244,  245,  257,  246,  237,  247,  254,  258,  259,
			  254,  260,  261,  262,  263,  264,  248,  250,  265,  266,
			  252,  253,  267,  255,  268,  269,  270,  259,  273,  273,
			  273,  256,  280,  282,  198,  257,  291,  291,  291,  254,

			  258,  259,  254,  260,  261,  262,  263,  264,  308,  308,
			  265,  266,  309,  309,  267,  197,  268,  269,  270,  259,
			  282,  308,  310,  310,  311,  311,  280,  312,  318,  312,
			  313,  313,  312,  312,  314,  314,  315,  311,  315,  315,
			  316,  319,  316,  316,  317,  317,  320,  308,  315,  321,
			  322,  323,  282,  308,  324,  325,  326,  327,  280,  328,
			  318,  329,  330,  331,  332,  333,  334,  336,  337,  311,
			  338,  339,  340,  319,  341,  342,  343,  345,  320,  348,
			  315,  321,  322,  323,  350,  351,  324,  325,  326,  327,
			  352,  328,  354,  329,  330,  331,  332,  333,  334,  336,

			  337,  355,  338,  339,  340,  356,  341,  342,  343,  345,
			  357,  348,  358,  359,  360,  361,  350,  351,  362,  365,
			  366,  367,  352,  368,  354,  371,  371,  371,  372,  374,
			  376,  380,  380,  355,  387,  379,  379,  356,  382,  382,
			  383,  383,  357,  388,  358,  359,  360,  361,  379,  392,
			  362,  365,  366,  367,  391,  368,  381,  381,  391,  384,
			  374,  384,  384,  196,  376,  394,  387,  395,  396,  381,
			  372,  397,  398,  399,  384,  388,  400,  402,  403,  404,
			  379,  392,  405,  407,  408,  409,  391,  410,  412,  413,
			  391,  414,  374,  415,  416,  381,  376,  394,  417,  395,

			  396,  381,  372,  397,  398,  399,  384,  418,  400,  402,
			  403,  404,  419,  420,  405,  407,  408,  409,  422,  410,
			  412,  413,  423,  414,  425,  415,  416,  426,  428,  432,
			  417,  430,  434,  195,  434,  431,  194,  434,  434,  418,
			  435,  435,  436,  436,  419,  420,  437,  437,  440,  441,
			  422,  439,  439,  435,  423,  436,  425,  443,  444,  426,
			  428,  430,  431,  438,  439,  438,  445,  449,  438,  438,
			  432,  451,  452,  454,  455,  456,  457,  458,  459,  460,
			  440,  441,  461,  462,  464,  435,  466,  436,  470,  443,
			  444,  471,  473,  430,  431,  474,  439,  475,  445,  449,

			  476,  193,  432,  451,  452,  454,  455,  456,  457,  458,
			  459,  460,  477,  477,  461,  462,  464,  487,  466,  488,
			  470,  490,  474,  471,  473,  478,  478,  476,  479,  479,
			  480,  491,  480,  482,  482,  480,  480,  481,  475,  481,
			  492,  479,  481,  481,  483,  483,  482,  484,  484,  487,
			  485,  488,  485,  490,  474,  485,  485,  495,  499,  476,
			  500,  502,  503,  491,  505,  506,  508,  512,  512,  511,
			  475,  192,  492,  479,  513,  513,  514,  514,  482,  515,
			  515,  520,  517,  526,  517,  516,  516,  517,  517,  495,
			  499,  528,  500,  502,  503,  511,  505,  506,  516,  518,

			  518,  511,  508,  519,  519,  535,  536,  536,  537,  537,
			  190,  189,  188,  520,  187,  526,  186,  182,  176,  174,
			  172,  167,  141,  528,   81,   79,   77,   67,   66,   65,
			  516,  535,   62,   61,  508,   56,   54,  535,  543,  543,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,  543,  544,   50,  544,   29,  544,
			  544,  544,  544,  544,  544,  544,  544,  544,  544,  544,
			  544,  544,  545,   24,  545,  545,  545,  545,  545,  545,
			  545,  545,  545,  545,  545,  545,  545,  546,    8,  546,
			  546,  546,  546,  546,  546,  546,  546,  546,  546,  546,

			  546,  546,  546,  546,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  548,    5,  548,
			    0,  548,  548,  548,  548,  548,  548,  548,  548,  548,
			  548,  548,  548,  548,  549,    0,  549,    0,  549,  549,
			  549,  549,  549,  549,  549,  549,  549,  549,  549,  549,
			  549,  550,    0,  550,  550,  550,  550,  550,  550,  550,
			  550,  550,  550,  550,  550,  550,  550,  550,  551,    0,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  552,    0,  552,  552,  552,
			  552,  552,  552,  552,  552,  552,  552,  552,  552,  552,

			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   88,   89, 1118, 1200,   97, 1085, 1200,
			   96,    0, 1200,   96, 1200, 1200, 1200, 1200, 1200,   83,
			   96,   93,  110,  114, 1048, 1200,  102, 1200,  111, 1033,
			  102,   86,  107,  117,  126,  157,    0,  155,  108,  116,
			  165,  158,  129,  160,  163,  145,  177,  176,  170, 1200,
			 1000, 1200, 1200, 1200,  946, 1200, 1029, 1200, 1200,  244,
			  117, 1030, 1026, 1200,  258, 1023, 1022, 1021,  211,  217,
			  226,  243,  246,  252,  220,  259,   90, 1020,    0, 1014,
			  329, 1013,    0, 1200, 1200,  279, 1200, 1200,  285,  251,
			  303, 1200,  143, 1200, 1200, 1200, 1200, 1200, 1200,    0,

			  242,  245,    0,  235,  245,  268,  267,  271,  261,  322,
			  273,  278,  317,  322,  311,  338,  325,    0,  328,  358,
			    0,  341,  354,  345,  335,  354,  358,    0,  354,  362,
			  399,  363,  355,  377,  362,  413,  370,  387,  384, 1200,
			 1200, 1016, 1200,  328, 1200, 1200, 1200, 1200, 1200,  194,
			 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200,
			 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1015, 1200, 1200,
			 1200, 1200, 1014, 1200, 1013, 1200, 1012,  426,  407,  409,
			  339,  403, 1011, 1200, 1200, 1200, 1005, 1003, 1001, 1000,
			  999,  326,  960,  890,  825,  822,  752,  604,  583,  492,

			  458,  453,  448,  362,  315,  305,  297,  256, 1200,  433,
			  450, 1200,  435,  471,  454,  476,  481,  451,    0,    0,
			    0,  445,  441,  464,  452,  475,  459,  457,  474,  478,
			  476,    0,  461,  482,  481,  468,  470,  479,  481,  489,
			  486,  491,  482,  495,  500,  497,  503,  490,  511,    0,
			  502,    0,  515,  507,  536,  511,  526,  534,  519,  538,
			  525,  539,  544,  537,  533,  545,  546,  537,  547,  548,
			  544,    0, 1200,  569,  248,  218, 1200, 1200, 1200,  430,
			  586,  210,  587, 1200,  161, 1200, 1200, 1200, 1200, 1200,
			 1200,  577, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200,

			 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200,  588,  592,
			  602,  604,  612,  610,  614,  618,  622,  624,  581,  608,
			  617,  610,  603,  603,  621,  620,  610,  617,  622,  615,
			  620,  617,  618,  632,  617,    0,  634,  631,  618,  619,
			  626,  641,  640,  630,    0,  637,    0,    0,  639,    0,
			  636,  636,  653,    0,  658,  660,  668,  661,  672,  660,
			  683,  669,  674,    0,    0,  685,  671,  681,  694,    0,
			 1200,  706,  722, 1200,  723, 1200,  724, 1200,  147,  715,
			  711,  736,  718,  720,  741,  202,    0,  705,  712,    0,
			    0,  721,  707,    0,  719,  734,  734,  738,  740,  725,

			  734,    0,  731,  736,  746,  745,    0,  746,  753,  752,
			  750,    0,  755,  756,  745,  741,  757,  765,  761,  779,
			  765,    0,  770,  793,    0,  787,  794,    0,  786,  122,
			  825,  829,  823, 1200,  817,  820,  822,  826,  848,  831,
			  806,  801,    0,  814,  810,  833,    0,    0,    0,  834,
			    0,  842,  839,    0,  826,  832,  827,  828,  831,  849,
			  831,  836,  836,    0,  842,    0,  853,    0,    0,    0,
			  840,  849,    0,  844,  889,  891,  894,  892,  905,  908,
			  915,  922,  913,  924,  927,  935,    0,  884,  877,    0,
			  889,  899,  900,    0,    0,  922,    0,    0,    0,  916,

			  927,    0,  918,  929,    0,  931,  932,    0,  960,  102,
			   98,  936,  947,  954,  956,  959,  965,  967,  979,  983,
			  935,    0,    0,    0,    0,    0,  935,    0,  945,    0,
			    0,    0,   87, 1200, 1200,  972,  986,  988,    0,    0,
			    0, 1200, 1200, 1037, 1054, 1069, 1086, 1099, 1116, 1133,
			 1150, 1167, 1182>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  542,    1,  543,  543,  542,  542,  542,  542,  542,
			  544,  545,  542,  546,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  542,
			  542,  542,  542,  542,  542,  542,  548,  542,  542,  542,
			  542,  542,  544,  542,  549,  544,  544,  544,  544,  544,
			  544,  544,  544,  544,  544,  544,  544,  544,  545,  550,
			  550,  550,  551,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  547,

			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  542,
			  542,  548,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  552,  542,  542,
			  542,  542,  544,  542,  544,  542,  544,  544,  544,  544,
			  544,  544,  544,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  542,  542,  552,  552,  542,  542,  542,  544,
			  544,  544,  544,  542,  544,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  542,  542,  544,  542,  544,  542,  544,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,

			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  542,
			  544,  544,  544,  542,  542,  542,  542,  542,  542,  542,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  544,  544,  544,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,

			  547,  547,  547,  547,  547,  547,  547,  547,  544,  544,
			  544,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  547,  547,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  544,  542,  542,  542,  542,  542,  547,  547,
			  547,  542,    0,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542>>)
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
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   20,
			   21,   21,   21,   21,   21,   21,   21,   21,   22,   23,
			   24,   25,   26,   27,   28,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,
			   44,   45,   46,   47,   48,   49,   50,   51,   52,   53,
			   54,   55,   56,   57,   58,   59,   60,   61,   62,   63,

			   64,   65,   66,   67,   68,   69,   70,   71,   72,   73,
			   74,   75,   76,   77,   78,   79,   80,   81,   82,   83,
			   84,   85,   86,   87,   88,   89,   90,    1,    1,    1,
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
			    0,    1,    1,    2,    1,    3,    3,    3,    3,    4,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    5,    6,    3,    3,    3,    3,    3,    3,    3,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    7,    8,    9,   10,   11,    3,    3,    3,    3,   12,
			    3,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,   13,   14,   15,   16,   17,    3,    3,    3,
			    3>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,  188,  186,    2,    3,   33,
			  158,   38,   12,  135,   21,   22,   29,   27,    6,   28,
			   11,   30,  107,  107,    5,    4,   16,   15,   17,    8,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,   25,
			  186,   26,   31,   23,   24,    9,  159,  185,  183,  184,
			    2,    3,  158,  156,  158,  158,  158,  158,  158,  158,
			  158,  158,  158,  158,  158,  158,  158,  158,   38,  135,
			  135,  135,    1,   32,    7,  110,   36,   20,  110,  107,
			  107,  106,    0,   13,   34,   18,   19,   35,   14,  105,

			  105,  105,   42,  105,  105,  105,  105,  105,  105,  105,
			   51,  105,  105,  105,  105,  105,  105,   63,  105,  105,
			   70,  105,  105,  105,  105,  105,  105,   78,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,   37,
			   10,  159,  183,    0,  176,  174,  175,  177,  178,    0,
			  179,  180,  160,  161,  162,  163,  164,  165,  166,  167,
			  168,  169,  170,  171,  172,  173,  157,  155,  143,  141,
			  142,  144,  158,  137,  158,  138,  158,  158,  158,  158,
			  158,  158,  158,  145,  135,  111,  135,  135,  135,  135,
			  135,  135,  135,  135,  135,  135,  135,  135,  135,  135,

			  135,  135,  135,  135,  135,  135,  135,  135,  112,  110,
			    0,  108,  110,    0,  107,  107,    0,  105,   40,   41,
			   43,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,   54,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,   74,
			  105,   76,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,   97,  182,    0,    0,  155,  146,  139,  140,  158,
			  158,  158,  158,  152,  158,  147,  129,  127,  128,  130,
			  131,  136,  132,  133,  113,  114,  115,  116,  117,  118,

			  119,  120,  121,  122,  123,  124,  125,  126,  110,    0,
			  110,  110,    0,    0,  110,  107,  107,    0,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,   52,  105,
			  105,  105,  105,  105,  105,   61,  105,  105,  105,  105,
			  105,  105,  105,  105,   71,  105,   73,  102,  105,   77,
			  105,  105,  105,  104,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,   90,   91,  105,  105,  105,  105,   96,
			  181,    0,  158,  148,  158,  151,  158,  154,  136,  110,
			    0,  110,    0,  110,  110,  109,   39,  105,  105,   44,
			   45,  105,  105,   49,  105,  105,  105,  105,  105,  105,

			  105,   59,  105,  105,  105,  105,   66,  105,  105,  105,
			  105,   72,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,   86,  105,  105,   89,  105,  105,   94,  105,    0,
			  158,  158,  158,  134,    0,  110,  110,    0,    0,  110,
			  105,  105,   46,  105,  105,  105,  100,   53,   55,  105,
			   57,  105,  105,   62,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,   80,  105,   82,  105,   84,   85,   87,
			  105,  105,   93,  105,  158,  158,  158,    0,  110,  110,
			    0,    0,  110,    0,  110,    0,   98,  105,  105,   48,
			  105,  105,  105,   60,   64,  105,   67,   68,  101,  105,

			  105,  103,  105,  105,   83,  105,  105,   95,  158,  158,
			  158,  110,    0,  110,    0,  110,  110,    0,    0,  110,
			  105,   47,   50,   56,   58,   65,  105,   75,  105,   81,
			   88,   92,  158,  150,  153,  110,    0,  110,   99,   69,
			   79,  149,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1200
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 542
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 543
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

	yyNb_rules: INTEGER is 187
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 188
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
