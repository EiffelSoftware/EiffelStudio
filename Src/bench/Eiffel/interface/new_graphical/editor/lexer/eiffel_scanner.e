indexing

	description:

		"Scanners for Eiffel parsers"

	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1998, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

class EIFFEL_SCANNER

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton,
			reset as reset_compressed_scanner_skeleton
		end

	EIFFEL_TOKENS
		export
			{NONE} all
		end

	UT_CHARACTER_CODES
		export
			{NONE} all
		end

	KL_IMPORTED_INTEGER_ROUTINES
	KL_IMPORTED_STRING_ROUTINES
	KL_SHARED_PLATFORM
	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS

creation
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
if yy_act <= 59 then
if yy_act <= 30 then
if yy_act <= 15 then
if yy_act <= 8 then
if yy_act <= 4 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 50
-- Ignore carriage return
else
--|#line 51

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 3 then
--|#line 55

					create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					analysed_tokens.extend(curr_token)
					
else
--|#line 59
-- Do nothing. It's an error since we are only analysing lines
end
end
else
if yy_act <= 6 then
if yy_act = 5 then
--|#line 64
 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 72

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 7 then
--|#line 73

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 74

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
end
end
else
if yy_act <= 12 then
if yy_act <= 10 then
if yy_act = 9 then
--|#line 75

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 76

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 11 then
--|#line 77

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 78

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
end
else
if yy_act <= 14 then
if yy_act = 13 then
--|#line 79

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 80

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
--|#line 81

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
end
end
else
if yy_act <= 23 then
if yy_act <= 19 then
if yy_act <= 17 then
if yy_act = 16 then
--|#line 82

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 83

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 18 then
--|#line 89
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 97

										-- Create/Creation keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 21 then
if yy_act = 20 then
--|#line 98

										-- Create/Creation keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 99

										-- Create/Creation keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 22 then
--|#line 105

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 106

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
end
else
if yy_act <= 27 then
if yy_act <= 25 then
if yy_act = 24 then
--|#line 107

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 108

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 26 then
--|#line 109

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 110

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 29 then
if yy_act = 28 then
--|#line 111

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 112

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
--|#line 113

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
end
end
else
if yy_act <= 45 then
if yy_act <= 38 then
if yy_act <= 34 then
if yy_act <= 32 then
if yy_act = 31 then
--|#line 114

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 115

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 33 then
--|#line 116

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 117

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 36 then
if yy_act = 35 then
--|#line 118

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 119

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 37 then
--|#line 120

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 121

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
end
else
if yy_act <= 42 then
if yy_act <= 40 then
if yy_act = 39 then
--|#line 122

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 123

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 41 then
--|#line 124

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 125

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 44 then
if yy_act = 43 then
--|#line 126

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 127

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
--|#line 133

										is_operator := True
										-- infix Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
end
else
if yy_act <= 52 then
if yy_act <= 49 then
if yy_act <= 47 then
if yy_act = 46 then
--|#line 139

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 140

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 48 then
--|#line 141

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 142

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 51 then
if yy_act = 50 then
--|#line 143

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 144

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
--|#line 145

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 56 then
if yy_act <= 54 then
if yy_act = 53 then
--|#line 146

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 147

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 55 then
--|#line 148

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 149

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 58 then
if yy_act = 57 then
--|#line 150

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 151

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
--|#line 157

										is_operator := True
										-- Prefix Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
end
end
end
else
if yy_act <= 89 then
if yy_act <= 74 then
if yy_act <= 67 then
if yy_act <= 63 then
if yy_act <= 61 then
if yy_act = 60 then
--|#line 163

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 164

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 62 then
--|#line 165

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 166

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 65 then
if yy_act = 64 then
--|#line 167

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 168

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 66 then
--|#line 169

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 170

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
end
else
if yy_act <= 71 then
if yy_act <= 69 then
if yy_act = 68 then
--|#line 171

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 172

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 70 then
--|#line 173

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 174

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 73 then
if yy_act = 72 then
--|#line 175

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 176

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
--|#line 177

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
end
else
if yy_act <= 82 then
if yy_act <= 78 then
if yy_act <= 76 then
if yy_act = 75 then
--|#line 178

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 179

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
else
if yy_act = 77 then
--|#line 188

										create {EDITOR_TOKEN_TEXT} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
else
--|#line 196

										create {EDITOR_TOKEN_TEXT} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										
end
end
else
if yy_act <= 80 then
if yy_act = 79 then
--|#line 206

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 207

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 81 then
--|#line 208

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 209

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
end
end
else
if yy_act <= 86 then
if yy_act <= 84 then
if yy_act = 83 then
--|#line 210

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 211

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 85 then
--|#line 212

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 213

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
end
else
if yy_act <= 88 then
if yy_act = 87 then
--|#line 214

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 215

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
--|#line 216

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
end
end
end
else
if yy_act <= 104 then
if yy_act <= 97 then
if yy_act <= 93 then
if yy_act <= 91 then
if yy_act = 90 then
--|#line 217

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 218

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 92 then
--|#line 219

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 220

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
end
else
if yy_act <= 95 then
if yy_act = 94 then
--|#line 221

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 222

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 96 then
--|#line 223

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 224

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
end
end
else
if yy_act <= 101 then
if yy_act <= 99 then
if yy_act = 98 then
--|#line 225

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 226

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 100 then
--|#line 227

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 232

					code_ := text_substring (4, text_count - 2).to_integer
					if code_ > Platform.Maximum_character_code then
						-- Character error. Consedered as text.
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					end
					analysed_tokens.extend(curr_token)
					
end
end
else
if yy_act <= 103 then
if yy_act = 102 then
--|#line 243

					-- Character error. Catch-all rules (no backing up)
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 244

					-- Character error. Catch-all rules (no backing up)
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
--|#line 253

					-- Eiffel String
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
end
end
else
if yy_act <= 111 then
if yy_act <= 108 then
if yy_act <= 106 then
if yy_act = 105 then
--|#line 254

					-- Eiffel String
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 255

					-- Eiffel String
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
end
else
if yy_act = 107 then
--|#line 263

					-- Eiffel Bit
					create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					
else
--|#line 271

						-- Eiffel Integer
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						
end
end
else
if yy_act <= 110 then
if yy_act = 109 then
--|#line 272

						-- Eiffel Integer
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						
else
--|#line 277

						-- Eiffel Integer Error (considered as text)
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						
end
else
	yy_position := yy_position - 1
--|#line 285

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						
end
end
else
if yy_act <= 115 then
if yy_act <= 113 then
if yy_act = 112 then
--|#line 286

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						
else
--|#line 287

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						
end
else
if yy_act = 114 then
	yy_position := yy_position - 1
--|#line 288

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						
else
--|#line 289

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						
end
end
else
if yy_act <= 117 then
if yy_act = 116 then
--|#line 290

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						
else
--|#line 303

					-- Error (considered as text)
				create {EDITOR_TOKEN_TEXT} curr_token.make(text)
				analysed_tokens.extend(curr_token)
				
end
else
--|#line 0
echo
end
end
end
end
end
end
		end

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 0
terminate
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
			    0,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   17,   27,   28,   29,   30,
			   31,   32,   33,   34,   35,   35,   36,   35,   35,   37,
			   35,   38,   39,   40,   35,   41,   42,   43,   44,   45,
			   46,   47,   35,   35,   48,   49,   50,   17,   51,   29,
			   30,   31,   32,   34,   35,   37,   38,   35,   41,   42,
			   43,   44,   45,   52,   53,   60,   66,   67,   61,   68,
			   69,   69,   70,   70,   69,   69,  104,   69,   69,   71,
			  112,   72,   73,   71,   85,   73,   73,   69,   69,   97,

			   74,   87,  311,   88,   86,   98,  106,   81,   77,  104,
			   78,   82,  320,   89,  337,   79,  111,   83,  338,  112,
			   84,  107,   90,  199,  199,  110,   91,   87,   88,   75,
			  331,   74,  311,   75,   77,   78,   81,   82,   79,   92,
			   83,   93,  320,   84,  107,  100,  108,  111,   94,   95,
			  110,  114,  114,   90,   96,  101,  109,  102,  143,  143,
			   60,  103,   92,   61,   60,   60,  283,   61,   61,   79,
			  144,   93,  147,  147,   95,  108,  100,   96,  161,  109,
			  266,  101,  102,  276,  103,  139,  139,  419,  148,  114,
			  117,  149,   79,  118,  119,  120,  121,  140,   71,  418,

			  146,  146,  122,  149,  161,  266,  151,  123,  162,  124,
			  114,  125,  126,  127,  128,  417,  129,  149,  130,  153,
			  156,  154,  131,  141,  132,  155,  157,  133,  134,  135,
			  136,  137,  138,   71,  149,  145,  146,  151,   75,  162,
			  173,  158,  153,  156,   74,  159,  174,  171,  175,  160,
			  176,  416,  154,  185,  415,  155,  165,  157,  166,  172,
			  167,  187,  228,  173,  158,  413,  183,  178,  191,  174,
			  184,  168,  160,   75,  169,   74,  185,  179,  171,  175,
			  180,  176,  181,  182,  187,  188,  193,  165,  166,  167,
			  189,  191,  183,  228,  168,  114,  114,  169,  178,  216,

			  216,  190,  179,  180,  394,  181,  182,  230,  217,  193,
			  217,  140,  385,  218,  218,  229,  188,  219,  219,  220,
			  220,  223,  231,  223,  190,  232,  224,  224,  227,  227,
			  230,  221,   71,  114,  225,  226,   71,  141,  226,  226,
			  233,  236,  237,   74,  240,  241,  229,  242,  232,  244,
			  249,  251,  255,  231,  259,  256,  238,  222,  258,  264,
			  243,  260,  272,  233,  236,  262,  114,  240,  241,  383,
			  269,  382,   75,  237,   74,  244,   75,  259,  286,  261,
			  380,  249,  251,  255,  364,  256,  363,  272,  262,  258,
			  264,  359,  260,  269,  273,  199,  199,  274,  274,  218,

			  218,  286,  261,  275,  275,  277,  277,  278,  278,  140,
			  279,  288,  279,  281,  281,  280,  280,  224,  224,  221,
			  282,  282,  284,  289,  225,  226,  284,  292,  226,  226,
			  285,  285,  294,   74,  288,  141,  295,  296,  326,  326,
			  297,  276,  299,  307,  304,  222,  289,  306,  308,  309,
			  292,  315,  314,  317,  357,  294,  318,  321,  283,  322,
			  296,  295,  114,  297,   74,  299,  114,  304,  114,  307,
			  306,  323,  309,  356,  308,  314,  276,  315,  355,  318,
			  321,  274,  274,  341,  317,  322,  327,  327,  328,  328,
			  339,  329,  329,  325,  280,  280,  330,  330,  332,  332,

			  333,  333,  323,  221,  334,  334,  329,  329,  336,  340,
			  114,  114,  343,  341,  344,  339,  345,  346,  335,  347,
			  351,  362,  354,  358,  360,  365,  361,  367,  367,  222,
			  368,  368,  340,  384,  331,  369,  353,  344,  283,  352,
			  346,  345,  350,  343,  347,  354,  358,  360,   75,  361,
			  365,  351,  362,  366,  349,  366,  329,  329,  367,  367,
			  381,  141,  371,  371,  384,  276,  372,  372,  370,  373,
			  373,  374,  374,  375,  375,  376,  386,  376,  378,  378,
			  374,  374,  387,  381,  390,  388,  348,  389,  391,  392,
			  379,  393,  342,  396,  395,  404,  397,  367,  367,  386,

			  331,  367,  367,  398,  398,  402,  402,  387,  388,  283,
			  389,  391,  392,  403,  403,  390,  393,  395,  396,  397,
			  399,  222,  399,  374,  374,  400,  400,  401,  409,  401,
			  405,  405,  402,  402,  374,  374,  406,  406,  410,  407,
			  411,  407,  412,  331,  408,  408,  324,  414,  404,  400,
			  400,  420,  420,  409,  402,  402,  402,  402,  421,  421,
			  422,  425,  422,  373,  373,  423,  423,  426,  412,  410,
			  319,  411,  414,  316,  222,  404,  408,  408,  424,  424,
			  398,  398,  423,  423,  425,  427,  427,  405,  405,  276,
			  426,  421,  421,   76,   76,   76,   76,  313,  312,   59,

			   59,  222,   59,   59,   59,   59,   59,   59,   59,   59,
			  310,  305,  303,  302,  301,  300,  283,  298,  276,  293,
			  291,  290,  287,  331,   62,  283,  271,  270,  268,  331,
			   62,   62,   62,   62,   62,   63,   63,  267,   63,   63,
			   63,   63,   63,   63,   63,   63,   65,   65,  265,   65,
			   65,   65,   65,   65,   65,   65,   65,  115,  115,  263,
			  115,  115,  115,  115,  115,  115,  115,  115,   68,   68,
			  257,   68,   68,   68,   68,   68,   68,   68,   68,  142,
			  142,  142,  142,  142,  142,  254,  142,  142,  142,  142,
			  377,  377,  377,  377,  377,  377,  253,  377,  377,  377,

			  377,  252,  250,  248,  247,  246,  245,  239,  235,  234,
			  215,  214,  213,  212,  211,  210,  209,  208,  207,  206,
			  205,  204,  203,  202,  201,  200,  198,  197,  196,  195,
			  194,  192,  186,  177,  170,  164,  163,  152,  150,  116,
			   64,   64,   57,   56,   55,   54,   69,  113,  105,   99,
			   80,   69,   69,   64,   58,   57,   56,   55,   54,  428,
			    3,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,

			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428>>)
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
			    1,    1,    1,    1,    1,   10,   14,   14,   10,   19,
			   20,   21,   20,   20,   26,   26,   40,   21,   19,   22,
			   46,   22,   22,   23,   32,   23,   23,   27,   27,   37,

			   22,   33,  257,   33,   32,   37,   42,   31,   29,   40,
			   29,   31,  268,   33,  289,   29,   45,   31,  289,   46,
			   31,   42,   34,  122,  122,   44,   34,   33,   33,   22,
			  421,   22,  257,   23,   29,   29,   31,   31,   29,   34,
			   31,   36,  268,   31,   42,   39,   43,   45,   36,   36,
			   44,   51,   51,   34,   36,   39,   43,   39,   71,   71,
			   59,   39,   34,   59,   60,   61,  405,   60,   61,   80,
			   71,   36,   75,   75,   36,   43,   39,   36,   90,   43,
			  186,   39,   39,  398,   39,   70,   70,  396,   77,   51,
			   66,   77,   80,   66,   66,   66,   66,   70,   73,  395,

			   73,   73,   66,   78,   90,  186,   82,   66,   91,   66,
			   75,   66,   66,   66,   66,  393,   66,   77,   66,   84,
			   87,   85,   66,   70,   66,   85,   88,   66,   66,   66,
			   66,   66,   66,   72,   78,   72,   72,   82,   73,   91,
			   99,   88,   84,   87,   72,   89,  100,   98,  101,   89,
			  102,  392,   85,  107,  391,   85,   95,   88,   95,   98,
			   95,  109,  148,   99,   88,  387,  106,  105,  111,  100,
			  106,   95,   89,   72,   95,   72,  107,  105,   98,  101,
			  105,  102,  105,  105,  109,  110,  113,   95,   95,   95,
			  110,  111,  106,  148,   95,  114,  114,   95,  105,  139,

			  139,  110,  105,  105,  358,  105,  105,  151,  140,  113,
			  140,  139,  346,  140,  140,  150,  110,  141,  141,  143,
			  143,  144,  152,  144,  110,  153,  144,  144,  147,  147,
			  151,  143,  145,  114,  145,  145,  146,  139,  146,  146,
			  154,  158,  159,  145,  161,  162,  150,  163,  153,  164,
			  169,  171,  177,  152,  180,  177,  159,  143,  179,  184,
			  163,  181,  192,  154,  158,  182,  147,  161,  162,  343,
			  189,  340,  145,  159,  145,  164,  146,  180,  228,  181,
			  338,  169,  171,  177,  321,  177,  320,  192,  182,  179,
			  184,  314,  181,  189,  199,  199,  199,  216,  216,  217,

			  217,  228,  181,  218,  218,  219,  219,  220,  220,  216,
			  221,  230,  221,  222,  222,  221,  221,  223,  223,  220,
			  224,  224,  225,  231,  225,  225,  226,  234,  226,  226,
			  227,  227,  236,  225,  230,  216,  237,  238,  275,  275,
			  239,  218,  241,  251,  247,  220,  231,  249,  253,  255,
			  234,  261,  260,  263,  312,  236,  264,  269,  224,  270,
			  238,  237,  225,  239,  225,  241,  226,  247,  227,  251,
			  249,  271,  255,  311,  253,  260,  275,  261,  310,  264,
			  269,  274,  274,  293,  263,  270,  276,  276,  277,  277,
			  290,  278,  278,  274,  279,  279,  280,  280,  281,  281,

			  282,  282,  271,  278,  283,  283,  284,  284,  285,  292,
			  285,  285,  295,  293,  296,  290,  297,  299,  284,  300,
			  305,  318,  309,  313,  315,  323,  317,  326,  326,  278,
			  327,  327,  292,  345,  280,  328,  308,  296,  282,  306,
			  299,  297,  304,  295,  300,  309,  313,  315,  285,  317,
			  323,  305,  318,  325,  302,  325,  329,  329,  325,  325,
			  339,  328,  330,  330,  345,  326,  331,  331,  329,  332,
			  332,  333,  333,  334,  334,  335,  348,  335,  336,  336,
			  335,  335,  349,  339,  352,  350,  301,  351,  353,  354,
			  336,  356,  294,  363,  362,  373,  365,  366,  366,  348,

			  330,  367,  367,  368,  368,  371,  371,  349,  350,  333,
			  351,  353,  354,  372,  372,  352,  356,  362,  363,  365,
			  369,  373,  369,  374,  374,  369,  369,  370,  380,  370,
			  375,  375,  370,  370,  376,  376,  378,  378,  382,  379,
			  383,  379,  384,  371,  379,  379,  273,  390,  378,  399,
			  399,  400,  400,  380,  401,  401,  402,  402,  403,  403,
			  404,  414,  404,  406,  406,  404,  404,  416,  384,  382,
			  265,  383,  390,  262,  378,  406,  407,  407,  408,  408,
			  420,  420,  422,  422,  414,  423,  423,  424,  424,  400,
			  416,  427,  427,  433,  433,  433,  433,  259,  258,  429,

			  429,  406,  429,  429,  429,  429,  429,  429,  429,  429,
			  256,  248,  246,  245,  244,  243,  408,  240,  420,  235,
			  233,  232,  229,  423,  430,  424,  191,  190,  188,  427,
			  430,  430,  430,  430,  430,  431,  431,  187,  431,  431,
			  431,  431,  431,  431,  431,  431,  432,  432,  185,  432,
			  432,  432,  432,  432,  432,  432,  432,  434,  434,  183,
			  434,  434,  434,  434,  434,  434,  434,  434,  435,  435,
			  178,  435,  435,  435,  435,  435,  435,  435,  435,  436,
			  436,  436,  436,  436,  436,  176,  436,  436,  436,  436,
			  437,  437,  437,  437,  437,  437,  174,  437,  437,  437,

			  437,  172,  170,  168,  167,  166,  165,  160,  156,  155,
			  138,  137,  136,  135,  134,  133,  132,  131,  130,  129,
			  128,  127,  126,  125,  124,  123,  121,  120,  119,  118,
			  117,  112,  108,  104,   97,   94,   92,   83,   81,   65,
			   64,   63,   57,   56,   55,   54,   49,   47,   41,   38,
			   30,   28,   24,   13,    9,    8,    7,    6,    5,    3,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,

			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  859,  860,  856,  854,  852,  850,  848,
			   68,    0,  860,  846,   66,  860,  860,  860,  860,   62,
			   62,   62,   71,   75,  827,  860,   60,   72,  826,   69,
			  814,   72,   62,   62,   94,    0,  108,   63,  807,  116,
			   41,  816,   74,  111,   84,   88,   55,  805,  860,  791,
			  860,  131,  860,  860,  843,  841,  839,  837,  860,  153,
			  157,  158,    0,  834,  833,  828,  183,    0,    0,  860,
			  165,  138,  215,  180,  860,  152,    0,  152,  172,    0,
			  122,  806,  178,  805,  174,  192,    0,  174,  195,  202,
			  139,  180,  794,    0,  792,  225,    0,  796,  217,  193,

			  200,  217,  220,    0,  801,  236,  227,  208,  800,  213,
			  254,  223,  799,  241,  275,  860,  860,  819,  818,  817,
			  816,  815,  103,  814,  813,  812,  811,  810,  809,  808,
			  807,  806,  805,  804,  803,  802,  801,  800,  799,  279,
			  293,  297,  860,  299,  306,  314,  318,  308,  234,    0,
			  285,  261,  294,  280,  292,  777,  776,    0,  293,  314,
			  775,  298,  298,  307,  310,  774,  769,  772,  760,  322,
			  770,  323,  758,    0,  754,    0,  753,  322,  738,  330,
			  306,  331,  320,  727,  331,  712,  139,  705,  696,  326,
			  691,  690,  321,    0,  860,  860,  860,  860,  860,  375,

			  860,  860,  860,  860,  860,  860,  860,  860,  860,  860,
			  860,  860,  860,  860,  860,  860,  377,  379,  383,  385,
			  387,  395,  393,  397,  400,  404,  408,  410,  332,  684,
			  365,  376,  689,  686,  382,  683,  387,  395,  392,  395,
			  685,  394,    0,  683,  678,  662,  661,  399,  679,  402,
			    0,  404,    0,  409,    0,  401,  674,   69,  658,  661,
			  404,  412,  621,  423,  411,  627,    0,    0,   79,  409,
			  420,  443,    0,  635,  461,  418,  466,  468,  471,  474,
			  476,  478,  480,  484,  486,  490,    0,    0,    0,   82,
			  449,    0,  464,  450,  560,  481,  467,  475,    0,  472,

			  478,  554,  518,    0,  506,  490,  503,    0,  504,  477,
			  427,  437,  422,  478,  359,  477,    0,  479,  493,    0,
			  350,  352,    0,  484,  860,  538,  507,  510,  503,  536,
			  542,  546,  549,  551,  553,  560,  558,    0,  338,  513,
			  339,    0,    0,  337,    0,  505,  280,    0,  530,  541,
			  538,  540,  556,  541,  543,    0,  550,    0,  272,    0,
			    0,    0,  547,  552,    0,  549,  577,  581,  583,  605,
			  612,  585,  593,  563,  603,  610,  614,  860,  616,  624,
			  587,    0,  607,  609,  603,    0,    0,  231,    0,    0,
			  606,  222,  209,  183,    0,  167,  155,    0,  125,  629,

			  631,  634,  636,  638,  645,  108,  643,  656,  658,    0,
			    0,    0,    0,    0,  614,    0,  622,    0,    0,    0,
			  660,   72,  662,  665,  667,    0,    0,  671,  860,  698,
			  723,  734,  745,  685,  756,  767,  778,  789>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  428,    1,  428,  428,  428,  428,  428,  428,  428,
			  429,  430,  428,  431,  432,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  429,
			  429,  429,  430,  431,  431,  434,  434,  434,  435,  428,
			  428,  436,  428,  428,  428,  428,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,

			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  428,  428,  428,  428,  428,  428,

			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  436,  428,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,

			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  437,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  428,  428,

			  428,  428,  428,  428,  428,  428,  428,  428,  428,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  428,  428,  428,  428,  428,  433,  433,  428,    0,  428,
			  428,  428,  428,  428,  428,  428,  428,  428>>)
		end

	yy_ec_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   20,
			   21,   21,   21,   21,   21,   21,   21,   21,   22,   23,
			   24,   25,   26,   27,    8,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   40,   41,   42,
			   43,   44,   45,   46,   47,   48,   49,   50,   51,   52,
			   53,   54,   55,   56,   57,   58,    1,   59,   60,   61,

			   62,   32,   63,   34,   64,   36,   37,   38,   65,   40,
			   66,   42,   43,   67,   68,   69,   70,   71,   72,   50,
			   51,   52,   53,   73,    8,   74,    1,    1,    1,    1,
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
			    0,    1,    2,    3,    2,    4,    1,    5,    1,    1,
			    6,    1,    1,    1,    1,    1,    1,    1,    7,    1,
			    8,    9,    1,    1,    1,    1,    1,    1,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,   10,    1,    1,    1,    1,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,   11,    1,    1>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  119,  117,    3,    4,    1,    2,   10,
			  117,   78,   17,  117,  117,   11,   12,   18,    8,   18,
			    6,   18,  108,  108,    9,    7,   18,   18,  117,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   15,  117,
			   16,  110,   13,   14,    3,    4,    1,    2,   19,    0,
			  104,  106,   78,    0,  105,  102,  102,  102,    5,   18,
			  113,    0,  108,  108,  107,  110,   77,   77,   77,   24,
			   77,   77,   77,   77,   77,   77,   30,   77,   77,   77,
			   77,   77,   77,   42,   77,   77,   49,   77,   77,   77,

			   77,   77,   77,   57,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,  110,  102,   79,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  113,
			    0,    0,  111,  113,  111,  108,  108,  110,   77,   23,
			   77,   77,   77,   77,   77,   77,   77,   33,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   53,   77,   55,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   76,   96,   94,   95,   97,   98,  103,

			   99,  100,   80,   81,   82,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,  113,    0,  113,    0,
			  113,    0,    0,    0,  112,  108,  108,  110,   77,   77,
			   77,   77,   77,   77,   77,   31,   77,   77,   77,   77,
			   77,   77,   40,   77,   77,   77,   77,   77,   77,   77,
			   50,   77,   52,   77,   56,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   69,   70,   77,   77,
			   77,   77,   75,  103,  113,  113,    0,    0,  113,    0,
			  112,    0,  112,    0,    0,  109,   22,   25,   26,   77,
			   77,   28,   77,   77,   77,   77,   77,   77,   38,   77,

			   77,   77,   77,   45,   77,   77,   77,   51,   77,   77,
			   77,   77,   77,   77,   77,   77,   65,   77,   77,   68,
			   77,   77,   73,   77,  101,    0,  113,    0,  116,  113,
			  112,    0,    0,  112,    0,  111,    0,   21,   77,   77,
			   77,   32,   34,   77,   36,   77,   77,   41,   77,   77,
			   77,   77,   77,   77,   77,   59,   77,   61,   77,   63,
			   64,   66,   77,   77,   72,   77,    0,  113,    0,    0,
			    0,  112,    0,  116,  112,    0,    0,  114,  116,  114,
			   77,   27,   77,   77,   77,   39,   43,   77,   46,   47,
			   77,   77,   77,   77,   62,   77,   77,   74,  116,    0,

			  116,    0,  112,    0,    0,  115,  116,    0,  115,   20,
			   29,   35,   37,   44,   77,   54,   77,   60,   67,   71,
			  116,  115,    0,  115,  115,   48,   58,  115,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 860
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 428
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 429
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

	yyNb_rules: INTEGER is 118
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 119
			-- End of buffer rule code

	INITIAL: INTEGER is 0
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Local variables

	i_, nb_: INTEGER
	char_: CHARACTER
	str_: STRING
	code_: INTEGER

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
			eif_buffer := STRING_.make (Init_buffer_size)
			eif_lineno := 1
		end

feature -- Start Job / Reinitialization 

	execute(a_string: STRING) is
			-- Analyze a string.
		do
			reset
			set_input_buffer (new_string_buffer(a_string))
			scan
		end

	reset is
			-- Reset scanner before scanning next input.
		do
			reset_compressed_scanner_skeleton
			eif_lineno := 1
			eif_buffer.wipe_out
			create analysed_tokens.make	-- create a new one, the old one
										-- is still "usable"
		end

feature -- Access

	curr_token: EDITOR_TOKEN

	analysed_tokens: EDITOR_LINE

	last_value: ANY
			-- Semantic value to be passed to the parser

	eif_buffer: STRING
			-- Buffer for lexial tokens

	eif_lineno: INTEGER
			-- Current line number

	is_operator: BOOLEAN
			-- Parsing an operator declaration?

feature {NONE} -- Processing

	process_operator (op: INTEGER): INTEGER is
			-- Process current token as operator `op' or as
			-- an Eiffel string depending on the context
		require
			text_count_large_enough: text_count > 2
		do
			if is_operator then
				is_operator := False
				Result := op
			else
				Result := E_STRING
				last_value := text_substring (2, text_count - 1)
			end
		end

feature {NONE} -- Constants

	Init_buffer_size: INTEGER is 80 
				-- Initial size for `eif_buffer'

invariant

	eif_buffer_not_void: eif_buffer /= Void

end -- class EIFFEL_SCANNER
