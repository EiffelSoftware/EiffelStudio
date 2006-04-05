indexing
	description: "Representation of a fat method header"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_FAT_METHOD_HEADER

inherit
	MD_METHOD_HEADER

create
	make
	
feature -- Initialization

	make, remake (a_max_stack: INTEGER_16; a_code_size, a_locals_token: INTEGER) is
			-- Create fat method header.
		do
			max_stack := a_max_stack
			code_size := a_code_size
			locals_token := a_locals_token
			
				-- Set internal data with `size' of current structure
				-- and default flags.
			internal_data := Header_size | (
				{MD_METHOD_CONSTANTS}.Fat_format |
				{MD_METHOD_CONSTANTS}.Init_locals)
		ensure
			max_stack_set: max_stack = a_max_stack
			code_size_set: code_size = a_code_size
			locals_token_set: locals_token = a_locals_token
		end

feature -- Access

	max_stack: INTEGER_16
			-- Stack size.
			
	code_size: INTEGER
			-- Size of code.
			
	locals_token: INTEGER
			-- Token for local signature.

	flags: INTEGER_8 is
			-- Current flags.
		do
			Result := (internal_data & 0x00FF).to_integer_8
		end

feature -- Access

	count: INTEGER is 12
			-- Size of structure once emitted.
		
feature -- Saving

	write_to_stream (m: MANAGED_POINTER; pos: INTEGER) is
			-- Write to stream `m' at position `pos'.
		do
			m.put_integer_16 (internal_data, pos)
			m.put_integer_16 (max_stack, pos + 2)
			m.put_integer_32 (code_size, pos + 4)
			m.put_integer_32 (locals_token, pos + 8)
		end
		
feature -- Settings

	set_flags (f: INTEGER_8) is
			-- Set `flags' with `f'.
		do
			internal_data := Header_size | (f |
				{MD_METHOD_CONSTANTS}.Fat_format |
				{MD_METHOD_CONSTANTS}.Init_locals)
		end
		
feature {NONE} -- Implementation

	internal_data: INTEGER_16
			-- To hold `size' of current and `flags'.

	Header_size: INTEGER_16 is 0x3000
			-- Size of current structure.

invariant
	valid_flags: flags & {MD_METHOD_CONSTANTS}.Fat_format = 
			{MD_METHOD_CONSTANTS}.Fat_format

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

end -- class MD_FAT_METHOD_HEADER
