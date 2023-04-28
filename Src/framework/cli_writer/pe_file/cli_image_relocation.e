note
	description: "Representation of a relocation structure for CLI."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=II.25.3.2 Relocations", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf,#page=308", "protocol=uri"

class
	CLI_IMAGE_RELOCATION

inherit
	MANAGED_POINTER
		rename
			make as managed_pointer_make
		end

	CLI_UTILITIES
		export
			{NONE} padding, pad_up
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Allocate `item'.
		do
			managed_pointer_make (structure_size)
			c_set_block_size (item, 0x0C)
		end

feature -- Settings

	set_data (data_location: INTEGER)
			-- Set current structure knowing that relocation
			-- location is at position `data_location' in memory.
		require
			valid_data_location: data_location >= Section_alignment
		local
			i: INTEGER
			block_rva: INTEGER
		do
			block_rva := pad_up (data_location, Block_size)
			if block_rva /= data_location then
					-- Block was not aligned on a `Block_size' boundary, so we remove `Block_size'
					-- from `block_rva' to find in which `Block_size' RVA is `data_location'.
				block_rva := block_rva - Block_size
			end
			i := data_location - block_rva
			c_set_block_rva (item, block_rva)
			c_set_fixup (item, {CLI_PE_FILE_CONSTANTS}.Image_reloc_highlow +
				i.to_integer_16)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of CLI_IMAGE_RELOCATION structure.
		external
			"C macro use %"cli_writer.h%""
		alias
			"sizeof(CLI_IMAGE_RELOCATION)"
		end

	Block_size: INTEGER = 4096
			-- Size of block for a relocation location.

feature  -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (Current, 0, count)
			l_file.close
		end

feature {NONE} -- Implementation

	c_set_block_rva (an_item: POINTER; i: INTEGER)
			-- Set `BlockRVA' to `i'.
		external
			"C struct CLI_IMAGE_RELOCATION access BlockRVA type DWORD use %"cli_writer.h%""
		end

	c_set_block_size (an_item: POINTER; i: INTEGER)
			-- Set `BlockSize' to `i'.
		external
			"C struct CLI_IMAGE_RELOCATION access BlockSize type DWORD use %"cli_writer.h%""
		end

	c_set_fixup (an_item: POINTER; i: INTEGER_16)
			-- Set `Fixup' to `i'.
		external
			"C struct CLI_IMAGE_RELOCATION access Fixup type WORD use %"cli_writer.h%""
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class CLI_IMAGE_RELOCATION
