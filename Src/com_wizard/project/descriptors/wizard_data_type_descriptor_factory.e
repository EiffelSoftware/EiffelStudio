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
			l_var_type: INTEGER
			l_automation_creator: WIZARD_AUTOMATION_DATA_TYPE_CREATOR 
			l_pointed_creator: WIZARD_POINTED_DATA_TYPE_CREATOR 
			l_safearray_creator: WIZARD_SAFEARRAY_DATA_TYPE_CREATOR 
			l_array_creator: WIZARD_ARRAY_DATA_TYPE_CREATOR 
			l_user_defined_creator: WIZARD_USER_DEFINED_DATA_TYPE_CREATOR 
		do
			l_var_type := a_type_desc.var_type
			if is_user_defined (l_var_type) then
				create l_user_defined_creator
				Result := l_user_defined_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_carray (l_var_type) then
				create l_array_creator
				Result := l_array_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_ptr (l_var_type) then
				create l_pointed_creator
				Result := l_pointed_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_safearray (l_var_type) then
				create l_safearray_creator
				Result := l_safearray_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			else
				create l_automation_creator
				Result := l_automation_creator.create_descriptor (a_type_desc)
			end
			if is_iunknown (l_var_type) then
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

