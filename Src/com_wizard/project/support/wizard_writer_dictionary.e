indexing
	description: "Wizard writer constants"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_DICTIONARY

inherit
	WIZARD_GENERATOR_CONSTANTS

	WIZARD_TYPES

	WIZARD_LANGUAGES_KEYWORDS

	WIZARD_COM_CONSTANTS

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

	
feature -- CECIL function names/ Keywords

	Eif_procedure_name: STRING is "eif_procedure"

	Eif_field: STRING is "eif_field"

	Eif_character_function_name: STRING is "eif_character_function"

	Eif_reference_function_name: STRING is "eif_reference_function"

	Eif_pointer_function_name: STRING is "eif_pointer_function"

	Eif_integer_function_name: STRING is "eif_integer_function"

	Eif_real_function_name: STRING is "eif_real_function"

	Eif_double_function_name: STRING is "eif_double_function"

	Eif_boolean_function_name: STRING is "eif_boolean_function"

	Eif_type_id_function_name: STRING is "eif_type_id"

	Eif_create: STRING is "eif_create"

	Eif_protect: STRING is "eif_protect"

	Eif_access: STRING is "eif_access"

	Eif_wean: STRING is "eif_wean"

	Eif_make_from_c: STRING is "eif_make_from_c"

	C_keyword: STRING is "C"

	Macro: STRING is "macro"

feature -- Paths -- 11

	Interfaces: STRING is "Interfaces"

	Common: STRING is "Common"

	Server: STRING is "Server"

	Client: STRING is "Client"

	Component: STRING is "Component"

	Clib: STRING is "Clib"

	Include: STRING is "Include"

	Structures: STRING is "Structures"

	Eiffel_file_extension: STRING is ".e"

	Header_file_extension: STRING is ".h"

	C_file_extension: STRING is ".c"

	Cpp_file_extension: STRING is ".cpp"

	Backup_file_extension: STRING is ".bac"

	Dll_file_extension: STRING is ".dll"

	Lib_file_extension: STRING is ".lib"

	Object_file_extension: STRING is ".obj"

	Definition_file_extension: STRING is ".def"

feature -- Commands -- 12
	
	Copy_command: STRING is "xcopy /C"

	Delete_command: STRING is "del"

feature -- languages --13

	C: STRING is "C"

	Eiffel: STRING is "Eiffel"


end -- class WIZARD_WRITER_DICTIONARY

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
