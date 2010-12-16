note
	description: "Set of string constants representing Objective-C keywords/tokens."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_TOKEN

feature -- Access

	interface_keyword: STRING = "interface"
			-- "interface" keyword.

	protocol_keyword: STRING = "protocol"
			-- "protocol" keyword.

	optional_keyword: STRING = "optional"
			-- "optional" keyword.

	required_keyword: STRING = "required"
			-- "required" keyword.

	property_keyword: STRING = "property"
			-- "property" keyword.

	readonly_keyword: STRING = "readonly"
			-- "readonly" keyword.

	getter_keyword: STRING = "getter"
			-- "getter" keyword.

	setter_keyword: STRING = "setter"
			-- "setter" keyword.

	in_keyword: STRING = "in"
			-- "in" keyword.

	inout_keyword: STRING = "inout"
			-- "inout" keyword.

	out_keyword: STRING = "out"
			-- "out" keyword.

	bycopy_keyword: STRING = "bycopy"
			-- "bycopy" keyword.

	byref_keyword: STRING = "byref"
			-- "byref" keyword.

	oneway_keyword: STRING = "oneway"
			-- "oneway"

	end_keyword: STRING = "end"
			-- "end" keyword.

	at_symbol: STRING = "@"
			-- '@' symbol.

	plus_symbol: STRING = "+"
			-- "+" symbol.

	minus_symbol: STRING = "-"
			-- '-' symbol.

	hash_symbol: STRING = "#"
			-- '#' symbol.

	open_parenthesis_symbol: STRING = "("
			-- Open parenthesis symbol.

	closed_parenthesis_symbol: STRING = ")"
			-- Closed parenthesis symbol.

	equal_symbol: STRING = "="
			-- '=' symbol.

	less_than_symbol: STRING = "<"
			-- '<' symbol.

	greater_than_symbol: STRING = ">"
			-- '>' symbol.

	comma_symbol: STRING = ","
			-- ',' symbol.

	dot_symbol: STRING = "."
			-- "." symbol.

	semi_colon_symbol: STRING = ";"
			-- ';' symbol.

	colon_symbol: STRING = ":"
			-- ':' symbol.

	quotation_mark_symbol: STRING = "%""
			-- '"' symbol.

	space_character: CHARACTER = ' '
			-- ' ' character.

	tab_character: CHARACTER = '%T'
			-- Tab character.

	underscore_symbol: CHARACTER = '_'
			-- '_' symbol.

end
