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
			cpp_writer.add_other ("extern " + 
						Generated_ec_class_name + " " +
						Generated_ec_mapper + Semicolon)

			cpp_writer.add_other ("extern " + 
						Generated_ce_class_name + " " +
						Generated_ce_mapper + Semicolon)

			shared_file_name_factory.create_generated_mapper_file_name (cpp_writer)
			cpp_writer.save_header_file (shared_file_name_factory.last_created_header_file_name)

		end

end -- class WIZARD_GENERATED_RT_GLOBALS_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
