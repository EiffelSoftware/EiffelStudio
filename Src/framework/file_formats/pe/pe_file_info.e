indexing
	description: "[
		A PE file header examiner to check the type if PE files.
	]"
	date:        "$Date$"
	revision:    "$Revision$"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	PE_FILE_INFO

feature -- Initialization

	is_com2_pe_file (a_file_name: STRING): BOOLEAN is
			-- Determines if `a_file_name' is a COM2 (.NET) PE file.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name)).exists
		local
			l_pe_file: RAW_FILE
			l_header: NATURAL_32
			l_data_rva: SPECIAL [NATURAL_32]
			retried: BOOLEAN
			i: INTEGER_32
		do
			if not retried then
				create l_pe_file.make_open_read (a_file_name)
				l_pe_file.move (0x3C)

				l_pe_file.read_natural_32 -- PE header (PEH)
				l_header := l_pe_file.last_natural_32
				if l_header > 0 then
						-- Move to PEH start location
					l_pe_file.move (l_header.to_integer_32)

					l_pe_file.read_natural_32 -- Header signature
					l_pe_file.read_natural_16 -- Machine
					l_pe_file.read_natural_16 -- Sections
					l_pe_file.read_natural_32 -- Timestamp
					l_pe_file.read_natural_32 -- Symbol table
					l_pe_file.read_natural_32 -- # of symbols
					l_pe_file.read_natural_16 -- Options header size
					l_pe_file.read_natural_16 -- Characteristics

						-- Should be at the end of PEH and from here the optional PE headers start.

						-- Move directly to DataDictionary.
					l_pe_file.move (0x60)

						-- DataDictionary has 16 directories comprising of 128 bytes. (We are intrested in 15th entry)
						-- Each directory is 8 bytes and split into 4 byte chunks. The first
						-- 4 bytes is the RVA and the second 4 bytes are a size.
					create l_data_rva.make (15)
					from i := 0 until i = 15 or l_pe_file.end_of_file loop
						l_pe_file.read_natural_32 -- RVA
						l_data_rva.put (l_pe_file.last_natural_32, i)
						l_pe_file.read_natural_32 -- Size
						i := i + 1
					end
						-- The address held at dictionary entry 15 should not be 0 for .NET PE files.
					Result := l_data_rva[14] /= 0
				end
			end
			if l_pe_file /= Void and then not l_pe_file.is_closed then
				l_pe_file.close
			end
		rescue
			retried := True
			retry
		end

indexing
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

end -- class {PE_FILE_INFO}
