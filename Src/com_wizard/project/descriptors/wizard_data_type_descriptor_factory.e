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

	WIZARD_MESSAGE_OUTPUT
		export
			{NONE} all
		end

feature -- Basic operations

	create_data_type_descriptor (a_type_info: ECOM_TYPE_INFO; a_type_desc: ECOM_TYPE_DESC; 
				a_system_description: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_DATA_TYPE_DESCRIPTOR is
			-- Create 'Result' according to type
		local
			var_type: INTEGER
		do
			var_type := a_type_desc.var_type
			if is_user_defined (var_type) then
				Result := user_defined_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_carray (var_type) then
				Result := array_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_ptr (var_type) then
				Result := pointed_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_safearray (var_type) then
				Result := safearray_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			else
				Result := automation_creator.create_descriptor (a_type_desc)
			end
			if is_unknown (var_type) then
				a_system_description.set_iunknown
			end
		end

feature -- Implementation

	automation_creator: WIZARD_AUTOMATION_DATA_TYPE_CREATOR is
			-- WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR creator
		once
			create Result
		end

	pointed_creator: WIZARD_POINTED_DATA_TYPE_CREATOR is
			-- WIZARD_POINTED_DATA_TYPE_DESCRIPTOR creator
		once
			create Result
		end

	safearray_creator: WIZARD_SAFEARRAY_DATA_TYPE_CREATOR is
			-- WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR creator
		once
			create Result
		end

	array_creator: WIZARD_ARRAY_DATA_TYPE_CREATOR is
			-- WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR creator
		once
			create Result
		end

	user_defined_creator: WIZARD_USER_DEFINED_DATA_TYPE_CREATOR is
			-- WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR creator
		once
			create Result
		end

end -- class WIZARD_DATA_TYPE_DESCRIPTOR_FACTORY

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

