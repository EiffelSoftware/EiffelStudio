note
	description: "[
			Representation of a PE file header through C structure IMAGE_FILE_HEADER
			for CLI.
			See Partition II, 24.2.2 for details on default values.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=IMAGE_FILE_HEADER", "src=https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-image_file_header", "protocol=uri"
	Ecma_version: "https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf"
	Ecma_section: "II.25.2.2 PE file header"

class
	CLI_PE_FILE_HEADER

create
	make, default_create

feature {NONE} -- Initialization

	make
			-- Allocate `item' and initialize default values for CLI.
		do
			set_machine (0x14C)
			set_time_date_stamp ({CLI_TIME}.time (default_pointer))
			set_pointer_to_symbol_table (0)
			set_size_of_optional_header (0x00E0)
			set_number_of_symbols (0)
		end

feature -- Access

	machine: INTEGER_16
			-- The target machine type for the executable.

	number_of_sections: INTEGER_16
			-- The number of sections in the file.

	time_date_stamp: INTEGER
			-- The time and date when the file was created.

	pointer_to_symbol_table: INTEGER
			-- The offset of the symbol table, in bytes, or zero if no COFF symbol table exists.

	number_of_symbols: INTEGER
			-- The number of symbols in the symbol table.

	size_of_optional_header: INTEGER_16
			-- Size of the optional header, which immediately follows the file header.

	characteristics: INTEGER_16
			-- The characteristics of the image, such as whether it is a DLL, whether it is a console application, etc.

feature -- Settings

	set_machine (i: INTEGER)
			-- Set `machine` to `i`
		do
			machine := i.to_integer_16
		ensure
			machine_set: machine = i.to_integer_16
		end

	set_number_of_sections (i: INTEGER)
			-- Set `number_of_sections` to `i`
		do
			number_of_sections := i.to_integer_16
		ensure
			number_of_sections_set: number_of_sections = i.to_integer_16
		end

	set_time_date_stamp (t: INTEGER)
			-- Set `time_date_stamp' to `t'.
		do
			time_date_stamp := t
		ensure
			time_date_stamp_set: time_date_stamp = t
		end

	set_size_of_optional_header (s: INTEGER_16)
			-- Set `size_of_optional_header_size' to `s'.
		do
			size_of_optional_header := s
		ensure
			size_of_optional_header_set: size_of_optional_header = s
		end

	set_number_of_symbols (i: INTEGER)
			-- Set `number_of_symbols` to `i`.
		do
			number_of_symbols := i
		ensure
			number_of_symbols_set: number_of_symbols = i
		end

	set_pointer_to_symbol_table (i: INTEGER)
			-- Set `pointer_to_symbol_table' to `i'.
		do
			pointer_to_symbol_table := i
		ensure
			pointer_to_symbol_table_set: pointer_to_symbol_table = i
		end

	set_characteristics (c: INTEGER_16)
			-- Set `characteristics' to `c'.
			-- Look in `CLI_PE_FILE_CONSTANTS' for possible constants.
		do
			characteristics := c
		ensure
			characteristics_set: characteristics = c
		end

feature -- Status Report

	count: INTEGER
			--  Number of elements that Current can hold.
		do
			Result := size_of
		end

feature -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (item, 0, count)
			l_file.close
		end

feature -- Managed pointer

	item: CLI_MANAGED_POINTER
		do
			create Result.make (size_of)

				-- machine
			Result.put_integer_16 (machine)
				-- number_of_sections
			Result.put_integer_16 (number_of_sections)
				-- time_date_stamp
			Result.put_integer_32 (time_date_stamp)
				-- pointer_to_symbol_table
			Result.put_integer_32 (pointer_to_symbol_table)
				-- number_of_symbols
			Result.put_integer_32 (number_of_symbols)
				-- size_of_optional_header
			Result.put_integer_16 (size_of_optional_header)
				-- characteristics
			Result.put_integer_16 (characteristics)
		ensure
			Result.count = size_of
		end

feature -- Measurement

	size_of: INTEGER
		local
			s: CLI_MANAGED_POINTER_SIZE
		do
			create s.make
				-- machine
			s.put_integer_16
				-- number of sections
			s.put_integer_16
				-- time_date_stamp
			s.put_integer_32
				-- pointer_to_symbol_table
			s.put_integer_32
				-- number_of_symbols
			s.put_integer_32
				-- size_of_optional_header
			s.put_integer_16
				-- characteristics
			s.put_integer_16
			Result := s
		ensure
			ecma: Result = 20
			instance_free: class
		end

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class CLI_PE_FILE_HEADER
