note
	description: "Warning messages for EiffelCOM wizard."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WARNINGS


feature -- Access

	Inconsistant_data_type_descriptor: STRING = "Inconsistant Data Type Descriptor"
			-- This message is displayed when dynamic type of descriptor 
			-- does not correspond to its `type' attribute.

	Unknown_type_of_safearray_element: STRING = "Unknown type of SAFEARRAY element"
			-- If element of SAFEARRAY has type Vt_record 
			-- then this message is displaied

	Cannot_generate_precondition: STRING = "Can not generate precondition"
			-- Can not generate precondition dues to errors.

	Duplicate_feature_name: STRING = "Duplicate feature name"
			-- Duplicate feature name declaration

	Not_supported_data_type: STRING = "Data type is not supported"
			-- Data type is not supported

	Void_array: STRING = "ARRAY of type void is not supprted"
			-- Array of type void.

	Unions_not_supported: STRING = "Unions are not supported"
			-- Unions are not supprted.

	File_already_exists: STRING = "File already exists"
			-- Trying to overwrite a file

	Non_supported_alias: STRING = "Non supported alias type"
			-- Alias of non supported type.

	Invalid_use_of_enumeration: STRING = "Enumeration can not be out or inout parameter"
			-- Invalid use of enumeration.

	Alias_basic_type: STRING = "Alias to basic type, Eiffel class is not generated"
			-- Alias to basic type.

	Type_info_module: STRING = "Type Info of module"
			-- Module.

	Not_pointer_type: STRING = "out or inout variable is not declared as pointer type in IDL file"
			-- Variable is not declared as pointer type in IDL file

	Not_variant_type: STRING = "Variable is not a variant type"
			-- Variable is not variant type.

	name_is_C_keyword: STRING = " is C/C++ keyword, please choose another feature name"
			-- feature name is C++ keyword.

	Not_e2idl_convertable_type: STRING = "is not convertable to COM type";
			-- E2idl cannot convert to COM type.

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
end -- class WIZARD_WARNINGS


