indexing
	description: "Generator of generated run-time globals."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_GENERATED_RT_GLOBALS_GENERATOR

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_MAPPER_HELPERS
		export
			{NONE} all
		end

create
	generate 

feature -- Basic operations

	generate is
			-- Generate Generated Globals header file.
		local
			cpp_writer: WIZARD_WRITER_C_FILE
		do
			create cpp_writer.make
			cpp_writer.set_header_file_name (Ecom_generated_rt_globals_header_file_name)
			cpp_writer.set_header ("Global variables used in generated code.")
			cpp_writer.add_import ("ecom_rt_globals.h")
			cpp_writer.add_import (Generated_ec_class_name + ".h")
			cpp_writer.add_import (Generated_ce_class_name + ".h")
			cpp_writer.add_other ("extern " + Generated_ec_class_name + " " + Generated_ec_mapper + ";")
			cpp_writer.add_other ("extern " + Generated_ce_class_name + " " + Generated_ce_mapper + ";")
			shared_file_name_factory.create_generated_mapper_file_name (cpp_writer)
			cpp_writer.save_header_file (shared_file_name_factory.last_created_header_file_name)
		end

end -- class WIZARD_GENERATED_RT_GLOBALS_GENERATOR

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

