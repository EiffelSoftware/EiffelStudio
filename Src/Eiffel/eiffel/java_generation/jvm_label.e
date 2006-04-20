indexing
		description: "[
						Representation of a JVM Label.
						bridges the label id as known by the compiler front end
						with a byte code position in the actual code.
						A label is always relative to a method.
						a label may be open. In that case it's byte code position
						in the method is not yet known.
						`LABEL_MARK's refer to `LABEL's
						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
		date: "$Date$"
		revision: "$Revision$"

class
		JVM_LABEL

create
		make

feature {NONE} -- Initialisation

		make (a_id: INTEGER) is
				do
						id := a_id
				ensure
				is_opend: is_open
				id_set: id = a_id
				end
			
feature -- Access
			
		id: INTEGER
				-- label id as reported by the compiler front end.
			
		byte_code_position: INTEGER
				-- absolute position (starting at 1) of the label in the
				-- method's byte code
				-- The `byte_code_position' only stores a valid value once
				-- it `is_closed'.
			
feature {ANY} -- Status Settings
			
		is_open: BOOLEAN is
				-- Is the label open ?
				-- i.e. `byte_code_position' has net been set yet.
				do
				Result := not is_closed
				end
			
		is_closed: BOOLEAN
				-- Is the label closed ?
				-- i.e. `byte_code_position' has already been set.
				-- The byte code generator is now free to generate a jump for a
				-- `LABEL_MARK's pointing to `Current'.

feature {ANY} -- Basic operations
			
		close (pos: INTEGER) is
				-- close the label and assign a valid `byte_code_position'
				-- to it.
				require
				is_opend: is_open
				valid_pos: pos > 0
				do
				byte_code_position := pos
				is_closed := True
				ensure
				is_closed: is_closed
				byte_code_position_set: byte_code_position = pos
				end

invariant
		is_open_not_is_closed: is_open = not is_closed
		byte_code_position_valid: is_closed implies byte_code_position > 0
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

end



