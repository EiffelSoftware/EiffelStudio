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

	Generated_ec_mapper: STRING is 
			-- C++ class holding generated Eiffel to C mappers
		once
			Result := "grt_ec_" + environment.project_name
			if environment.is_client then
				Result.append ("_c")
			end
		end

	Generated_ce_mapper: STRING is 
			-- C++ class holding generated C to Eiffel mappers, object name.
		once
			Result := "grt_ce_" + environment.project_name
			if environment.is_client then
				Result.append ("_c")
			end
		end

	Generated_ec_class_name: STRING is 
			-- C++ class name for generated mapper functions Eiffel to C.
		once
			Result := "ecom_gec_" + environment.project_name
			if environment.is_client then
				Result.append ("_c")
			end
		end
		
	Generated_ce_class_name: STRING is 
			-- C++ class name for generated mapper functions C to Eiffel.
		once
			Result := "ecom_gce_" + environment.project_name
			if environment.is_client then
				Result.append ("_c")
			end
		end

	Generated_ce_mapper_writer: WIZARD_WRITER_CPP_CLASS is
			-- Writer for generated C to Eiffel mappers class.
		do
			Result := Generated_ce_mapper_writer_cell.item
		end

	set_generated_ce_mapper (a_mapper: WIZARD_WRITER_CPP_CLASS) is
			-- Set generated CE mapper.
		do
			Generated_ce_mapper_writer_cell.put (a_mapper)
		end

	create_generated_ce_mapper is
			-- Create generated CE mapper.
		local
			a_header_file_name: STRING
			a_constructor: WIZARD_WRITER_CPP_CONSTRUCTOR
			empty_string: STRING
			an_other_source: STRING
			mapper: WIZARD_WRITER_CPP_CLASS
		do
			create mapper.make
			mapper.set_header ("Writer for generated C to Eiffel mappers class")
			a_header_file_name := Generated_ce_class_name.twin
			mapper.set_name (a_header_file_name.twin)
			a_header_file_name.append (Header_file_extension)
			mapper.set_definition_header_file_name (a_header_file_name)
			create a_constructor.make
			create empty_string.make (0)
			a_constructor.set_signature (empty_string)
			a_constructor.set_body (empty_string)
			mapper.add_constructor (a_constructor)
			mapper.add_import ("ecom_rt_globals.h")
			mapper.add_import_after (Ecom_generated_rt_globals_header_file_name)
			create an_other_source.make (100)
			an_other_source.append (Generated_ce_class_name)
			an_other_source.append (Space)
			an_other_source.append (Generated_ce_mapper)
			an_other_source.append (Semicolon)
			mapper.add_other_source (an_other_source)
			set_generated_ce_mapper (mapper)
		end

	Generated_ec_mapper_writer: WIZARD_WRITER_CPP_CLASS is
			-- Writer for generated Eiffel to C mappers class.
		do
			Result := Generated_ec_mapper_writer_cell.item
		end

	set_generated_ec_mapper (a_mapper: WIZARD_WRITER_CPP_CLASS) is
			-- Set generated Eiffel to C mapper.
		do
			Generated_ec_mapper_writer_cell.put (a_mapper)
		end

	create_generated_ec_mapper is
			-- Writer for generated Eiffel to C mappers class
		local
			a_header_file_name: STRING
			a_constructor: WIZARD_WRITER_CPP_CONSTRUCTOR
			empty_string: STRING
			an_other_source: STRING
			mapper: WIZARD_WRITER_CPP_CLASS
		do
			create mapper.make
			mapper.set_header ("Writer for generated Eiffel to C mappers class")
			a_header_file_name := Generated_ec_class_name.twin
			mapper.set_name (a_header_file_name.twin)
			a_header_file_name.append (Header_file_extension)
			mapper.set_definition_header_file_name (a_header_file_name)
			create a_constructor.make
			create empty_string.make (0)
			a_constructor.set_signature (empty_string)
			a_constructor.set_body (empty_string)
			mapper.add_constructor (a_constructor)
			mapper.add_import ("ecom_rt_globals.h")
			mapper.add_import_after (Ecom_generated_rt_globals_header_file_name)
			create an_other_source.make (100)
			an_other_source.append (Generated_ec_class_name)
			an_other_source.append (Space)
			an_other_source.append (Generated_ec_mapper)
			an_other_source.append (Semicolon)
			mapper.add_other_source (an_other_source)
			set_generated_ec_mapper (mapper)
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

	Generated_ce_mapper_writer_cell: CELL [WIZARD_WRITER_CPP_CLASS] is
			-- Generated CE mapper shell.
		once
			create Result.put (Void)
		end

	Generated_ec_mapper_writer_cell: CELL [WIZARD_WRITER_CPP_CLASS] is
			-- Generated EC mapper shell.
		once
			create Result.put (Void)
		end

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
