indexing
	description: "Description of pointer data type"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_POINTED_DATA_TYPE_DESCRIPTOR

inherit
	WIZARD_DATA_TYPE_DESCRIPTOR

	ECOM_TYPE_KIND
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_POINTED_DATA_TYPE_CREATOR) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure
			non_void_pointed_descriptor: pointed_data_type_descriptor /= Void
			non_void_type: type /= Void
		end

feature -- Access
	
	pointed_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Description of array element type

feature -- Status report

	is_equal_data_type (other: WIZARD_DATA_TYPE_DESCRIPTOR): BOOLEAN is
			-- Is `other' describes same data type?
		local
			other_pointed: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			other_pointed ?= other
			if other_pointed /= Void then
				Result := pointed_data_type_descriptor.is_equal_data_type (other_pointed.pointed_data_type_descriptor)
			end
		end

feature -- Basic operations

	set_pointed_descriptor (a_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Set `pointed_data_type_descriptor'
		require
			valid_descriptor: a_descriptor /= Void
		do
			pointed_data_type_descriptor := a_descriptor
		ensure
			pointed_set: pointed_data_type_descriptor = a_descriptor
		end

feature -- Visitor

	visit (a_visitor: WIZARD_DATA_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_pointed_data_type (Current)
		end

end -- class WIZARD_POINTED_DATA_TYPE_DESCRIPTOR

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

