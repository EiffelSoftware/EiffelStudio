indexing
	description: "Objects that ..."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_EIFFEL_EFFECTIVE_PROPERTY_GENERATOR

inherit
	WIZARD_EIFFEL_PROPERTY_GENERATOR

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate access and setting features from property.
		require
			non_void_component: a_component_descriptor /= Void
			non_void_class_name: a_component_descriptor.eiffel_class_name /= Void
			valid_coclass_name: not a_component_descriptor.eiffel_class_name.is_empty
			non_void_descriptor: a_descriptor /= Void
		deferred
		ensure
			access_feature_exist: access_feature /= Void
			setting_feature_exist: not is_varflag_freadonly (a_descriptor.var_flags)  implies (setting_feature /= Void)
		end


end -- class WIZARD_EIFFEL_EFFECTIVE_PROPERTY_GENERATOR

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
