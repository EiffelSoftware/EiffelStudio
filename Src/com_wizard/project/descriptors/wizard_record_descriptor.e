indexing
	description: "Structure descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR
		redefine
			creation_message
		end

creation
	make

feature {NONE}-- Initialization

	make (a_creator: WIZARD_RECORD_DESCRIPTOR_CREATOR) is
			-- Initialize `fields'
			-- and `eiffel_class_name'
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure 
			non_void_fields: fields /= Void
			non_void_class_name: eiffel_class_name /= Void
			non_void_name: name /= Void
		end

feature -- Access

	fields: SORTED_TWO_WAY_LIST [WIZARD_RECORD_FIELD_DESCRIPTOR]
			-- Descriptions of structure's fields

	size_of_instance: INTEGER
			-- Size of instance of this type

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

	is_union: BOOLEAN
			-- Is union?

	creation_message: STRING is
			-- Creation message used for wizard output
		local
			l_description: STRING
			l_field: WIZARD_RECORD_FIELD_DESCRIPTOR
		do
			create Result.make (500)
			Result.append ("Added ")
			if is_union then
				Result.append ("Union ")
			else
				Result.append ("Record ")
			end
			Result.append (name)
			from 
				fields.start
				Result.append ("%R%N%T")
			until
				fields.after
			loop
				l_field := fields.item
				Result.append (l_field.name)
				Result.append (": ")
				Result.append (l_field.data_type.name)
				l_description := l_field.description
				if l_description /= Void and then not l_description.is_empty then
					Result.append ("%R%N%T%T%T-- ")
					Result.append (l_description)
				end
				Result.append ("%R%N%T")
				fields.forth
			end
		end

feature -- Basic operations

	set_fields (some_fields: SORTED_TWO_WAY_LIST [WIZARD_RECORD_FIELD_DESCRIPTOR]) is
			-- Set `fields' with `some_fields'.
		require
			valid_fields: some_fields /= Void
		do
			fields := some_fields
		ensure
			valid_fields: fields /= Void and fields = some_fields
		end

	set_size (a_size: INTEGER) is
			-- Set `size_of_instance' with `a_size'.
		do
			size_of_instance := a_size
		ensure
			valid_size: size_of_instance = a_size
		end

	set_type_library (a_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Set `type_library_descriptor' with `a_descriptor'
		require
			non_void_descriptor: a_descriptor /= Void
		do
			type_library_descriptor := a_descriptor
		ensure
			valid_type_library: type_library_descriptor = a_descriptor
		end

	set_is_union (a_boolean: BOOLEAN) is
			-- Set `is_union' with `a_boolean'.
		do
			is_union := a_boolean
		ensure
			valid_is_union: is_union = a_boolean
		end

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_record (Current)
		end

end -- class WIZARD_RECORD_DESCRIPTOR

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

