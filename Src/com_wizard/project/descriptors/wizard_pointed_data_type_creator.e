indexing
	description: "Creator of Pointed Type Descriptors"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_POINTED_DATA_TYPE_CREATOR

inherit
	WIZARD_DATA_TYPE_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; a_type_desc: ECOM_TYPE_DESC; 
				a_system_description: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_POINTED_DATA_TYPE_DESCRIPTOR is
		require
			valid_type_desc: a_type_desc /= Void
			valid_type_desc_type: is_ptr (a_type_desc.var_type)
		do
			type := a_type_desc.var_type
			pointed_data_type_descriptor := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, 
						a_type_desc.type_desc, a_system_description)
			create Result.make (Current)
		ensure
			valid_result: Result /= Void and then is_ptr (Result.type)
		end

	initialize_descriptor (a_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR) is
			-- Initialize `a_descriptor' attributes.
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_type (type)
			a_descriptor.set_pointed_descriptor (pointed_data_type_descriptor)
		end

feature {NONE} -- Implementation

	pointed_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Description of array element type

end -- class WIZARD_POINTED_DATA_TYPE_CREATOR

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

