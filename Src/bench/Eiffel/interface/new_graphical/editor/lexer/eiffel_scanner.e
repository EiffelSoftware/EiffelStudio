indexing
	description:"Scanners for Eiffel parsers"
	author:     "Arnaud PICHERY from an Eric Bezault model"
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
if yy_act <= 67 then
if yy_act <= 34 then
if yy_act <= 17 then
if yy_act <= 9 then
if yy_act <= 5 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 45
-- Ignore carriage return
else
--|#line 46

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					
end
else
--|#line 50

					create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					update_token_list
					
end
else
if yy_act = 4 then
--|#line 54

					from i := 1 until i > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i := i + 1
					end
					
else
--|#line 65
 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					update_token_list
					
end
end
else
if yy_act <= 7 then
if yy_act = 6 then
--|#line 73

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
else
--|#line 74

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 8 then
--|#line 75

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
else
--|#line 76

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
end
end
end
else
if yy_act <= 13 then
if yy_act <= 11 then
if yy_act = 10 then
--|#line 77

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
else
--|#line 78

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 12 then
--|#line 79

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
else
--|#line 80

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
end
end
else
if yy_act <= 15 then
if yy_act = 14 then
--|#line 81

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
else
--|#line 82

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 16 then
--|#line 83

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
else
--|#line 84

						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
end
end
end
end
else
if yy_act <= 26 then
if yy_act <= 22 then
if yy_act <= 20 then
if yy_act <= 19 then
if yy_act = 18 then
--|#line 90
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
else
--|#line 91
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
else
--|#line 92
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 21 then
--|#line 93
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
else
--|#line 94
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
end
else
if yy_act <= 24 then
if yy_act = 23 then
--|#line 95
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
else
--|#line 96
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 25 then
--|#line 97
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
else
--|#line 98
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
end
end
else
if yy_act <= 30 then
if yy_act <= 28 then
if yy_act = 27 then
--|#line 99
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
else
--|#line 100
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 29 then
--|#line 101
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
else
--|#line 102
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
end
else
if yy_act <= 32 then
if yy_act = 31 then
--|#line 103
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
else
--|#line 104
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 33 then
--|#line 105
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
else
--|#line 106
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
end
end
end
end
else
if yy_act <= 51 then
if yy_act <= 43 then
if yy_act <= 39 then
if yy_act <= 37 then
if yy_act <= 36 then
if yy_act = 35 then
--|#line 107
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
else
--|#line 108
 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					update_token_list
					
end
else
--|#line 116

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 38 then
--|#line 117

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 118

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
else
if yy_act <= 41 then
if yy_act = 40 then
--|#line 119

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 120

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 42 then
--|#line 121

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 122

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
end
else
if yy_act <= 47 then
if yy_act <= 45 then
if yy_act = 44 then
--|#line 123

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 124

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 46 then
--|#line 125

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 126

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
else
if yy_act <= 49 then
if yy_act = 48 then
--|#line 127

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 128

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 50 then
--|#line 129

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 130

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
end
end
else
if yy_act <= 59 then
if yy_act <= 55 then
if yy_act <= 53 then
if yy_act = 52 then
--|#line 131

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 132

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 54 then
--|#line 133

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 134

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
else
if yy_act <= 57 then
if yy_act = 56 then
--|#line 135

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 136

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 58 then
--|#line 137

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 138

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
end
else
if yy_act <= 63 then
if yy_act <= 61 then
if yy_act = 60 then
--|#line 139

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 140

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 62 then
--|#line 141

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 142

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
else
if yy_act <= 65 then
if yy_act = 64 then
--|#line 143

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 144

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 66 then
--|#line 145

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 146

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
end
end
end
end
else
if yy_act <= 101 then
if yy_act <= 84 then
if yy_act <= 76 then
if yy_act <= 72 then
if yy_act <= 70 then
if yy_act <= 69 then
if yy_act = 68 then
--|#line 147

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 148

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
--|#line 149

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 71 then
--|#line 150

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 151

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
else
if yy_act <= 74 then
if yy_act = 73 then
--|#line 152

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 153

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 75 then
--|#line 154

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 155

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
end
else
if yy_act <= 80 then
if yy_act <= 78 then
if yy_act = 77 then
--|#line 156

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 157

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 79 then
--|#line 158

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 159

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
else
if yy_act <= 82 then
if yy_act = 81 then
--|#line 160

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 161

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 83 then
--|#line 162

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 163

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
end
end
else
if yy_act <= 93 then
if yy_act <= 89 then
if yy_act <= 87 then
if yy_act <= 86 then
if yy_act = 85 then
--|#line 164

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 165

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
--|#line 166

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 88 then
--|#line 167

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 168

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
end
else
if yy_act <= 91 then
if yy_act = 90 then
--|#line 169

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 170

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
end
else
if yy_act = 92 then
--|#line 171

										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										update_token_list
										
else
--|#line 180

										create {EDITOR_TOKEN_TEXT} curr_token.make(text)
										update_token_list
										
end
end
end
else
if yy_act <= 97 then
if yy_act <= 95 then
if yy_act = 94 then
--|#line 188

										create {EDITOR_TOKEN_TEXT} curr_token.make(text)
										update_token_list
										
else
--|#line 198

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 96 then
--|#line 199

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 200

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
end
else
if yy_act <= 99 then
if yy_act = 98 then
--|#line 201

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 202

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 100 then
--|#line 203

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 204

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
end
end
end
end
else
if yy_act <= 118 then
if yy_act <= 110 then
if yy_act <= 106 then
if yy_act <= 104 then
if yy_act <= 103 then
if yy_act = 102 then
--|#line 205

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 206

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
else
--|#line 207

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 105 then
--|#line 208

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 209

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
end
else
if yy_act <= 108 then
if yy_act = 107 then
--|#line 210

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 211

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 109 then
--|#line 212

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 213

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
end
end
else
if yy_act <= 114 then
if yy_act <= 112 then
if yy_act = 111 then
--|#line 214

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 215

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 113 then
--|#line 216

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 217

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
end
else
if yy_act <= 116 then
if yy_act = 115 then
--|#line 218

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
else
--|#line 219

					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 117 then
--|#line 224

					code_ := text_substring (4, text_count - 2).to_integer
					if code_ > Platform.Maximum_character_code then
						-- Character error. Consedered as text.
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 235

					-- Character error. Catch-all rules (no backing up)
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
end
end
end
end
else
if yy_act <= 126 then
if yy_act <= 122 then
if yy_act <= 120 then
if yy_act = 119 then
--|#line 236

					-- Character error. Catch-all rules (no backing up)
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
else
--|#line 245

					-- Eiffel String
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 121 then
--|#line 246

					-- Eiffel String
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					update_token_list
					
else
--|#line 247

					-- Eiffel String
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					update_token_list
					
end
end
else
if yy_act <= 124 then
if yy_act = 123 then
--|#line 255

					-- Eiffel Bit
					create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
					update_token_list
					
else
--|#line 263

						-- Eiffel Integer
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						update_token_list
						
end
else
if yy_act = 125 then
--|#line 264

						-- Eiffel Integer
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						update_token_list
						
else
--|#line 269

						-- Eiffel Integer Error (considered as text)
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						update_token_list
						
end
end
end
else
if yy_act <= 130 then
if yy_act <= 128 then
if yy_act = 127 then
	yy_position := yy_position - 1
--|#line 277

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						update_token_list
						
else
--|#line 278

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						update_token_list
						
end
else
if yy_act = 129 then
--|#line 279

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						update_token_list
						
else
	yy_position := yy_position - 1
--|#line 280

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						update_token_list
						
end
end
else
if yy_act <= 132 then
if yy_act = 131 then
--|#line 281

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						update_token_list
						
else
--|#line 282

							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						update_token_list
						
end
else
if yy_act = 133 then
--|#line 295

					-- Error (considered as text)
				create {EDITOR_TOKEN_TEXT} curr_token.make(text)
				update_token_list
				
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
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   37,   38,   37,   37,   39,
			   37,   40,   41,   42,   37,   43,   44,   45,   46,   47,
			   48,   49,   37,   37,   50,   51,   52,   53,   54,   31,
			   32,   33,   34,   36,   37,   39,   40,   37,   43,   44,
			   45,   46,   47,   55,   56,   63,   69,   70,   64,   71,
			   73,   75,   74,   74,   83,   84,  116,   76,   72,   77,
			  124,   78,   79,   77,   97,   79,   79,   85,   86,  109,

			   80,   99,  319,  100,   98,  110,  118,   93,   89,  116,
			   90,   94,  328,  101,  345,   91,  123,   95,  346,  124,
			   96,  119,  102,  211,  211,  122,  103,   99,  100,   81,
			  339,   80,  319,   81,   89,   90,   93,   94,   91,  104,
			   95,  105,  328,   96,  119,  112,  120,  123,  106,  107,
			  122,  127,  127,  102,  108,  113,  121,  114,  156,  156,
			   63,  115,  104,   64,   63,   63,  293,   64,   64,   91,
			  157,  105,  160,  160,  107,  120,  112,  108,  174,  121,
			  276,  113,  114,  286,  115,  152,  152,  426,  161,  127,
			  130,  162,   91,  131,  132,  133,  134,  153,   77,  425,

			  159,  159,  135,  162,  174,  276,  164,  136,  175,  137,
			  127,  138,  139,  140,  141,  424,  142,  162,  143,  166,
			  169,  167,  144,  154,  145,  168,  170,  146,  147,  148,
			  149,  150,  151,   77,  162,  158,  159,  164,   81,  175,
			  185,  171,  166,  169,   80,  172,  183,  178,  186,  173,
			  187,  179,  167,  188,  423,  168,  195,  170,  184,  422,
			  196,  420,  180,  185,  171,  181,  401,  197,  127,  127,
			  199,  186,  173,   81,  203,   80,  190,  183,  178,  205,
			  179,  187,  195,  392,  188,  180,  191,  240,  181,  192,
			  197,  193,  194,  199,  200,  231,  231,  203,   77,  201,

			  238,  238,  205,  390,  228,  228,  127,  190,  232,  232,
			  202,  191,  192,  241,  193,  194,  153,  229,  240,  229,
			  233,  243,  230,  230,  235,  200,  235,  239,  239,  236,
			  236,  242,   77,  202,  237,  238,  244,  245,   81,  248,
			  252,  253,  154,   80,  241,  254,  234,  249,  260,  256,
			  262,  266,  243,  268,  242,  270,  274,  269,  255,  244,
			  245,  250,  248,  252,  253,  127,  272,  279,  282,  283,
			  211,  211,   81,  271,   80,  256,  284,  284,  249,  260,
			  269,  262,  266,  389,  268,  387,  270,  274,  153,  272,
			  279,  230,  230,  282,  285,  285,  271,  287,  287,  288,

			  288,  289,  296,  289,  291,  291,  290,  290,  236,  236,
			  298,  233,  292,  292,  154,  294,  299,  237,  238,  294,
			  302,  238,  238,  295,  295,  296,   80,  305,  304,  371,
			  306,  307,  286,  298,  316,  309,  317,  234,  325,  299,
			  313,  315,  318,  302,  322,  323,  331,  326,  330,  329,
			  293,  304,  305,  306,  307,  127,  370,   80,  309,  127,
			  316,  127,  317,  313,  315,  318,  366,  322,  364,  325,
			  326,  323,  329,  363,  330,  284,  284,  331,  334,  334,
			  335,  335,  336,  336,  337,  337,  348,  333,  290,  290,
			  338,  338,  340,  340,  341,  341,  233,  342,  342,  337,

			  337,  344,  347,  127,  127,  349,  351,  352,  353,  348,
			  361,  343,  359,  354,  355,  362,  286,  365,  369,  367,
			  372,  368,  234,  374,  374,  375,  375,  347,  339,  376,
			  352,  360,  293,  353,  358,  349,  354,  351,  362,  355,
			  365,   81,  367,  359,  368,  372,  373,  391,  373,  369,
			  397,  374,  374,  337,  337,  154,  378,  378,  379,  379,
			  388,  286,  380,  380,  393,  377,  381,  381,  382,  382,
			  383,  394,  383,  385,  385,  381,  381,  395,  391,  396,
			  398,  397,  399,  388,  400,  386,  357,  393,  402,  403,
			  404,  374,  374,  416,  339,  417,  394,  374,  374,  356,

			  395,  411,  396,  398,  293,  399,  405,  405,  418,  400,
			  406,  402,  406,  404,  403,  407,  407,  408,  416,  408,
			  409,  409,  409,  409,  410,  410,  417,  234,  381,  381,
			  412,  412,  381,  381,  413,  413,  414,  419,  414,  418,
			  421,  415,  415,  407,  407,  350,  411,  427,  427,  409,
			  409,  409,  409,  428,  428,  429,  432,  429,  339,  433,
			  430,  430,  332,  419,  327,  421,  380,  380,  415,  415,
			  431,  431,  234,  405,  405,  430,  430,  324,  411,  432,
			  434,  434,  433,  412,  412,  286,  428,  428,   62,   62,
			  321,   62,   62,   62,   62,   62,   62,   62,   62,   88,

			   88,   88,   88,  320,  234,  314,   65,  312,  293,  311,
			  310,  286,   65,   65,   65,   65,   65,  308,  339,  303,
			  301,  293,   66,   66,  339,   66,   66,   66,   66,   66,
			   66,   66,   66,   68,   68,  300,   68,   68,   68,   68,
			   68,   68,   68,   68,  128,  128,  297,  128,  128,  128,
			  128,  128,  128,  128,  128,   71,   71,  281,   71,   71,
			   71,   71,   71,   71,   71,   71,  155,  155,  155,  155,
			  155,  155,  280,  155,  155,  155,  155,  384,  384,  384,
			  384,  384,  384,  278,  384,  384,  384,  384,  277,  275,
			  273,  267,  265,  264,  263,  261,  259,  258,  257,  251,

			  247,  246,  227,  226,  225,  224,  223,  222,  221,  220,
			  219,  218,  217,  216,  215,  214,  213,  212,  210,  209,
			  208,  207,  206,  204,  198,  189,  182,  177,  176,  165,
			  163,  129,   67,   67,   60,   59,   58,   57,  126,  125,
			  117,  111,   92,   87,   82,   67,   61,   60,   59,   58,
			   57,  435,    3,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,

			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435>>)
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
			    1,    1,    1,    1,    1,   10,   14,   14,   10,   20,
			   21,   22,   21,   21,   27,   27,   42,   22,   20,   23,
			   48,   23,   23,   24,   34,   24,   24,   29,   29,   39,

			   23,   35,  267,   35,   34,   39,   44,   33,   31,   42,
			   31,   33,  278,   35,  299,   31,   47,   33,  299,   48,
			   33,   44,   36,  135,  135,   46,   36,   35,   35,   23,
			  428,   23,  267,   24,   31,   31,   33,   33,   31,   36,
			   33,   38,  278,   33,   44,   41,   45,   47,   38,   38,
			   46,   54,   54,   36,   38,   41,   45,   41,   77,   77,
			   62,   41,   36,   62,   63,   64,  412,   63,   64,   92,
			   77,   38,   81,   81,   38,   45,   41,   38,  102,   45,
			  198,   41,   41,  405,   41,   74,   74,  403,   89,   54,
			   69,   89,   92,   69,   69,   69,   69,   74,   79,  402,

			   79,   79,   69,   90,  102,  198,   94,   69,  103,   69,
			   81,   69,   69,   69,   69,  400,   69,   89,   69,   96,
			   99,   97,   69,   74,   69,   97,  100,   69,   69,   69,
			   69,   69,   69,   78,   90,   78,   78,   94,   79,  103,
			  111,  100,   96,   99,   78,  101,  110,  107,  112,  101,
			  113,  107,   97,  114,  399,   97,  118,  100,  110,  398,
			  118,  394,  107,  111,  100,  107,  365,  119,  127,  127,
			  121,  112,  101,   78,  123,   78,  117,  110,  107,  125,
			  107,  113,  118,  354,  114,  107,  117,  161,  107,  117,
			  119,  117,  117,  121,  122,  154,  154,  123,  159,  122,

			  159,  159,  125,  351,  152,  152,  127,  117,  156,  156,
			  122,  117,  117,  163,  117,  117,  152,  153,  161,  153,
			  156,  165,  153,  153,  157,  122,  157,  160,  160,  157,
			  157,  164,  158,  122,  158,  158,  166,  167,  159,  171,
			  174,  175,  152,  158,  163,  176,  156,  172,  181,  177,
			  183,  189,  165,  191,  164,  193,  196,  192,  176,  166,
			  167,  172,  171,  174,  175,  160,  194,  201,  204,  211,
			  211,  211,  158,  193,  158,  177,  228,  228,  172,  181,
			  192,  183,  189,  348,  191,  346,  193,  196,  228,  194,
			  201,  229,  229,  204,  230,  230,  193,  231,  231,  232,

			  232,  233,  240,  233,  234,  234,  233,  233,  235,  235,
			  242,  232,  236,  236,  228,  237,  243,  237,  237,  238,
			  246,  238,  238,  239,  239,  240,  237,  249,  248,  329,
			  250,  251,  230,  242,  262,  253,  264,  232,  273,  243,
			  258,  260,  266,  246,  270,  271,  281,  274,  280,  279,
			  236,  248,  249,  250,  251,  237,  328,  237,  253,  238,
			  262,  239,  264,  258,  260,  266,  322,  270,  320,  273,
			  274,  271,  279,  319,  280,  284,  284,  281,  285,  285,
			  286,  286,  287,  287,  288,  288,  302,  284,  289,  289,
			  290,  290,  291,  291,  292,  292,  288,  293,  293,  294,

			  294,  295,  300,  295,  295,  303,  305,  306,  307,  302,
			  317,  294,  314,  309,  310,  318,  285,  321,  326,  323,
			  331,  325,  288,  334,  334,  335,  335,  300,  290,  336,
			  306,  315,  292,  307,  313,  303,  309,  305,  318,  310,
			  321,  295,  323,  314,  325,  331,  333,  353,  333,  326,
			  360,  333,  333,  337,  337,  336,  338,  338,  339,  339,
			  347,  334,  340,  340,  356,  337,  341,  341,  342,  342,
			  343,  357,  343,  344,  344,  343,  343,  358,  353,  359,
			  361,  360,  362,  347,  363,  344,  312,  356,  369,  370,
			  372,  373,  373,  387,  338,  389,  357,  374,  374,  311,

			  358,  380,  359,  361,  341,  362,  375,  375,  390,  363,
			  376,  369,  376,  372,  370,  376,  376,  377,  387,  377,
			  378,  378,  377,  377,  379,  379,  389,  380,  381,  381,
			  382,  382,  383,  383,  385,  385,  386,  391,  386,  390,
			  397,  386,  386,  406,  406,  304,  385,  407,  407,  408,
			  408,  409,  409,  410,  410,  411,  421,  411,  378,  423,
			  411,  411,  283,  391,  275,  397,  413,  413,  414,  414,
			  415,  415,  385,  427,  427,  429,  429,  272,  413,  421,
			  430,  430,  423,  431,  431,  407,  434,  434,  436,  436,
			  269,  436,  436,  436,  436,  436,  436,  436,  436,  440,

			  440,  440,  440,  268,  413,  259,  437,  257,  415,  256,
			  255,  427,  437,  437,  437,  437,  437,  252,  430,  247,
			  245,  431,  438,  438,  434,  438,  438,  438,  438,  438,
			  438,  438,  438,  439,  439,  244,  439,  439,  439,  439,
			  439,  439,  439,  439,  441,  441,  241,  441,  441,  441,
			  441,  441,  441,  441,  441,  442,  442,  203,  442,  442,
			  442,  442,  442,  442,  442,  442,  443,  443,  443,  443,
			  443,  443,  202,  443,  443,  443,  443,  444,  444,  444,
			  444,  444,  444,  200,  444,  444,  444,  444,  199,  197,
			  195,  190,  188,  186,  184,  182,  180,  179,  178,  173,

			  169,  168,  151,  150,  149,  148,  147,  146,  145,  144,
			  143,  142,  141,  140,  139,  138,  137,  136,  134,  133,
			  132,  131,  130,  124,  120,  116,  109,  106,  104,   95,
			   93,   68,   67,   66,   60,   59,   58,   57,   51,   49,
			   43,   40,   32,   30,   25,   13,    9,    8,    7,    6,
			    5,    3,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,

			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  851,  852,  848,  846,  844,  842,  840,
			   68,    0,  852,  838,   66,  852,  852,  852,  852,  852,
			   62,   62,   62,   71,   75,  819,  852,   60,  852,   72,
			  818,   69,  806,   72,   62,   62,   94,    0,  108,   63,
			  799,  116,   41,  808,   74,  111,   84,   88,   55,  797,
			  852,  783,  852,  852,  131,  852,  852,  835,  833,  831,
			  829,  852,  153,  157,  158,    0,  826,  825,  820,  183,
			    0,    0,  852,  852,  165,  852,  852,  138,  215,  180,
			  852,  152,  852,  852,  852,  852,  852,  852,    0,  152,
			  172,    0,  122,  798,  178,  797,  174,  192,    0,  174,

			  195,  202,  139,  180,  786,    0,  784,  216,    0,  788,
			  216,  193,  202,  219,  223,    0,  793,  245,  217,  222,
			  792,  222,  263,  229,  791,  234,  852,  248,  852,  852,
			  811,  810,  809,  808,  807,  103,  806,  805,  804,  803,
			  802,  801,  800,  799,  798,  797,  796,  795,  794,  793,
			  792,  791,  284,  302,  275,  852,  288,  309,  314,  280,
			  307,  259,    0,  283,  285,  293,  291,  289,  769,  768,
			    0,  291,  319,  767,  294,  294,  305,  310,  766,  765,
			  753,  320,  763,  322,  751,    0,  751,    0,  760,  321,
			  759,  325,  309,  325,  321,  758,  328,  753,  139,  756,

			  751,  323,  736,  721,  327,    0,  852,  852,  852,  852,
			  852,  350,  852,  852,  852,  852,  852,  852,  852,  852,
			  852,  852,  852,  852,  852,  852,  852,  852,  356,  371,
			  374,  377,  379,  386,  384,  388,  392,  397,  401,  403,
			  356,  708,  364,  369,  703,  686,  375,  683,  383,  386,
			  385,  386,  685,  387,    0,  678,  673,  656,  395,  673,
			  396,    0,  395,    0,  397,    0,  394,   69,  663,  654,
			  396,  406,  625,  408,  402,  621,    0,    0,   79,  401,
			  409,  418,    0,  651,  455,  458,  460,  462,  464,  468,
			  470,  472,  474,  477,  479,  483,    0,    0,    0,   82,

			  461,    0,  441,  472,  613,  475,  460,  467,    0,  468,
			  473,  567,  550,  498,  482,  495,    0,  478,  470,  437,
			  436,  472,  434,  472,    0,  474,  490,    0,  420,  397,
			    0,  479,  852,  531,  503,  505,  497,  533,  536,  538,
			  542,  546,  548,  555,  553,    0,  343,  513,  351,    0,
			    0,  271,    0,  519,  251,    0,  518,  530,  530,  532,
			  522,  533,  536,  543,    0,  234,    0,    0,    0,  541,
			  548,    0,  543,  571,  577,  586,  595,  602,  600,  604,
			  569,  608,  610,  612,  852,  614,  621,  552,    0,  564,
			  577,  598,    0,    0,  227,    0,    0,  599,  227,  212,

			  183,    0,  167,  155,    0,  125,  623,  627,  629,  631,
			  633,  640,  108,  646,  648,  650,    0,    0,    0,    0,
			    0,  609,    0,  614,    0,    0,    0,  653,   72,  655,
			  660,  663,    0,    0,  666,  852,  687,  705,  721,  732,
			  691,  743,  754,  765,  776>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  435,    1,  435,  435,  435,  435,  435,  435,  435,
			  436,  437,  435,  438,  439,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  436,  436,  436,  437,  438,  438,  441,  441,
			  441,  442,  435,  435,  435,  435,  435,  443,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,

			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,

			  440,  440,  440,  440,  440,  440,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  443,  435,  440,  440,  440,  440,

			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  444,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,

			  440,  440,  440,  440,  440,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  435,  435,  435,
			  435,  435,  440,  440,  435,    0,  435,  435,  435,  435,
			  435,  435,  435,  435,  435>>)
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
			    0,    0,    0,  135,  133,    3,    4,    1,    2,   10,
			  133,   94,   17,  133,  133,   11,   12,   31,   30,    8,
			   29,    6,   32,  124,  124,    9,    7,   36,   34,   35,
			  133,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   15,  133,   16,   33,  126,   13,   14,    3,    4,    1,
			    2,   37,    0,  120,  122,   94,    0,  121,  118,  118,
			  118,    5,   23,   24,  129,   18,   20,    0,  124,  124,
			  123,  126,   28,   25,   22,   21,   26,   27,   93,   93,
			   93,   42,   93,   93,   93,   93,   93,   93,   48,   93,

			   93,   93,   93,   93,   93,   60,   93,   93,   66,   93,
			   93,   93,   93,   93,   93,   74,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   19,  126,  118,   95,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  129,    0,    0,  127,  129,  127,  124,  124,
			  126,   93,   41,   93,   93,   93,   93,   93,   93,   93,
			   51,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   70,   93,   72,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,

			   93,   93,   93,   93,   93,   92,  112,  110,  111,  113,
			  114,  119,  115,  116,   96,   97,   98,   99,  100,  101,
			  102,  103,  104,  105,  106,  107,  108,  109,  129,    0,
			  129,    0,  129,    0,    0,    0,  128,  124,  124,  126,
			   93,   93,   93,   93,   93,   93,   93,   49,   93,   93,
			   93,   93,   93,   93,   58,   93,   93,   93,   93,   93,
			   93,   67,   93,   69,   93,   73,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   85,   86,   93,   93,
			   93,   93,   91,  119,  129,  129,    0,    0,  129,    0,
			  128,    0,  128,    0,    0,  125,   40,   43,   44,   93,

			   93,   46,   93,   93,   93,   93,   93,   93,   56,   93,
			   93,   93,   93,   93,   93,   93,   68,   93,   93,   93,
			   93,   93,   93,   93,   81,   93,   93,   84,   93,   93,
			   89,   93,  117,    0,  129,    0,  132,  129,  128,    0,
			    0,  128,    0,  127,    0,   39,   93,   93,   93,   50,
			   52,   93,   54,   93,   93,   59,   93,   93,   93,   93,
			   93,   93,   93,   93,   77,   93,   79,   80,   82,   93,
			   93,   88,   93,    0,  129,    0,    0,    0,  128,    0,
			  132,  128,    0,    0,  130,  132,  130,   93,   45,   93,
			   93,   93,   57,   61,   93,   63,   64,   93,   93,   93,

			   93,   78,   93,   93,   90,  132,    0,  132,    0,  128,
			    0,    0,  131,  132,    0,  131,   38,   47,   53,   55,
			   62,   93,   71,   93,   76,   83,   87,  132,  131,    0,
			  131,  131,   65,   75,  131,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 852
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 435
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 436
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

	yyNb_rules: INTEGER is 134
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 135
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
			eif_buffer.wipe_out
			create analysed_tokens.make	-- create a new one, the old one
										-- is still "usable"
			last_token := Void
			first_token := Void
		end

feature -- Access

	curr_token: EDITOR_TOKEN
			-- Current token analysed

	last_token: EDITOR_TOKEN
			-- Last token analysed.

	first_token: EDITOR_TOKEN
			-- First token analysed.

	last_value: ANY
			-- Semantic value to be passed to the parser

	eif_buffer: STRING
			-- Buffer for lexial tokens

feature {NONE} -- Processing

	update_token_list is
			-- Link the current token to the last one.
		do
			if last_token = Void then
				first_token := current_token
			else
				last_token.set_previous_token(curr_token)
			end
			curr_token.set_next_token(last_token)
			last_token := curr_token
		end

feature {NONE} -- Constants

	Init_buffer_size: INTEGER is 80 
				-- Initial size for `eif_buffer'

invariant

	eif_buffer_not_void: eif_buffer /= Void

end -- class EIFFEL_SCANNER
