indexing
	description: "Special symbols"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SPECIAL_SYMBOLS

feature -- Special simbols -- 1

	Space: STRING is " "
	
	New_line: STRING is "%N"
	
	Tab: STRING is "%T"
	
	Tab_tab: STRING is "%T%T"

	Tab_tab_tab: STRING is "%T%T%T"
	
	New_line_tab: STRING is "%N%T"
	
	New_line_tab_tab: STRING is "%N%T%T"
	
	New_line_tab_tab_tab: STRING is "%N%T%T%T"
	
	Open_parenthesis: STRING is "("
	
	Close_parenthesis: STRING is ")"
	
	Open_bracket: STRING is "%("
	
	Close_bracket: STRING is "%)"
	
	Open_curly_brace: STRING is "%<"
	
	Close_curly_brace: STRING is "%>"
	
	Double_dash: STRING is "--"

	Dollar: STRING is "%D"
	
	Colon: STRING is ":"
	
	Comma: STRING is ","

	Semicolon: STRING is ";"

	Underscore: STRING is "_"

	Equal_sign: STRING is "="

	Assignment: STRING is ":="

	Eiffel_not_equal: STRING is "/="

	C_equal: STRING is " == "

	C_not_equal: STRING is "!="

	C_not: STRING is "!"

	Ampersand: STRING is "&"

	Single_quote: STRING is "%'"

	Back_quote: STRING is "%Q"

	Double_quote: STRING is "%""

	Percent_double_quote: STRING is "%%%""

	Asterisk: STRING is "*"

	Space_asterisk_space: STRING is " * "

	Percent: STRING is "%%"

	Tilda: STRING is "~"

	Dot: STRING is "."

	Less: STRING is "<"

	More: STRING is ">"

	Plus: STRING is "+"

	Minus: STRING is "-"

	Comma_space: STRING is ", "

	Space_open_parenthesis: STRING is " ("

	Space_equal_space: STRING is " = "

	Sharp: STRING is "%S"
			-- #

	At_sign: STRING is "@"

	C_or: STRING is "||"

	C_and: STRING is "&&"

	Registry_field_seperator: STRING is "\\"

end -- class WIZARD_SPECIAL_SYMBOLS
