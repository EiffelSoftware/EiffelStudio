indexing
	description: "Alias c server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ALIAS_C_SERVER_GENERATOR

inherit
	WIZARD_ALIAS_C_GENERATOR
		redefine
			generate
		end


feature -- Access

	generate (a_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- Generate c server for alias.
		do
			Precursor (a_descriptor)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_alias_c_server
		end

			
end -- class WIZARD_ALIAS_C_SERVER_GENERATOR

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

