indexing
	description: "Wizard writer constants"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	Interface_proxy: STRING is "Interface_proxy"

	Interface_stub: STRING is "Interface_stub"

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

	Eiffel: STRING is "Eiffel";


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
end -- class WIZARD_WRITER_DICTIONARY

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
