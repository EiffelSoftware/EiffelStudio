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
			create Result.make (240)
			Result.append ("Added alias ")
			Result.append (name)
			Result.append (" for ")
			Result.append (type_descriptor.name)
			Result.append ("%R%N")
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

