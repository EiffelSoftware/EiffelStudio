indexing
	description: "Creator of Array descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ARRAY_DATA_TYPE_CREATOR

inherit
	WIZARD_DATA_TYPE_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; a_type_desc: ECOM_TYPE_DESC; 
				a_system_description: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR is
			-- Create descriptor
		require
			valid_type_desc: a_type_desc /= Void
			valid_type_desc_type: is_carray (a_type_desc.var_type)
		local
			descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			array_desc: ECOM_ARRAY_DESC
			i, an_element: INTEGER
			int_array: ARRAY [INTEGER]
		do
			type := a_type_desc.var_type
			descriptor := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, 
						a_type_desc.array_desc.type_desc, a_system_description)
			array_element_descriptor := descriptor

			array_desc := a_type_desc.array_desc
			dimension_count := array_desc.count_dimension

			create int_array.make (1, dimension_count)
			from
				i := 1
			variant
				dimension_count - i + 1
			until
				i > dimension_count
			loop
				an_element := array_desc.bounds.item(i).element_count
				int_array.put (an_element, i)
				i := i + 1

			end
			array_size := int_array

			create Result.make (Current)
		ensure
			non_void_descriptor: Result /= Void
			valid_descriptor: is_carray (Result.type)
			non_void_element_descriptor: Result.array_element_descriptor /= Void
			non_void_array_size: array_size /= Void
			valid_array_size: array_size.count = dimension_count
		end

	initialize_descriptor (a_descriptor: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR) is
			-- Initialize `a_descriptor' attributes
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_type (type)
			a_descriptor.set_element_descriptor (array_element_descriptor)
			a_descriptor.set_dimension_count (dimension_count)
			a_descriptor.set_array_size (array_size)
		end

feature {NONE} -- Implementation

	array_element_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Description of array element type

	dimension_count: INTEGER
			-- Count of array dimmentions

	array_size: ARRAY[INTEGER]
			-- size of array in each dimmention

end -- class WIZARD_ARRAY_DATA_TYPE_CREATOR
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

