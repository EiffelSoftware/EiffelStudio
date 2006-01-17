indexing
	description: "Representation of a value that cannot be pre-computed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NO_VALUE_I

inherit
	VALUE_I
		redefine
			is_no_value
		end
		
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to current?
			-- False since no value cannot be compared.
		do
			Result := False
		end

feature -- Status report

	is_no_value: BOOLEAN is True
			-- Current is a no value.

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is current value compatible with `t'?
		do
			check
				not_callable: False
			end
		ensure then
			not_called: False
		end
		
feature -- Generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate current value in `buffer'.
		do
			check
				not_callable: False
			end
		ensure then
			not_called: False
		end
		
	generate_il is
			-- Generate IL code for constant value.
		do
			check
				not_callable: False
			end
		ensure then
			not_called: False
		end
		
	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a constant value.
		do
			check
				not_callable: False
			end
		ensure then
			not_called: False
		end

feature -- Debug

	dump: STRING is
			-- Dump value.
		do
			check
				not_callable: False
			end
		ensure then
			not_called: False
		end
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class NO_VALUE_I
