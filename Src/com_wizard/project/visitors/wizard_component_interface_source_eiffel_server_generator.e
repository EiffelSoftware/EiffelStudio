indexing
	description: "Processing source interface for Eiffel component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_INTERFACE_SOURCE_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_EIFFEL_SERVER_GENERATOR
		redefine
			process_function
		end

feature -- Basic operations

	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			a_func_generator: WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR
		do
			if not a_function.is_renaming_clause then
				create a_func_generator.generate_source (a_function)
				add_feature_to_class (a_func_generator.feature_writer)
	
				create a_func_generator.generate_on_hook (a_function)
				add_feature_to_class (a_func_generator.feature_writer)
			end
		end

end -- class WIZARD_COMPONENT_INTERFACE_SOURCE_EIFFEL_SERVER_GENERATOR

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

