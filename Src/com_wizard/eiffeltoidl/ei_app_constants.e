indexing
	description: "Common application constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_APP_CONSTANTS

feature {NONE} -- Access

	Filter_output_file_name: STRING is "com_filter.output"

	Return_value_variable_name: STRING is "return_value"

feature -- Constants for input parser
	
	Feature_indicator: STRING is "#feature#"

	Description_indicator: STRING is "description:"

	Type_indicator: STRING is "#type#"

	Comment_indicator: STRING is "#--#"

	Class_header_indicator: STRING is "#class#"

	Infix_feature_indicator: STRING is "#infix#"

	Prefix_feature_indicator: STRING is "#prefix#"

	Constant_indicator: STRING is " is "

	Current_type: STRING is "Current"

	Like_word: STRING is "like"

	Empty_string: STRING is ""

	Colon_character: CHARACTER is ':'

	Space_character: CHARACTER is ' '

	Open_parenthesis_char: CHARACTER is '('

	Close_parenthesis_char: CHARACTER is ')'

	Comma_character: CHARACTER is ','

	Semicolon_character: CHARACTER is ';'

	Double_quote_character: CHARACTER is '%"';

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
end -- class EI_APP_CONSTANTS

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

