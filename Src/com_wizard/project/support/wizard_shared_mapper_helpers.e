indexing
	description: "Shared Generators."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_MAPPER_HELPERS

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

feature -- Access

	Ecom_generated_rt_globals_header_file_name: STRING is 
			-- C++ class header file contains information that all generated class require
			-- e.g. global variables, system header files etc.
		once
			Result := "ecom_grt_globals_" + environment.project_name
			if environment.is_client then
				Result.append ("_c")
			end
			Result.append (".h")
		end

	Generated_ec_mappers: LIST [WIZARD_WRITER_MAPPER_CLASS] is 
			-- C++ classes holding generated Eiffel to C mappers
		once
			create {ARRAYED_LIST [WIZARD_WRITER_MAPPER_CLASS]} Result.make (5)
		end

	Generated_ce_mappers: LIST [WIZARD_WRITER_MAPPER_CLASS] is 
			-- C++ classes holding generated C to Eiffel mappers
		once
			create {ARRAYED_LIST [WIZARD_WRITER_MAPPER_CLASS]} Result.make (5)
		end

	Alias_c_writer: WIZARD_WRITER_C_FILE is
			-- Shared alias C writer.
		do
			Result := Alias_c_writer_cell.item
		end

	set_alias_c_writer (a_writer: WIZARD_WRITER_C_FILE) is
			-- Set `Alias_c_writer).
		do
			Alias_c_writer_cell.put (a_writer)
		end

	create_alias_c_writer is
			--
		local
			a_writer: WIZARD_WRITER_C_FILE
		do
			create a_writer.make
			a_writer.set_header_file_name ("ecom_aliases.h")
			a_writer.set_header ("System's aliases")
			set_alias_c_writer (a_writer)
		end

feature {NONE} -- Implementation

	Alias_c_writer_cell: CELL [WIZARD_WRITER_C_FILE] is
			-- C writer of Alias.
		once
			create Result.put (Void)
		end

end -- class WIZARD_SHARED_MAPPER_HELPERS

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
