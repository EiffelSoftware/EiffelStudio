note
	description: "Special symbols"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SPECIAL_SYMBOLS

feature -- Special simbols -- 1

	Space: STRING = " "
	
	New_line: STRING = "%N"
	
	Tab: STRING = "%T"
	
	Tab_tab: STRING = "%T%T"

	Tab_tab_tab: STRING = "%T%T%T"
	
	New_line_tab: STRING = "%N%T"
	
	New_line_tab_tab: STRING = "%N%T%T"
	
	New_line_tab_tab_tab: STRING = "%N%T%T%T"
	
	Open_parenthesis: STRING = "("
	
	Close_parenthesis: STRING = ")"
	
	Open_bracket: STRING = "%("
	
	Close_bracket: STRING = "%)"
	
	Open_curly_brace: STRING = "%<"
	
	Close_curly_brace: STRING = "%>"
	
	Double_dash: STRING = "--"

	Dollar: STRING = "%D"
	
	Colon: STRING = ":"
	
	Comma: STRING = ","

	Semicolon: STRING = ";"

	Underscore: STRING = "_"

	Equal_sign: STRING = "="

	Assignment: STRING = ":="

	Eiffel_not_equal: STRING = "/="

	C_equal: STRING = " == "

	C_not_equal: STRING = "!="

	C_not: STRING = "!"

	Ampersand: STRING = "&"

	Single_quote: STRING = "%'"

	Back_quote: STRING = "%Q"

	Double_quote: STRING = "%""

	Percent_double_quote: STRING = "%%%""

	Asterisk: STRING = "*"

	Space_asterisk_space: STRING = " * "

	Percent: STRING = "%%"

	Dot: STRING = "."

	Less: STRING = "<"

	More: STRING = ">"

	Plus: STRING = "+"

	Minus: STRING = "-"

	Comma_space: STRING = ", "

	Space_open_parenthesis: STRING = " ("

	Space_equal_space: STRING = " = "

	Sharp: STRING = "%S"
			-- #

	At_sign: STRING = "@"

	C_or: STRING = "||"

	C_and: STRING = "&&"

	Registry_field_seperator: STRING = "\\";

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_SPECIAL_SYMBOLS

