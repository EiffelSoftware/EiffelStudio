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
		export
			{NONE} all
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
if yy_act <= 68 then
if yy_act <= 34 then
if yy_act <= 17 then
if yy_act <= 9 then
if yy_act <= 5 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 47
-- Ignore carriage return
else
--|#line 48

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					
end
else
--|#line 52

					create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					update_token_list
					
end
else
if yy_act = 4 then
--|#line 56

					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					disabled_comments := False
					
else
--|#line 69
 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					update_token_list
					in_comments := True
					
end
end
else
if yy_act <= 7 then
if yy_act = 6 then
--|#line 78

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 79

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 8 then
--|#line 80

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 81

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
end
else
if yy_act <= 13 then
if yy_act <= 11 then
if yy_act = 10 then
--|#line 82

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 83

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 12 then
--|#line 84

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 85

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
else
if yy_act <= 15 then
if yy_act = 14 then
--|#line 86

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 87

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 16 then
--|#line 88

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 89

						-- Symbols
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
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
--|#line 99
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 100
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
--|#line 101
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 21 then
--|#line 102
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 103
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
else
if yy_act <= 24 then
if yy_act = 23 then
--|#line 104
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 105
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 25 then
--|#line 106
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 107
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
end
else
if yy_act <= 30 then
if yy_act <= 28 then
if yy_act = 27 then
--|#line 108
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 109
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 29 then
--|#line 110
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 111
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
else
if yy_act <= 32 then
if yy_act = 31 then
--|#line 112
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 113
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 33 then
--|#line 114
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 115
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
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
--|#line 116
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 117
 
						-- Operator Symbol
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
--|#line 129

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 38 then
--|#line 130

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 131

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
else
if yy_act <= 41 then
if yy_act = 40 then
--|#line 132

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 133

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 42 then
--|#line 134

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 135

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
end
else
if yy_act <= 47 then
if yy_act <= 45 then
if yy_act = 44 then
--|#line 136

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 137

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 46 then
--|#line 138

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 139

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
else
if yy_act <= 49 then
if yy_act = 48 then
--|#line 140

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 141

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 50 then
--|#line 142

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 143

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
end
end
else
if yy_act <= 60 then
if yy_act <= 56 then
if yy_act <= 54 then
if yy_act <= 53 then
if yy_act = 52 then
--|#line 144

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 145

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
--|#line 146

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 55 then
--|#line 147

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 148

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
else
if yy_act <= 58 then
if yy_act = 57 then
--|#line 149

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 150

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 59 then
--|#line 151

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 152

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
end
else
if yy_act <= 64 then
if yy_act <= 62 then
if yy_act = 61 then
--|#line 153

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 154

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 63 then
--|#line 155

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 156

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
else
if yy_act <= 66 then
if yy_act = 65 then
--|#line 157

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 158

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 67 then
--|#line 159

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 160

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
end
end
end
end
else
if yy_act <= 102 then
if yy_act <= 85 then
if yy_act <= 77 then
if yy_act <= 73 then
if yy_act <= 71 then
if yy_act <= 70 then
if yy_act = 69 then
--|#line 161

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 162

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
--|#line 163

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 72 then
--|#line 164

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 165

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
else
if yy_act <= 75 then
if yy_act = 74 then
--|#line 166

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 167

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 76 then
--|#line 168

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 169

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
end
else
if yy_act <= 81 then
if yy_act <= 79 then
if yy_act = 78 then
--|#line 170

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 171

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 80 then
--|#line 172

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 173

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
else
if yy_act <= 83 then
if yy_act = 82 then
--|#line 174

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 175

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 84 then
--|#line 176

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 177

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
end
end
else
if yy_act <= 94 then
if yy_act <= 90 then
if yy_act <= 88 then
if yy_act <= 87 then
if yy_act = 86 then
--|#line 178

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 179

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
--|#line 180

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 89 then
--|#line 181

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 182

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
else
if yy_act <= 92 then
if yy_act = 91 then
--|#line 183

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 184

										-- Keyword
										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
else
if yy_act = 93 then
--|#line 197

										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_TEXT} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
else
--|#line 209

										if not in_comments or disabled_comments then
											create {EDITOR_TOKEN_TEXT} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
end
end
end
else
if yy_act <= 98 then
if yy_act <= 96 then
if yy_act = 95 then
--|#line 223

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 224

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 97 then
--|#line 225

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 226

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
else
if yy_act <= 100 then
if yy_act = 99 then
--|#line 227

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 228

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 101 then
--|#line 229

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 230

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
end
end
end
else
if yy_act <= 119 then
if yy_act <= 111 then
if yy_act <= 107 then
if yy_act <= 105 then
if yy_act <= 104 then
if yy_act = 103 then
--|#line 231

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 232

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
--|#line 233

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 106 then
--|#line 234

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 235

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
else
if yy_act <= 109 then
if yy_act = 108 then
--|#line 236

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 237

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 110 then
--|#line 238

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 239

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
end
else
if yy_act <= 115 then
if yy_act <= 113 then
if yy_act = 112 then
--|#line 240

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 241

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 114 then
--|#line 242

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 243

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
else
if yy_act <= 117 then
if yy_act = 116 then
--|#line 244

					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 253

					if not in_comments or disabled_comments then
						code_ := text_substring (4, text_count - 2).to_integer
						if code_ > Platform.Maximum_character_code then
							-- Character error. Consedered as text.
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
						end
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 118 then
--|#line 268

					-- Character error. Catch-all rules (no backing up)
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 269

					-- Character error. Catch-all rules (no backing up)
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
end
end
end
else
if yy_act <= 128 then
if yy_act <= 124 then
if yy_act <= 122 then
if yy_act <= 121 then
if yy_act = 120 then
--|#line 282

					-- Eiffel String
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 283

					-- Eiffel String
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
--|#line 284

					-- Eiffel String
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
end
else
if yy_act = 123 then
--|#line 296

					-- Eiffel Bit
					if not in_comments or disabled_comments then
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
else
--|#line 308

						-- Eiffel Integer
						if not in_comments or disabled_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
end
end
else
if yy_act <= 126 then
if yy_act = 125 then
--|#line 309

						-- Eiffel Integer
						if not in_comments or disabled_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
else
--|#line 318

						-- Eiffel Integer Error (considered as text)
						if not in_comments or disabled_comments then
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
end
else
if yy_act = 127 then
	yy_position := yy_position - 1
--|#line 330

							-- Eiffel reals & doubles
						if not in_comments or disabled_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
else
--|#line 331

							-- Eiffel reals & doubles
						if not in_comments or disabled_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
end
end
end
else
if yy_act <= 132 then
if yy_act <= 130 then
if yy_act = 129 then
--|#line 332

							-- Eiffel reals & doubles
						if not in_comments or disabled_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
else
	yy_position := yy_position - 1
--|#line 333

							-- Eiffel reals & doubles
						if not in_comments or disabled_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
end
else
if yy_act = 131 then
--|#line 334

							-- Eiffel reals & doubles
						if not in_comments or disabled_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
else
--|#line 335

							-- Eiffel reals & doubles
						if not in_comments or disabled_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
end
end
else
if yy_act <= 134 then
if yy_act = 133 then
--|#line 351

					if in_comments then
						disabled_comments := True
					end
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
else
--|#line 359

					if in_comments then
						disabled_comments := False
					end
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
end
else
if yy_act = 135 then
--|#line 370

					-- Error (considered as text)
				if not in_comments or disabled_comments then
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
				end
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
			   48,   49,   37,   37,   50,   51,   52,   53,   54,   55,
			   31,   32,   33,   34,   36,   37,   39,   40,   37,   43,
			   44,   45,   46,   47,   56,   57,   64,   70,   71,   65,
			   72,   74,   76,   75,   75,   84,   85,  175,   77,   73,
			   78,  103,   79,   80,   78,  104,   80,   80,   86,   87,

			   90,   81,   91,   98,  340,   94,  119,   92,  105,   95,
			  100,  110,  101,   99,  175,   96,  121,  111,   97,  117,
			  124,  120,  102,  103,  320,  123,  122,   90,   91,  125,
			   82,   92,  105,   81,   82,   94,   95,  100,  101,   96,
			  106,  294,   97,  117,  113,  120,  121,  107,  108,  287,
			  122,  123,  124,  109,  114,  320,  115,  128,  128,  125,
			  116,   64,   64,   64,   65,   65,   65,  153,  153,   92,
			   78,  106,  160,  160,  108,  163,  113,  109,  427,  154,
			  165,  114,  115,  426,  116,  157,  157,  161,  161,  425,
			  167,  162,  170,   92,  163,  128,  131,  158,  424,  132,

			  133,  134,  135,  212,  212,  155,  423,  163,  136,  176,
			   82,  171,  165,  137,  167,  138,  170,  139,  140,  141,
			  142,  163,  143,  168,  144,  128,  172,  169,  145,   78,
			  146,  159,  160,  147,  148,  149,  150,  151,  152,  184,
			   81,  176,  173,  171,  179,  421,  174,  188,  180,  186,
			  172,  185,  189,  187,  255,  168,  198,  200,  169,  181,
			  196,  241,  182,  242,  197,  128,  128,  256,  204,   82,
			  174,  184,   81,  186,  206,  191,  179,  187,  180,  188,
			  198,  200,  402,  181,  189,  192,  182,  196,  193,  201,
			  194,  195,  204,  241,  202,  242,  229,  229,  206,  232,

			  232,  233,  233,  128,  230,  203,  230,  191,  154,  231,
			  231,  192,  193,  234,  194,  195,  243,  236,  244,  236,
			  245,  201,  237,  237,   78,  246,  238,  239,   78,  203,
			  239,  239,  240,  240,  155,   81,  249,  250,  253,  235,
			  243,  254,  261,  263,  245,  257,  267,  269,  271,  246,
			  244,  251,  270,  273,  275,  277,  393,  283,  280,  346,
			  249,  391,  253,  347,   82,  254,  272,   81,   82,  250,
			  128,  297,  257,  390,  261,  263,  270,  273,  267,  269,
			  271,  277,  280,  283,  285,  285,  275,  284,  212,  212,
			  272,  231,  231,  286,  286,  297,  154,  288,  288,  289,

			  289,  290,  299,  290,  292,  292,  291,  291,  237,  237,
			  300,  234,  293,  293,  295,  303,  238,  239,  295,  305,
			  239,  239,  155,  296,  296,   81,  299,  306,  307,  336,
			  336,  287,  308,  326,  300,  310,  314,  235,  316,  303,
			  317,  318,  319,  305,  324,  323,  327,  329,  330,  331,
			  294,  332,  307,  306,  128,  388,  308,   81,  128,  310,
			  314,  128,  316,  285,  285,  326,  319,  317,  318,  323,
			  327,  324,  330,  335,  335,  334,  331,  348,  329,  337,
			  337,  338,  338,  332,  291,  291,  339,  339,  341,  341,
			  342,  342,  349,  234,  343,  343,  338,  338,  345,  350,

			  128,  128,  352,  348,  360,  353,  354,  355,  344,  356,
			  372,  287,  370,  363,  373,  366,  349,  368,  369,  235,
			  374,  371,  374,  377,  340,  375,  375,  367,  294,  353,
			  350,  355,  354,  365,  352,  356,  360,  363,   82,  366,
			  373,  368,  369,  392,  370,  375,  375,  376,  376,  155,
			  338,  338,  379,  379,  380,  380,  381,  381,  382,  382,
			  383,  383,  378,  384,  389,  384,  386,  386,  382,  382,
			  394,  395,  398,  401,  396,  392,  397,  399,  387,  400,
			  404,  403,  364,  287,  405,  375,  375,  362,  389,  361,
			  340,  375,  375,  412,  394,  359,  294,  395,  396,  401,

			  397,  399,  358,  400,  398,  403,  404,  357,  405,  406,
			  406,  407,  418,  407,  410,  410,  408,  408,  409,  235,
			  409,  411,  411,  410,  410,  382,  382,  413,  413,  382,
			  382,  414,  414,  415,  417,  415,  419,  420,  416,  416,
			  422,  408,  408,  412,  418,  428,  428,  410,  410,  410,
			  410,  351,  340,  429,  429,  433,  430,  434,  430,  333,
			  417,  431,  431,  328,  420,  325,  422,  322,  419,  235,
			  381,  381,  416,  416,  432,  432,  406,  406,  321,  433,
			  315,  434,  412,  287,  431,  431,  435,  435,  413,  413,
			  429,  429,   63,   63,  313,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,  312,  311,  309,  304,  235,   66,
			  302,  301,  294,  298,  287,   66,   66,   66,   66,   66,
			   66,  282,  281,  279,  340,  278,  294,  276,  340,   67,
			   67,  274,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   69,   69,  268,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   89,   89,   89,   89,   89,  129,  129,
			  266,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  156,  156,  156,  156,  156,  156,  265,  156,  156,  156,
			  156,  156,  385,  385,  385,  385,  385,  385,  264,  385,
			  385,  385,  385,  385,  262,  260,  259,  258,  252,  248,

			  247,  228,  227,  226,  225,  224,  223,  222,  221,  220,
			  219,  218,  217,  216,  215,  214,  213,  211,  210,  209,
			  208,  207,  205,  199,  190,  183,  178,  177,  166,  164,
			  130,   68,   68,   61,   60,   59,   58,  127,  126,  118,
			  112,   93,   88,   83,   68,   62,   61,   60,   59,   58,
			  436,    3,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,

			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436>>)
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
			    1,    1,    1,    1,    1,    1,   10,   14,   14,   10,
			   20,   21,   22,   21,   21,   27,   27,  103,   22,   20,
			   23,   36,   23,   23,   24,   36,   24,   24,   29,   29,

			   31,   23,   31,   34,  429,   33,   44,   31,   36,   33,
			   35,   39,   35,   34,  103,   33,   45,   39,   33,   42,
			   47,   44,   35,   36,  268,   46,   45,   31,   31,   48,
			   23,   31,   36,   23,   24,   33,   33,   35,   35,   33,
			   38,  413,   33,   42,   41,   44,   45,   38,   38,  406,
			   45,   46,   47,   38,   41,  268,   41,   54,   54,   48,
			   41,   63,   64,   65,   63,   64,   65,   75,   75,   93,
			   80,   38,   80,   80,   38,   91,   41,   38,  404,   75,
			   95,   41,   41,  403,   41,   78,   78,   82,   82,  401,
			   97,   90,  100,   93,   90,   54,   70,   78,  400,   70,

			   70,   70,   70,  136,  136,   75,  399,   91,   70,  104,
			   80,  101,   95,   70,   97,   70,  100,   70,   70,   70,
			   70,   90,   70,   98,   70,   82,  101,   98,   70,   79,
			   70,   79,   79,   70,   70,   70,   70,   70,   70,  111,
			   79,  104,  102,  101,  108,  395,  102,  114,  108,  112,
			  101,  111,  115,  113,  177,   98,  120,  122,   98,  108,
			  119,  162,  108,  164,  119,  128,  128,  177,  124,   79,
			  102,  111,   79,  112,  126,  118,  108,  113,  108,  114,
			  120,  122,  366,  108,  115,  118,  108,  119,  118,  123,
			  118,  118,  124,  162,  123,  164,  153,  153,  126,  155,

			  155,  157,  157,  128,  154,  123,  154,  118,  153,  154,
			  154,  118,  118,  157,  118,  118,  165,  158,  166,  158,
			  167,  123,  158,  158,  159,  168,  159,  159,  160,  123,
			  160,  160,  161,  161,  153,  159,  172,  173,  175,  157,
			  165,  176,  182,  184,  167,  178,  190,  192,  194,  168,
			  166,  173,  193,  195,  197,  199,  355,  205,  202,  300,
			  172,  352,  175,  300,  159,  176,  194,  159,  160,  173,
			  161,  241,  178,  349,  182,  184,  193,  195,  190,  192,
			  194,  199,  202,  205,  229,  229,  197,  212,  212,  212,
			  194,  230,  230,  231,  231,  241,  229,  232,  232,  233,

			  233,  234,  243,  234,  235,  235,  234,  234,  236,  236,
			  244,  233,  237,  237,  238,  247,  238,  238,  239,  249,
			  239,  239,  229,  240,  240,  238,  243,  250,  251,  287,
			  287,  231,  252,  274,  244,  254,  259,  233,  261,  247,
			  263,  265,  267,  249,  272,  271,  275,  279,  280,  281,
			  237,  282,  251,  250,  238,  347,  252,  238,  239,  254,
			  259,  240,  261,  285,  285,  274,  267,  263,  265,  271,
			  275,  272,  280,  286,  286,  285,  281,  301,  279,  288,
			  288,  289,  289,  282,  290,  290,  291,  291,  292,  292,
			  293,  293,  303,  289,  294,  294,  295,  295,  296,  304,

			  296,  296,  306,  301,  315,  307,  308,  310,  295,  311,
			  330,  286,  327,  319,  332,  322,  303,  324,  326,  289,
			  334,  329,  334,  337,  291,  334,  334,  323,  293,  307,
			  304,  310,  308,  321,  306,  311,  315,  319,  296,  322,
			  332,  324,  326,  354,  327,  335,  335,  336,  336,  337,
			  338,  338,  339,  339,  340,  340,  341,  341,  342,  342,
			  343,  343,  338,  344,  348,  344,  345,  345,  344,  344,
			  357,  358,  361,  364,  359,  354,  360,  362,  345,  363,
			  371,  370,  320,  335,  373,  374,  374,  318,  348,  316,
			  339,  375,  375,  381,  357,  314,  342,  358,  359,  364,

			  360,  362,  313,  363,  361,  370,  371,  312,  373,  376,
			  376,  377,  390,  377,  379,  379,  377,  377,  378,  381,
			  378,  380,  380,  378,  378,  382,  382,  383,  383,  384,
			  384,  386,  386,  387,  388,  387,  391,  392,  387,  387,
			  398,  407,  407,  386,  390,  408,  408,  409,  409,  410,
			  410,  305,  379,  411,  411,  422,  412,  424,  412,  284,
			  388,  412,  412,  276,  392,  273,  398,  270,  391,  386,
			  414,  414,  415,  415,  416,  416,  428,  428,  269,  422,
			  260,  424,  414,  408,  430,  430,  431,  431,  432,  432,
			  435,  435,  437,  437,  258,  437,  437,  437,  437,  437,

			  437,  437,  437,  437,  257,  256,  253,  248,  414,  438,
			  246,  245,  416,  242,  428,  438,  438,  438,  438,  438,
			  438,  204,  203,  201,  431,  200,  432,  198,  435,  439,
			  439,  196,  439,  439,  439,  439,  439,  439,  439,  439,
			  439,  440,  440,  191,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  441,  441,  441,  441,  441,  442,  442,
			  189,  442,  442,  442,  442,  442,  442,  442,  442,  442,
			  443,  443,  443,  443,  443,  443,  187,  443,  443,  443,
			  443,  443,  444,  444,  444,  444,  444,  444,  185,  444,
			  444,  444,  444,  444,  183,  181,  180,  179,  174,  170,

			  169,  152,  151,  150,  149,  148,  147,  146,  145,  144,
			  143,  142,  141,  140,  139,  138,  137,  135,  134,  133,
			  132,  131,  125,  121,  117,  110,  107,  105,   96,   94,
			   69,   68,   67,   61,   60,   59,   58,   51,   49,   43,
			   40,   32,   30,   25,   13,    9,    8,    7,    6,    5,
			    3,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,

			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  850,  851,  847,  845,  843,  841,  839,
			   69,    0,  851,  837,   67,  851,  851,  851,  851,  851,
			   63,   63,   63,   72,   76,  818,  851,   61,  851,   73,
			  817,   61,  805,   70,   71,   71,   63,    0,  107,   75,
			  798,  115,   74,  807,   74,   81,   84,   92,   94,  796,
			  851,  782,  851,  851,  137,  851,  851,  851,  834,  832,
			  830,  828,  851,  154,  155,  156,    0,  825,  824,  819,
			  189,    0,  851,  851,  851,  147,  851,  851,  165,  211,
			  152,  851,  167,  851,  851,  851,  851,  851,  851,    0,
			  155,  144,    0,  122,  797,  152,  796,  145,  194,    0,

			  146,  180,  199,   48,  181,  785,    0,  783,  213,    0,
			  787,  209,  202,  207,  216,  222,    0,  792,  244,  221,
			  211,  791,  209,  258,  223,  790,  229,  851,  245,  851,
			  851,  810,  809,  808,  807,  806,  183,  805,  804,  803,
			  802,  801,  800,  799,  798,  797,  796,  795,  794,  793,
			  792,  791,  790,  276,  289,  279,  851,  281,  302,  306,
			  310,  312,  233,    0,  233,  270,  290,  275,  277,  768,
			  767,    0,  288,  309,  766,  292,  294,  214,  306,  765,
			  764,  752,  314,  762,  315,  745,    0,  734,    0,  728,
			  316,  711,  319,  304,  318,  308,  699,  326,  691,  314,

			  693,  691,  314,  686,  685,  316,    0,  851,  851,  851,
			  851,  851,  368,  851,  851,  851,  851,  851,  851,  851,
			  851,  851,  851,  851,  851,  851,  851,  851,  851,  364,
			  371,  373,  377,  379,  386,  384,  388,  392,  396,  400,
			  403,  325,  675,  356,  363,  679,  676,  370,  671,  374,
			  386,  383,  387,  674,  387,    0,  673,  668,  643,  391,
			  648,  393,    0,  401,    0,  402,    0,  394,   91,  638,
			  631,  397,  405,  613,  403,  401,  620,    0,    0,  414,
			  400,  410,  423,    0,  648,  443,  453,  409,  459,  461,
			  464,  466,  468,  470,  474,  476,  480,    0,    0,    0,

			  327,  436,    0,  447,  466,  619,  471,  458,  465,    0,
			  462,  468,  575,  566,  559,  474,  553,    0,  555,  468,
			  546,  501,  470,  495,  470,    0,  471,  484,    0,  485,
			  478,    0,  473,  851,  505,  525,  527,  491,  530,  532,
			  534,  536,  538,  540,  548,  546,    0,  413,  517,  341,
			    0,    0,  329,    0,  515,  324,    0,  524,  530,  527,
			  529,  544,  530,  533,  532,    0,  250,    0,    0,    0,
			  534,  539,    0,  537,  565,  571,  589,  596,  603,  594,
			  601,  561,  605,  607,  609,  851,  611,  618,  593,    0,
			  581,  605,  598,    0,    0,  211,    0,    0,  599,  174,

			  156,  157,    0,  151,  146,    0,   91,  621,  625,  627,
			  629,  633,  641,   83,  650,  652,  654,    0,    0,    0,
			    0,    0,  608,    0,  612,    0,    0,    0,  656,   46,
			  664,  666,  668,    0,    0,  670,  851,  691,  708,  728,
			  740,  745,  757,  769,  781>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  436,    1,  436,  436,  436,  436,  436,  436,  436,
			  437,  438,  436,  439,  440,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  437,  437,  437,  438,  439,  439,  442,
			  442,  442,  436,  436,  436,  436,  436,  436,  443,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,

			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,

			  441,  441,  441,  441,  441,  441,  441,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  443,  436,  441,  441,  441,

			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  444,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,

			  441,  441,  441,  441,  441,  441,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  436,  436,
			  436,  436,  436,  441,  441,  436,    0,  436,  436,  436,
			  436,  436,  436,  436,  436>>)
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
			   53,   54,   55,   56,   57,   58,   59,   60,   61,   62,

			   63,   32,   64,   34,   65,   36,   37,   38,   66,   40,
			   67,   42,   43,   68,   69,   70,   71,   72,   73,   50,
			   51,   52,   53,   74,    8,   75,    1,    1,    1,    1,
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
			    8,    8,    8,   10,    1,    1,    1,    1,   11,    1,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,   12,    1,    1>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  137,  135,    3,    4,    1,    2,   10,
			  135,   94,   17,  135,  134,   11,   12,   31,   30,    8,
			   29,    6,   32,  124,  124,    9,    7,   36,   34,   35,
			  135,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   15,  135,   16,   33,  126,  133,   13,   14,    3,    4,
			    1,    2,   37,    0,  120,  122,   94,    0,  121,  118,
			  118,  118,    5,   23,   24,  129,   18,   20,    0,  124,
			  124,  123,  126,   28,   25,   22,   21,   26,   27,   93,
			   93,   93,   42,   93,   93,   93,   93,   93,   93,   48,

			   93,   93,   93,   93,   93,   93,   60,   93,   93,   66,
			   93,   93,   93,   93,   93,   93,   74,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   19,  126,  118,
			   95,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  129,    0,    0,  127,  129,  127,  124,
			  124,  126,   93,   41,   93,   93,   93,   93,   93,   93,
			   93,   51,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   70,   93,   72,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,

			   93,   93,   93,   93,   93,   93,   92,  112,  110,  111,
			  113,  114,  119,  115,  116,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,  105,  106,  107,  108,  109,  129,
			    0,  129,    0,  129,    0,    0,    0,  128,  124,  124,
			  126,   93,   93,   93,   93,   93,   93,   93,   49,   93,
			   93,   93,   93,   93,   93,   58,   93,   93,   93,   93,
			   93,   93,   67,   93,   69,   93,   73,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   85,   86,   93,
			   93,   93,   93,   91,  119,  129,  129,    0,    0,  129,
			    0,  128,    0,  128,    0,    0,  125,   40,   43,   44,

			   93,   93,   46,   93,   93,   93,   93,   93,   93,   56,
			   93,   93,   93,   93,   93,   93,   93,   68,   93,   93,
			   93,   93,   93,   93,   93,   81,   93,   93,   84,   93,
			   93,   89,   93,  117,    0,  129,    0,  132,  129,  128,
			    0,    0,  128,    0,  127,    0,   39,   93,   93,   93,
			   50,   52,   93,   54,   93,   93,   59,   93,   93,   93,
			   93,   93,   93,   93,   93,   77,   93,   79,   80,   82,
			   93,   93,   88,   93,    0,  129,    0,    0,    0,  128,
			    0,  132,  128,    0,    0,  130,  132,  130,   93,   45,
			   93,   93,   93,   57,   61,   93,   63,   64,   93,   93,

			   93,   93,   78,   93,   93,   90,  132,    0,  132,    0,
			  128,    0,    0,  131,  132,    0,  131,   38,   47,   53,
			   55,   62,   93,   71,   93,   76,   83,   87,  132,  131,
			    0,  131,  131,   65,   75,  131,    0>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 851
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 436
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 437
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

	yyNb_rules: INTEGER is 136
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 137
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
			end_token := Void
			first_token := Void
			in_comments := False
			disabled_comments := False
		end

feature -- Access

	curr_token: EDITOR_TOKEN
			-- Current token analysed

	end_token: EDITOR_TOKEN
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
			if end_token = Void then
				first_token := curr_token
			else
				end_token.set_next_token(curr_token)
			end
			curr_token.set_previous_token(end_token)
			end_token := curr_token
		end

feature {NONE} -- Constants

	Init_buffer_size: INTEGER is 80 
				-- Initial size for `eif_buffer'

	in_comments: BOOLEAN
			-- Are we inside a comment?

	disabled_comments: BOOLEAN
			-- Are comments disabled?
			-- Notes: comments are disabled inside `...'

invariant

	eif_buffer_not_void: eif_buffer /= Void

end -- class EIFFEL_SCANNER
