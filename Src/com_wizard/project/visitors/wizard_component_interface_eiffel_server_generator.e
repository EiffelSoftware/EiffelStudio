indexing
	description: "Processing interface for Eiffel server component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_INTERFACE_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_EIFFEL_GENERATOR

feature -- Basic operations

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		local
			a_prop_generator: WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR
		do
			create a_prop_generator.generate (component, a_property)
			add_property_features_to_class (a_prop_generator)
			add_property_rename (a_prop_generator)
		end


	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			a_func_generator: WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR
		do
			create a_func_generator.generate (component, a_function)
			add_feature_rename (a_func_generator)
			if not a_function.is_renaming_clause then
				add_feature_to_class (a_func_generator.feature_writer)
			end
		end

end -- class WIZARD_COMPONENT_INTERFACE_EIFFEL_SERVER_GENERATOR

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

