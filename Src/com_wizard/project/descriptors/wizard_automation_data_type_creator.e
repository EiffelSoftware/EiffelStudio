indexing
	description: "Creator of Automation data type descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_AUTOMATION_DATA_TYPE_CREATOR

inherit
	WIZARD_DATA_TYPE_CREATOR

feature -- Basic operations

	create_descriptor (a_type_desc: ECOM_TYPE_DESC): WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR is
			-- Create Automation Basic type descriptor
		require
			valid_type_desc: a_type_desc /= Void
			valid_type_desc_type: a_type_desc.var_type /= Vt_ptr and 
							a_type_desc.var_type /= Vt_safearray and
							a_type_desc.var_type /= Vt_carray and
							a_type_desc.var_type /= Vt_userdefined
		do
			create Result
			Result.set_type (a_type_desc.var_type)
		ensure
			valid_result: Result /= Void and then Result.type = a_type_desc.var_type
		end

end -- class WIZARD_AUTOMATION_DATA_TYPE_CREATOR

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

