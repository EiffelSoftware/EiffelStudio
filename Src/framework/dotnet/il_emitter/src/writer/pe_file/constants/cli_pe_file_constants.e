note
	description: "PE File characteristics constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_PE_FILE_CONSTANTS

feature -- PE header constants

	image_file_reloc_stripped: INTEGER_16 = 0x0001

	image_file_executable_image: INTEGER_16 = 0x0002
			-- File is executable (i.e. no unresolved external references).

	image_file_large_address_aware: INTEGER_16 = 0x0020
			-- 32 bit word machine.

	image_file_32bit_machine: INTEGER_16 = 0x0100
			-- 32 bit word machine.

	image_file_dll: INTEGER_16 = 0x2000
			-- File is DLL.

	image_file_line_nums_stripped: INTEGER_16 = 0x0004
			-- Line numbers stripped from file.

	image_file_local_syms_stripped: INTEGER_16 = 0x0008
			-- Local symboles stripped from file.

feature -- PE optional header constants

	image_subsystem_windows_gui: INTEGER_16 = 2
			-- Graphical application.

	image_subsystem_windows_console: INTEGER_16 = 3
			-- Console application.

feature -- PE relocation constants

	image_reloc_highlow: INTEGER_16 = 0x3000;

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

end -- class CLI_PE_FILE_CONSTANTS
