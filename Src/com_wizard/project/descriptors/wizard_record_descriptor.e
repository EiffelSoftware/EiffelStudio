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

	fields: SORTED_TWO_WAY_LIST[WIZARD_RECORD_FIELD_DESCRIPTOR]
			-- Descriptions of structure's fields

	size_of_instance: INTEGER
			-- Size of instance of this type

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

	creation_message: STRING is
			-- Creation message used for wizard output
		do
			Result := clone (Added)
			Result.append (Space)
			Result.append (Record)
			Result.append (Space)
			Result.append (Name)
			from 
				fields.start
				Result.append (New_line_tab)
			until
				fields.after
			loop
				Result.append (fields.item.name)
				Result.append (Colon)
				Result.append (Space)
				Result.append (fields.item.data_type.name)
				Result.append (New_line_tab_tab_tab)
				Result.append (Double_dash)
				Result.append (Space)
				Result.append (fields.item.description)
				Result.append (New_line_tab)
				fields.forth
			end
		end

feature -- Basic operations

	set_fields (some_fields: SORTED_TWO_WAY_LIST[WIZARD_RECORD_FIELD_DESCRIPTOR]) is
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

	set_type_library (a_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Set `type_library_descriptor' with `a_descriptor'
		require
			non_void_descriptor: a_descriptor /= Void
		do
			type_library_descriptor := a_descriptor
		ensure
			valid_type_library: type_library_descriptor = a_descriptor
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

