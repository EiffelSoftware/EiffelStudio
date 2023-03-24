note
	description: "Representation of a tiny method header."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TINY_METHOD_HEADER

inherit
	MD_METHOD_HEADER

create
	make
	
feature {NONE} -- Initialization

	make (a_size: INTEGER_8)
			-- Create a tiny header representing a feature
			-- with no rescue clause, nor local variables
			-- and a maxstack less than 8.
		require
			valid_size: a_size >= 0 and a_size < 64
		do
			set_code_size (a_size)
		ensure
			code_size_set: code_size = a_size
		end
		
feature -- Access

	code_size: INTEGER
			-- Size of current feature.
		do
			Result := (internal_data & 0x000000FC) |>> 2
		ensure
			valid_result: Result >= 0 and Result < 64
		end

feature -- Access

	count: INTEGER = 1
			-- Size of structure once emitted.
		
feature -- Saving

	write_to_stream (m: MANAGED_POINTER; pos: INTEGER)
			-- Write to stream `m' at position `pos'.
		local
			l_data: INTEGER_8
			l_ptr: POINTER
		do
			l_data := (internal_data & 0x000000FF).to_integer_8
			l_ptr := m.item + pos
			l_ptr.memory_copy ($l_data, 1)
		end
		
feature -- Settings

	set_code_size (a_size: INTEGER)
			-- Set `code_size' to `a_size' of current feature.
		require
			valid_size: a_size >= 0 and a_size < 64
		do
			internal_data := {MD_METHOD_CONSTANTS}.tiny_format.to_integer_32 | (a_size |<< 2)
		ensure
			code_size_set: code_size = a_size			
		end
		
feature {NONE} -- Implementation

	internal_data: INTEGER;
			-- Hold value of code_size and header type.

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

end -- class MD_TINY_METHOD_HEADER
