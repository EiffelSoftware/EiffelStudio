indexing
	description: "Processing interface for Eiffel server coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_EIFFEL_SERVER_GENERATOR
		redefine
			process_property,
			process_function
		end

create
	make

feature -- Basic operations

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		local
			a_prop_generator: WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR
		do
			create a_prop_generator.generate (component, a_property)
			add_property_rename (a_prop_generator)
		end


	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			a_func_generator: WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR
		do
			if not a_function.is_renaming_clause then
				create a_func_generator.generate (component, a_function)
				add_feature_rename (a_func_generator)
			end
		end

end -- class WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_GENERATOR

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

