indexing
	description: "Processing interface for Eiffel client component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_INTERFACE_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_EIFFEL_GENERATOR

create
	make

feature -- Basic operations

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		local
			l_generator: WIZARD_EIFFEL_CLIENT_PROPERTY_GENERATOR
		do
			create l_generator.generate (component, a_property)
			add_property_features_to_class (l_generator)
			add_property_rename (l_generator)
		end

	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			l_generator: WIZARD_EIFFEL_CLIENT_FUNCTION_GENERATOR
		do
			create l_generator.generate (component, a_function)
			add_feature_rename (l_generator)
			if not a_function.is_renaming_clause then
				add_feature_to_class (l_generator.feature_writer)
				eiffel_writer.add_feature (l_generator.external_feature_writer, Externals)
			end
		end

end -- class WIZARD_COMPONENT_INTERFACE_EIFFEL_CLIENT_GENERATOR

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

