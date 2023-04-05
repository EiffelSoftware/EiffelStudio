note
	description: "Summary description for {TEST_METADATA_TABLES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_METADATA_TABLES_TK

feature -- Test


	test_cli_directory_size
		local
			l_dir: CLI_DIRECTORY
		do
			-- rva: 4 bytes
			-- data_size: 4 bytes
			check {CLI_DIRECTORY}.size_of = 8 end
		end

	test_cli_header_size
		local
			l_header: CLI_HEADER
		do
			--cb: 4 bytes
			--MajorRuntimeVersion: 2 bytes
			--MinorRuntimeVersion: 2 bytes
			--MetaData: 8 bytes (2 x 4 bytes)
			--Flags: 4 bytes
			--EntryPointToken: 4 bytes
			--Resources: 8 bytes (2 x 4 bytes)
			--StrongNameSignature: 8 bytes (2 x 4 bytes)
			--CodeManagerTable: 8 bytes (2 x 4 bytes)
			--VTableFixups: 8 bytes (2 x 4 bytes)
			--ExportAddressTableJumps: 8 bytes (2 x 4 bytes)
			--ManagedNativeHeader: 8 bytes (2 x 4 bytes)
			check {CLI_HEADER}.size_of = 72 end
		end

	test_empty_assembly
			-- New test routine
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT

		do
			create md_dispenser.make
			md_emit := md_dispenser.emit
			create l_pe_file.make ("test_empty_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_define_assembly
			-- New test routine
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			md_assembly_info: MD_ASSEMBLY_INFO
			my_assembly: INTEGER
		do

			create md_dispenser.make
			md_emit := md_dispenser.emit

			create md_assembly_info.make
			md_assembly_info.set_major (5)
			md_assembly_info.set_minor (2)
			my_assembly := md_emit.define_assembly (create {NATIVE_STRING}.make ("manus_assembly"),
						0, md_assembly_info, Void)

			create l_pe_file.make ({STRING_32}"test_define_assembly_tk.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_user_string_heap
		local
			l_token1, l_token2, l_token3: NATURAL_64
			l_str: STRING_32
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			l_result: NATURAL_64
			l_table_type_index: NATURAL_64
			l_index: NATURAL_64
		do
			create md_dispenser.make
			md_emit := md_dispenser.emit

			l_token1 := md_emit.define_string (create {NATIVE_STRING}.make ("Eiffel")).to_natural_64
			l_token2 := md_emit.define_string (create {NATIVE_STRING}.make ("Java")).to_natural_64
			l_token3 := md_emit.define_string (create {NATIVE_STRING}.make ("TEST_METADATA_TABLES_TK")).to_natural_64
			l_str := md_emit.retrieve_user_string (l_token1.to_integer_32)
			check same_string: l_str.same_string_general ("Eiffel") end

			l_str := md_emit.retrieve_user_string (l_token2.to_integer_32)
			check same_string: l_str.same_string_general ("Java") end
			l_str := md_emit.retrieve_user_string (l_token3.to_integer_32)
			check same_string: l_str.same_string_general ("TEST_METADATA_TABLES_TK") end
		end

end
