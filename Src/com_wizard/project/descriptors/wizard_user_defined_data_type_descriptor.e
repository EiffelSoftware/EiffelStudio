indexing
	description: "Description of user defined data type"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR

inherit
	WIZARD_DATA_TYPE_DESCRIPTOR

create
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_USER_DEFINED_DATA_TYPE_CREATOR) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
			library_descriptor.add_referee (Current, type_descriptor_index)
		ensure
			non_void_descriptor: library_descriptor /= Void
			valid_reference: type_descriptor_index /= 0
			user_defined_type: is_user_defined (type)
		end

feature -- Access

	type_descriptor_index: INTEGER 
			-- Index of type_descriptor in `descriptors' array
			-- of WIZARD_TYPE_LIBRARY_DESCRIPTOR

	library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Description of type library

feature -- Status report

	is_equal_data_type (other: WIZARD_DATA_TYPE_DESCRIPTOR): BOOLEAN is
			-- Is `other' describes same data type?
		local
			other_user_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
		do
			other_user_descriptor ?= other
			if other_user_descriptor /= Void then
				Result := library_descriptor.is_equal (other_user_descriptor.library_descriptor) and
					type_descriptor_index = other_user_descriptor.type_descriptor_index
			end
		end

feature -- Basic operations

	set_type_descriptor_index (an_index: INTEGER) is
			-- Set `type_descriptor_index' with `an_index'
		require
			valid_index: an_index /= 0
		do
			type_descriptor_index := an_index
		ensure
			valid_index: type_descriptor_index = an_index
		end

	set_library_descriptor (a_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- 
		require
			valid_descriptor: a_library_descriptor /= Void
		do
			library_descriptor := a_library_descriptor
		ensure
			descriptor_set: library_descriptor = a_library_descriptor
		end

feature -- Visitor

	visit (a_visitor: WIZARD_DATA_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_user_defined_data_type (Current)
		end

end -- class WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR

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

