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
			setting_feature_exist: not a_descriptor.is_read_only implies setting_feature /= Void
		end


end -- class WIZARD_EIFFEL_EFFECTIVE_PROPERTY_GENERATOR

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

