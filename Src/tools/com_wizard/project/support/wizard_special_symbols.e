indexing
	description: "Special symbols"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	Registry_field_seperator: STRING is "\\";

indexing
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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
