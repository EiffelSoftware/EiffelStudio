indexing
	description: "Factory of WIZARD_DATA_TYPE_DESCRIPTOR"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DATA_TYPE_DESCRIPTOR_FACTORY

inherit
	ECOM_VAR_TYPE
		export
			{NONE} all
		end

feature -- Basic operations

	create_data_type_descriptor (a_type_info: ECOM_TYPE_INFO; a_type_desc: ECOM_TYPE_DESC; 
				a_system_description: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_DATA_TYPE_DESCRIPTOR is
			-- Create 'Result' according to type
		local
			var_type: INTEGER
			automation_creator: WIZARD_AUTOMATION_DATA_TYPE_CREATOR 
			pointed_creator: WIZARD_POINTED_DATA_TYPE_CREATOR 
			safearray_creator: WIZARD_SAFEARRAY_DATA_TYPE_CREATOR 
			array_creator: WIZARD_ARRAY_DATA_TYPE_CREATOR 
			user_defined_creator: WIZARD_USER_DEFINED_DATA_TYPE_CREATOR 
		do
			var_type := a_type_desc.var_type
			if is_user_defined (var_type) then
				create user_defined_creator
				Result := user_defined_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_carray (var_type) then
				create array_creator
				Result := array_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_ptr (var_type) then
				create pointed_creator
				Result := pointed_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_safearray (var_type) then
				create safearray_creator
				Result := safearray_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			else
				create automation_creator
				Result := automation_creator.create_descriptor (a_type_desc)
			end
			if is_unknown (var_type) then
				a_system_description.set_iunknown
			end
		end

end -- class WIZARD_DATA_TYPE_DESCRIPTOR_FACTORY

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

