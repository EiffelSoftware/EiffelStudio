indexing

	description: "Type generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_TYPE_GENERATOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_MAPPER_HELPERS
		export
			{NONE} all
		end

feature -- Basic Operations

	generate (a_descriptor: WIZARD_TYPE_DESCRIPTOR) is
			-- Generated writer
		require
			non_void_descriptor: a_descriptor /= Void
		deferred
		end

	create_file_name (a_file_name_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Get file name.
		require
			non_void_file_name_factory: a_file_name_factory /= Void
		deferred
		end

end -- class WIZARD_TYPE_GENERATOR

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

