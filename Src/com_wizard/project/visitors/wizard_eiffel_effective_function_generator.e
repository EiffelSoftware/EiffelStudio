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
			feature_generated: feature_writer /= Void
			valid_feature_writer: feature_writer.can_generate
			function_descriptor_set: func_desc /= Void
		end

end -- class WIZARD_EIFFEL_EFFECTIVE_FUNCTION_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
