indexing
	description: "C client property generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_CLIENT_PROPERTY_GENERATOR

inherit
	WIZARD_CPP_PROPERTY_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Basic operations

	generate (interface_name: STRING; lcid: INTEGER; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate C client access and setting features.
		require
			non_void_interface_name: interface_name /= Void
			non_void_descriptor: a_descriptor /= Void
			valid_interface_name: not interface_name.empty
		local
			tmp_string: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create c_access_feature.make
			create c_setting_feature.make
			create visitor

			-- Access feature (get_  function)
			tmp_string := external_feature_name (a_descriptor.name)
			c_access_feature.set_name (tmp_string)

			visitor.visit (a_descriptor.data_type)
			if visitor.c_header_file /= Void and then not visitor.c_header_file.empty then
				set_header_file (visitor.c_header_file)
			end

			-- Set result type
			if visitor.is_basic_type then
				c_access_feature.set_result_type (visitor.cecil_type)
			else
				c_access_feature.set_result_type (Eif_reference)
			end

			-- Set comment
			c_access_feature.set_comment (a_descriptor.description)

			-- Set c access body
			set_access_body (interface_name, lcid, a_descriptor.member_id, a_descriptor.data_type.type, visitor)

			-- Setting function
			tmp_string := clone (Ccom_clause)
			tmp_string.append (Set_clause)
			tmp_string.append (name_for_feature (a_descriptor.name))
			c_setting_feature.set_name (tmp_string)

			-- Set comment
			tmp_string := clone (a_descriptor.description)
			tmp_string.prepend ("Set ")
			c_setting_feature.set_comment (tmp_string)
	
			-- Set signature
			if visitor.is_basic_type then
				tmp_string := clone (visitor.cecil_type)

			elseif visitor.is_structure or visitor.is_array_basic_type or
					visitor.is_interface then
				tmp_string := clone (visitor.c_type)
				tmp_string.append (Space)
				tmp_string.append (Asterisk)
			elseif 
				visitor.is_structure_pointer or 
				visitor.is_interface_pointer or
				visitor.is_coclass_pointer 
			then
				tmp_string := clone (visitor.c_type)

			else
				tmp_string := clone (Eif_object)
			end
			tmp_string.append (Space)
			tmp_string.append (Argument_name)
			c_setting_feature.set_signature (tmp_string)
			c_setting_feature.set_result_type ("void")

			-- Set setting feature body
			set_setting_body (interface_name, lcid, a_descriptor.member_id, visitor)
		ensure
			c_access_feature_exist: c_access_feature /= Void
			c_setting_feature_exist: c_setting_feature /= Void
		end

end -- class WIZARD_C_CLIENT_PROPERTY_GENERATOR

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
