indexing
	description: "Component"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR
		rename
			c_header_file_name as c_definition_header_file_name
		end

feature -- Access

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

	c_declaration_header_file_name: STRING
			-- C declaration header file name

feature -- Element Change

	set_c_declaration_header_file_name (a_name: STRING) is
			-- Set `c_declaration_header_file_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			c_declaration_header_file_name := a_name
		ensure
			c_declaration_header_file_name_set: c_declaration_header_file_name = a_name
		end
		
	set_type_library (a_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Set `type_library_descriptor' with `a_descriptor'.
		require
			non_void_descriptor: a_descriptor /= Void
		do
			type_library_descriptor := a_descriptor
		ensure
			valid_type_library: type_library_descriptor = a_descriptor
		end

end -- class WIZARD_COMPONENT_DESCRIPTOR

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

