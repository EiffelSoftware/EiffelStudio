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

	WIZARD_SPECIAL_SYMBOLS

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

	Eif_adopt: STRING is "eif_adopt"

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
