note
	description: "Summary description for {TEST_METADATA_TABLES_OM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_METADATA_TABLES_OM



feature -- Tests

	test_empty_assembly
		local
			pe_file: PE_LIB
		do
				-- Create the working assembly `manus_assembly`
				-- md_emit.define_assembly
			create pe_file.make_with_name ("empty_assembly_om", {PE_LIB}.il_only)

			pe_file.dump_output_file ("test_define_empty_assembly_om.dll", {CIL_OUTPUT_MODE}.pedll, false)

		end


end
