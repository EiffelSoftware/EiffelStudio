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

	ECOM_VAR_FLAGS
		export
			{NONE} all
		end

create
	generate

feature -- Access

	precondition_access_feature_writer: WIZARD_WRITER_FEATURE

	precondition_set_feature_writer: WIZARD_WRITER_FEATURE

feature -- Basic operations

	generate (a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate deferred access and setting features from property.
		local
			tmp_body: STRING
			tmp_assertion: WIZARD_WRITER_ASSERTION
			visitor: WIZARD_DATA_TYPE_VISITOR
			an_access_name, a_set_name, an_argument, a_comment: STRING
		do
			create access_feature.make
			create precondition_access_feature_writer.make

			create an_access_name.make (100)
			an_access_name.append (a_descriptor.interface_eiffel_name)
			access_feature.set_name (an_access_name)

			visitor := a_descriptor.data_type.visitor 
			access_feature.set_result_type (visitor.eiffel_type)
			access_feature.set_comment (a_descriptor.description)
			access_feature.set_deferred
			access_feature.add_precondition (user_defined_precondition (an_access_name))
			set_precondition_feature_writer (precondition_access_feature_writer, an_access_name)

			-- Setting feature name
			if not is_varflag_freadonly (a_descriptor.var_flags) then
				create setting_feature.make
				create precondition_set_feature_writer.make

				create a_set_name.make (100)
				a_set_name.append (Set_clause)
				a_set_name.append (a_descriptor.interface_eiffel_name)
				setting_feature.set_name (a_set_name)

				-- Set arguments
				create an_argument.make (100)
				an_argument.append (Argument_name)
				an_argument.append (Colon)
				an_argument.append (Space)
				an_argument.append (visitor.eiffel_type)
				setting_feature.add_argument (an_argument)

				-- Set description
				create a_comment.make (100)
				a_comment.append ("Set %'")
				a_comment.append (an_access_name)
				a_comment.append ("%' with %'an_item%'")
				setting_feature.set_comment (a_comment)

				-- Set pre-condition
				if not visitor.is_basic_type then
					generate_precondition (Argument_name, a_descriptor.data_type, True, False)
					if not assertions.empty then
						from 
							assertions.start
						until
							assertions.off
						loop
							setting_feature.add_precondition (assertions.item)
							assertions.forth
						end
					end
				end
				setting_feature.set_deferred
				tmp_assertion := user_defined_precondition (a_set_name)
				
				create tmp_body.make (100)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Argument_name)
				tmp_body.append (Close_parenthesis)
				tmp_assertion.body.append (tmp_body)
				setting_feature.add_precondition (tmp_assertion)
				set_precondition_feature_writer (precondition_set_feature_writer, a_set_name)
				precondition_set_feature_writer.arguments.append (clone (setting_feature.arguments))
			end
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
