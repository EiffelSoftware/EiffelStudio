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
			valid_type_desc_type: a_type_desc.var_type = Vt_ptr
		local
			descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
		do
			type := a_type_desc.var_type
			descriptor := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, 
						a_type_desc.type_desc, a_system_description)
			pointed_data_type_descriptor := descriptor

			create Result.make (Current)
		ensure
			valid_result: Result /= Void and then Result.type = Vt_ptr
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

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
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

