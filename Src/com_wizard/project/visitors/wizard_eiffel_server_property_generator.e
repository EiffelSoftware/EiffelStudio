indexing
	description: ""
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR

inherit
	WIZARD_EIFFEL_PROPERTY_GENERATOR

feature -- Basic operations

	generate (coclass_name: STRING; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate access and setting features from property.
		require
			non_void_coclass_name: coclass_name /= Void
			non_void_descriptor: a_descriptor /= Void
		local
			access_name, setting_name, tmp_string: STRING
			tmp_assertion: WIZARD_WRITER_ASSERTION
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create access_feature.make
			create setting_feature.make
			create changed_names.make (2)
			create visitor

			if a_descriptor.coclass_eiffel_names.has (coclass_name) then
				property_renamed := True
				access_name := a_descriptor.coclass_eiffel_names.item (coclass_name)
				changed_names.put (access_name, a_descriptor.interface_eiffel_name)

				tmp_string := clone (Set_clause)
				tmp_string.append (a_descriptor.interface_eiffel_name)

				setting_name := clone (Set_clause)
				setting_name.append (access_name)
				changed_names.put (setting_name, tmp_string)
			else
				access_name := a_descriptor.interface_eiffel_name
				setting_name := clone (Set_clause)
				setting_name.append (access_name)
			end
		
			access_feature.set_name (access_name)
			visitor.visit (a_descriptor.data_type)

			access_feature.set_result_type (visitor.eiffel_type)
			access_feature.set_comment (a_descriptor.description)
			access_feature.set_attribute

			-- Setting feature name
			setting_feature.set_name (setting_name)

			-- Set arguments
			tmp_string := clone (An_item_variable)
			tmp_string.append (Colon)
			tmp_string.append (Space)
			tmp_string.append (visitor.eiffel_type)
			setting_feature.add_argument (tmp_string)

			-- Set description
			tmp_string := "Set %'"
			tmp_string.append (access_name)
			tmp_string.append ("%' with %'an_item%'")
			setting_feature.set_comment (tmp_string)
			
			setting_feature.set_effective
			setting_feature.set_body (Empty_function_body)
		ensure
			access_feature_exist: access_feature /= Void
			setting_feature_exist: setting_feature /= Void			
		end

end -- class WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR

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
