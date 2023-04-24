note
	description: "[
			Eiffel tests that can be executed by testing tool.
		]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_METADATA_TABLES

inherit
	EQA_TEST_SET

feature -- Test routines

	test_empty_assembly
			-- New test routine
		local
			l_pe_file: CLI_PE_FILE
			md_dispenser: MD_DISPENSER
			md_emit: MD_EMIT
			size: INTEGER
		do
			(create {CLI_COM}).initialize_com

			create md_dispenser.make
			md_emit := md_dispenser.emitter
			size :=  md_emit.save_size
			create l_pe_file.make ("test_empty_com.dll", True, True, False, md_emit)
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
			(create {CLI_COM}).initialize_com

			create md_dispenser.make
			md_emit := md_dispenser.emitter

			create md_assembly_info.make
			md_assembly_info.set_major_version (5)
			md_assembly_info.set_minor_version (2)
			my_assembly := md_emit.define_assembly (create {UNI_STRING}.make ("define_assembly"),
						0, md_assembly_info, Void)

			create l_pe_file.make ("test_define_assembly_com.dll", True, True, False, md_emit)
			l_pe_file.save
		end

	test_cli_directory_size
		local
			l_dir: CLI_DIRECTORY
		do
			-- rva: 4 bytes
			-- data_size: 4 bytes
			check {CLI_DIRECTORY}.structure_size = 8 end
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
			check {CLI_HEADER}.structure_size = 72 end
		end

end

