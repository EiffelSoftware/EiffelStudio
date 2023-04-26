note
	description: "Constants related to use of CLI_DIRECTORY"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_DIRECTORY_CONSTANTS

feature -- Access

	image_number_of_directory_entries: INTEGER = 16
			-- Number of directory entries in CLI_OPTIONAL_HEADER.

	image_directory_entry_export: INTEGER = 1
			-- Export Directory

	image_directory_entry_import: INTEGER = 2
			-- Import Directory

	image_directory_entry_resource: INTEGER = 3
			-- Resource Directory

	image_directory_entry_exception: INTEGER = 4
			-- Exception Directory

	image_directory_entry_security: INTEGER = 5
			-- Security Directory

	image_directory_entry_basereloc: INTEGER = 6
			-- Base Relocation Table

	image_directory_entry_debug: INTEGER = 7
			-- Debug Directory

	image_directory_entry_copyright: INTEGER = 8
			-- (X86 usage)

	image_directory_entry_globalptr: INTEGER = 9
			-- RVA of GP

	image_directory_entry_tls: INTEGER = 10
			-- TLS Directory

	image_directory_entry_load_config: INTEGER = 11
			-- Load Configuration Directory

	image_directory_entry_bound_import: INTEGER = 12
			-- Bound Import Directory in headers

	image_directory_entry_iat: INTEGER = 13
			-- Import Address Table

	image_directory_entry_delay_import: INTEGER = 14
			-- Delay Load Import Descriptors

	image_directory_entry_cli_descriptor: INTEGER = 15
			-- CLI Runtime descriptor

	image_directory_reserved: INTEGER = 16;
			-- Reserved

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLI_DIRECTORY_CONSTANT
