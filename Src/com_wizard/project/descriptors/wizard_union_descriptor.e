indexing
	description: "Union descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_UNION_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR


creation
	make

feature {NONE}-- Initialization

	make (a_creator: WIZARD_UNION_DESCRIPTOR_CREATOR) is
			-- Initialize `fields'
			-- and `eiffel_class_name'
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure 
			non_void_fields: fields /= Void
			non_void_class_name: eiffel_class_name /= Void
		end

feature -- Access

	fields: LINKED_LIST[WIZARD_RECORD_FIELD_DESCRIPTOR]
			-- Descriptions of structure's fields

	size_of_instance: INTEGER
			-- Size of instance of this type

	creation_message: STRING is
			-- Creation message for wizard output
		do
		end

feature -- Basic operations

	set_fields (some_fields: LINKED_LIST[WIZARD_RECORD_FIELD_DESCRIPTOR]) is
			--
		require
			valid_fields: some_fields /= Void
		do
			fields := some_fields
		ensure
			valid_fields: fields /= Void and fields = some_fields
		end

	set_size (a_size: INTEGER) is
			--
		do
			size_of_instance := a_size
		ensure
			valid_size: size_of_instance = a_size
		end


	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_union (Current)
		end

invariant
	valid_fields: fields /= Void

end -- class WIZARD_UNION_DESCRIPTOR

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

