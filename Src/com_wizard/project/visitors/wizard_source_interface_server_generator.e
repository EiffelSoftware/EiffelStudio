indexing
	description: "Objects that ..."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SOURCE_INTERFACE_SERVER_GENERATOR

inherit
	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Basic operations

	add_feature_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Name of add call-back interface feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make (100)
			Result.append ("add_")
			Result.append (name_for_feature (an_interface.name))
			Result.append ("_call_back")
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

	remove_feature_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Name of remove call-back interface feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make (100)
			Result.append ("remove_")
			Result.append (name_for_feature (an_interface.name))
			Result.append ("_call_back")
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

	has_feature_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Name of has call-back feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make (100)
			Result.append ("has_")
			Result.append (name_for_feature (an_interface.name))
			Result.append ("_call_back")
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end
		
end -- class WIZARD_SOURCE_INTERFACE_SERVER_GENERATOR

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

