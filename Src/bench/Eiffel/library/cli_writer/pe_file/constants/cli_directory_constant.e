indexing
	description: "Constants related to use of CLI_DIRECTORY"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_DIRECTORY_CONSTANTS

feature -- Access

	image_number_of_directory_entries: INTEGER is 16
			-- Number of directory entries in CLI_OPTIONAL_HEADER.

	image_directory_entry_export: INTEGER is 0
			-- Export Directory

	image_directory_entry_import: INTEGER is 1
			-- Import Directory

	image_directory_entry_resource: INTEGER is 2
			-- Resource Directory

	image_directory_entry_exception: INTEGER is 3
			-- Exception Directory

	image_directory_entry_security: INTEGER is 4
			-- Security Directory

	image_directory_entry_basereloc: INTEGER is 5
			-- Base Relocation Table

	image_directory_entry_debug: INTEGER is 6
			-- Debug Directory

	image_directory_entry_copyright: INTEGER is 7
			-- (X86 usage)

	image_directory_entry_globalptr: INTEGER is 8
			-- RVA of GP

	image_directory_entry_tls: INTEGER is 9
			-- TLS Directory

	image_directory_entry_load_config: INTEGER is 10
			-- Load Configuration Directory

	image_directory_entry_bound_import: INTEGER is 11
			-- Bound Import Directory in headers

	image_directory_entry_iat: INTEGER is 12
			-- Import Address Table

	image_directory_entry_delay_import: INTEGER is 13
			-- Delay Load Import Descriptors

	image_directory_entry_cli_descriptor: INTEGER is 14
			-- CLI Runtime descriptor

	image_directory_reserved: INTEGER is 15
			-- Reserved

end -- class CLI_DIRECTORY_CONSTANT
