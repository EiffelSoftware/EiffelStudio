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

	fields: LIST [WIZARD_RECORD_FIELD_DESCRIPTOR]
			-- Descriptions of structure's fields

	size_of_instance: INTEGER
			-- Size of instance of this type

	creation_message: STRING is
			-- Creation message for wizard output
		do
		end

feature -- Basic operations

	set_fields (some_fields: LIST [WIZARD_RECORD_FIELD_DESCRIPTOR]) is
			-- Set `fields' with `some_fields'.
		require
			valid_fields: some_fields /= Void
		do
			fields := some_fields
		ensure
			fields_set: fields /= Void and fields = some_fields
		end

	set_size (a_size: INTEGER) is
			-- Set `size_of_instance' with `a_size'.
		do
			size_of_instance := a_size
		ensure
			size_set: size_of_instance = a_size
		end

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_union (Current)
		end

invariant
	valid_fields: fields /= Void

end -- class WIZARD_UNION_DESCRIPTOR

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

