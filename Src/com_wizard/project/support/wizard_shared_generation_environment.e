indexing
	description: "Shared generation environment"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_GENERATION_ENVIRONMENT

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Access

	Shared_file_name_factory: WIZARD_FILE_NAME_FACTORY is
			-- Shared file name factory.
		once
			create Result
		end

	system_descriptor: WIZARD_SYSTEM_DESCRIPTOR is
			-- System descriptor.
		do
			Result := System_descriptor_cell.item
		end

	vartype_namer: WIZARD_VARTYPE_NAMER is
			-- Vartype to string mapper
		once
			create Result.make
		end

	compiler: WIZARD_COMPILER is
			-- IDL/C compiler
		once
			create Result
		end
		
	Formatter: STRING is "f"
			-- Message formatter.

	Generation_Successful: STRING is "Generation terminated successfully"
			-- Successful ending message

	Generation_Aborted: STRING is "Generation aborted"
			-- Successful ending message

feature {WIZARD_MANAGER} -- Element Change

	set_system_descriptor (a_descriptor: like system_descriptor) is
			-- Set `system_descriptor' with `a_descriptor'.
		do
			System_descriptor_cell.replace (a_descriptor)
		ensure
			descriptor_set: system_descriptor = a_descriptor
		end

feature {NONE} -- Implementation

	System_descriptor_cell: CELL [WIZARD_SYSTEM_DESCRIPTOR] is
			-- System descriptor shell
		once
			create Result.put (Void)
		end

end -- class WIZARD_SHARED_GENERATION_ENVIRONMENT

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
