indexing
	description: "Source interface client generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SOURCE_INTERFACE_CLIENT_GENERATOR

inherit
	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Basic operations

	enable_feature_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Name of enable call back feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make (100)
			Result.append ("enable_call_back_on_")
			Result.append (name_for_feature (an_interface.name))
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

	disable_feature_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Name of disable call back feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make (100)
			Result.append ("disable_call_back_on_")
			Result.append (name_for_feature (an_interface.name))
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end


end -- class WIZARD_SOURCE_INTERFACE_CLIENT_GENERATOR

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
