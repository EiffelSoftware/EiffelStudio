indexing
	description: "Warning messages for EiffelCOM wizard."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WARNINGS


feature -- Access

	Inconsistant_data_type_descriptor: STRING is "Inconsistant Data Type Descriptor"
			-- This message is displayed when dynamic type of descriptor 
			-- does not correspond to its `type' attribute.

	Unknown_type_of_safearray_element: STRING is "Unknown type of SAFEARRAY element"
			-- If element of SAFEARRAY has type Vt_record 
			-- then this message is displaied

	Cannot_generate_precondition: STRING is "Can not generate precondition"
			-- Can not generate precondition dues to errors.

	Duplicate_feature_name: STRING is "Duplicate feature name"
			-- Duplicate feature name declaration

	Not_supported_data_type: STRING is "Data type is not supported"
			-- Data type is not supported

	Void_array: STRING is "ARRAY of type void is not supprted"
			-- Array of type void.

	Unions_not_supported: STRING is "Unions are not supported"
			-- Unions are not supprted.

	File_already_exists: STRING is "File already exists"
			-- Trying to overwrite a file

	Non_supported_alias: STRING is "Non supported alias type"
			-- Alias of non supported type.

	Invalid_use_of_enumeration: STRING is "Enumeration can not be out or inout parameter"
			-- Invalid use of enumeration.

	Alias_basic_type: STRING is "Alias to basic type, Eiffel class is not generated"
			-- Alias to basic type.

	Type_info_module: STRING is "Type Info of module"
			-- Module.

	Not_pointer_type: STRING is "out or inout variable is not declared as pointer type in IDL file"
			-- Variable is not declared as pointer type in IDL file

	Not_variant_type: STRING is "Variable is not a variant type"
			-- Variable is not variant type.

	name_is_C_keyword: STRING is " is C/C++ keyword, please choose another feature name"
			-- feature name is C++ keyword.

	Not_e2idl_convertable_type: STRING is "is not convertable to COM type"
			-- E2idl cannot convert to COM type.

end -- class WIZARD_WARNINGS

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

