indexing
	description: "Eiffel effective function generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_EIFFEL_EFFECTIVE_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_FUNCTION_GENERATOR


feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate server feature signature.
		require
			non_void_component: a_component_descriptor /= Void
			non_void_class_name: a_component_descriptor.name /= Void
			valid_coclass_name: not a_component_descriptor.name.is_empty
			non_void_descriptor: a_descriptor /= Void
		deferred
		ensure 
			feature_generated: not a_descriptor.is_renaming_clause implies feature_writer /= Void
			valid_feature_writer: not a_descriptor.is_renaming_clause implies feature_writer.can_generate
			function_descriptor_set: not a_descriptor.is_renaming_clause implies func_desc /= Void
		end

end -- class WIZARD_EIFFEL_EFFECTIVE_FUNCTION_GENERATOR

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

