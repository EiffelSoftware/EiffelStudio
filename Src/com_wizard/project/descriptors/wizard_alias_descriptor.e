indexing
	description: "Alias descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ALIAS_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR

creation
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_ALIAS_DESCRIPTOR_CREATOR) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure 
			non_void_type_descriptor: type_descriptor /= Void
		end

feature -- Access

	type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Description of data type to which this type is alias

	creation_message: STRING is
			-- Creation message for wizard output
		do
			Result := clone (Added)
			Result.append (Space)
			Result.append (Alias_keyword)
			Result.append (Space)
			Result.append (name)
			Result.append (Space)
			Result.append (For)
			Result.append (Space)
			Result.append (type_descriptor.name)
		end

feature -- Basic operations

	set_type_descriptor (a_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Set `type_descriptor' with `a_type_descriptor'.
		require
			valid_type_descriptor: a_type_descriptor /= Void
		do
			type_descriptor := a_type_descriptor
		ensure
			valid_type_descriptor: type_descriptor /= Void and type_descriptor = a_type_descriptor
		end

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_alias (Current)
		end

end -- class WIZARD_ALIAS_DESCRIPTOR

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

