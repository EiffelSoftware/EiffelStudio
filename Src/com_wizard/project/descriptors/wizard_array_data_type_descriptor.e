indexing
	description: "Description of array data type"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR

inherit
	WIZARD_DATA_TYPE_DESCRIPTOR

create
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_ARRAY_DATA_TYPE_CREATOR) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		end

feature -- Access

	array_element_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Description of array element type

	dimension_count: INTEGER
			-- Count of array dimmentions

	array_size: ARRAY[INTEGER]
			-- size of array in each dimmention

feature -- Status report

	is_equal_data_type (other: WIZARD_DATA_TYPE_DESCRIPTOR): BOOLEAN is
			-- Is `other' describes same data type?
		local
			other_array: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR
		do
			other_array ?= other
			if other_array /= Void then
				Result := array_element_descriptor.is_equal_data_type (other_array.array_element_descriptor) and
					(dimension_count = other_array.dimension_count) and
					array_size.is_equal (other_array.array_size)				
			end
		end

feature -- Basic operations

	set_element_descriptor (a_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Set `array_element_descriptor' with `a_descriptor'
		require
			valid_descriptor: a_descriptor /= Void
		do
			array_element_descriptor := a_descriptor
		ensure
			element_descriptor_set: array_element_descriptor = a_descriptor
		end

	set_dimension_count (a_count: INTEGER) is
			-- Set `dimension_count' with `a_count'
		require
			valid_count: a_count /= 0
		do
			dimension_count := a_count
		ensure
			dimension_count_set: dimension_count = a_count
		end

	set_array_size (a_size: ARRAY[INTEGER]) is
			-- Set `array_size' with `a_size'
		require
			non_void_size: a_size /= Void
		do
			array_size := a_size
		ensure
			array_size_set: array_size = a_size
		end

feature -- Visitor

	visit (a_visitor: WIZARD_DATA_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_array_data_type (Current)
		end

end -- class WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR

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

