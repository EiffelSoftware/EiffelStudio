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

	ECOM_VAR_FLAGS
		export
			{NONE} all
		end

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; interface_name: STRING; lcid: INTEGER; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate C client access and setting features.
		require
			non_void_interface_name: interface_name /= Void
			non_void_descriptor: a_descriptor /= Void
			valid_interface_name: not interface_name.empty
		local
			tmp_string, access_feature_name, set_feature_name: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create visitor

			-- Access feature (get_  function)
			create c_access_feature.make

			if a_descriptor.coclass_eiffel_names.has (a_component_descriptor.name) then
				access_feature_name := clone (a_descriptor.coclass_eiffel_names.item (a_component_descriptor.name))
			else
				access_feature_name := a_descriptor.interface_eiffel_name
			end
			c_access_feature.set_name (external_feature_name (access_feature_name))

			visitor.visit (a_descriptor.data_type)
			if visitor.c_header_file /= Void and then not visitor.c_header_file.empty then
				set_header_file (visitor.c_header_file)
			end

			-- Set result type
			if visitor.is_basic_type or (visitor.vt_type = Vt_bool) or visitor.is_enumeration then
				c_access_feature.set_result_type (visitor.cecil_type)
			else
				c_access_feature.set_result_type (Eif_reference)
			end

			-- Set comment
			c_access_feature.set_comment (a_descriptor.description)

			-- Set c access body
			set_access_body (interface_name, lcid, a_descriptor.member_id, a_descriptor.data_type.type, visitor)

				-- Setting function
			if not is_varflag_freadonly (a_descriptor.var_flags) then
				create c_setting_feature.make
				set_feature_name := clone (Set_clause)
				set_feature_name.append (access_feature_name)
				c_setting_feature.set_name (external_feature_name (set_feature_name))

				-- Set comment
				tmp_string := clone (a_descriptor.description)
				tmp_string.prepend ("Set ")
				c_setting_feature.set_comment (tmp_string)

				-- Set signature
				if visitor.is_basic_type or (visitor.vt_type = Vt_bool) or visitor.is_enumeration then
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
			end
		ensure
			c_access_feature_exist: c_access_feature /= Void
			c_setting_feature_exist: not is_varflag_freadonly (a_descriptor.var_flags) implies (c_setting_feature /= Void)
		end

end -- class WIZARD_CPP_CLIENT_PROPERTY_GENERATOR

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
