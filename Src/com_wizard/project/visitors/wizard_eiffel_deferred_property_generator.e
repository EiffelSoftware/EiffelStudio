indexing
	description: "Generate deferred features from property"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_DEFERRED_PROPERTY_GENERATOR

inherit
	WIZARD_EIFFEL_PROPERTY_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

	WIZARD_EIFFEL_DEFERRED_FEATURE_GENERATOR

feature -- Access

	precondition_access_feature_writer: WIZARD_WRITER_FEATURE

	precondition_set_feature_writer: WIZARD_WRITER_FEATURE

feature -- Basic operations

	generate (a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate deferred access and setting features from property.
		require
			non_void_descriptor: a_descriptor /= Void
		local
			tmp_string, tmp_tag, tmp_body: STRING
			tmp_assertion: WIZARD_WRITER_ASSERTION
			flags: ECOM_PARAM_FLAGS
			visitor: WIZARD_DATA_TYPE_VISITOR
			an_access_name, a_set_name: STRING
		do
			create access_feature.make
			create setting_feature.make
			create precondition_access_feature_writer.make
			create precondition_set_feature_writer.make

			create visitor

			an_access_name := clone (a_descriptor.interface_eiffel_name)
			access_feature.set_name (an_access_name)

			visitor.visit (a_descriptor.data_type)
			access_feature.set_result_type (visitor.eiffel_type)
			access_feature.set_comment (a_descriptor.description)
			access_feature.set_deferred
			access_feature.add_precondition (user_defined_precondition (an_access_name))
			set_precondition_feature_writer (precondition_access_feature_writer, an_access_name)

			-- Setting feature name
			a_set_name := clone (Set_clause)
			a_set_name.append (a_descriptor.interface_eiffel_name)
			setting_feature.set_name (a_set_name)

			-- Set arguments
			tmp_string := clone (Argument_name)
			tmp_string.append (Colon)
			tmp_string.append (Space)
			tmp_string.append (visitor.eiffel_type)
			setting_feature.add_argument (tmp_string)

			-- Set description
			tmp_string := "Set %'"
			tmp_string.append (an_access_name)
			tmp_string.append ("%' with %'an_item%'")
			setting_feature.set_comment (tmp_string)
			
			-- Set pre-condition
			if not visitor.is_basic_type then
				generate_precondition (An_item_variable, a_descriptor.data_type, True, False)
				if not assertions.empty then
					from 
						assertions.start
					until
						assertions.off
					loop
						setting_feature.add_precondition (assertions.item)
						assertions.forth
					end
				else
					add_warning (Current, cannot_generate_precondition);
				end
			end
			setting_feature.set_deferred
			setting_feature.add_precondition (user_defined_precondition (a_set_name))
			set_precondition_feature_writer (precondition_set_feature_writer, a_set_name)
			precondition_set_feature_writer.arguments.append (clone (setting_feature.arguments))

		ensure
			access_feature_exist: access_feature /= Void
			setting_feature_exist: setting_feature /= Void			
		end

end -- class WIZARD_EIFFEL_DEFERRED_PROPERTY_GENERATOR

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
