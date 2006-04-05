indexing
	description: "Provide formatting of assembly public key tokens"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	KEY_ENCODER

feature -- Access

	encoded_key (a_key: NATIVE_ARRAY [NATURAL_8]): STRING is
			-- Printable representation of `a_key'
		require
			a_key_not_void: a_key /= Void
		local
			i: INTEGER
		do
			create Result.make (a_key.count * 2)
			from
				i := 0	
			until
				i >= a_key.count
			loop
				Result.append (a_key.item (i).to_hex_string)
				i := i + 1
			end
			Result.to_lower
		ensure
			Result_not_void: Result /= Void
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


end -- class KEY_ENCODER
