note
	description: "[
		State an scanner token lister will be in after a motion action.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

expanded class
	MATRIX_BUFFER_TYPE

inherit
	HASHABLE

create
	default_create,
	make_from_integer

convert
	make_from_integer ({INTEGER}),
	to_integer: {INTEGER}

feature {NONE} -- Initialization

	make_from_integer (i: INTEGER)
			-- Initializes instance from integer `i'.
			--
			-- `i': An {INTEGER} value corresponding to a member.
		require
			i_is_value_member: value_member (i)
		do
			value := i
		ensure
			value_set: value = i
		end

feature -- Scanner States

	implementation: INTEGER = 0x0
			-- Implementation buffer

	access: INTEGER = 0x01
			-- Access buffer

feature -- Access

	min_member: INTEGER
			-- Minimum value member
		do
			Result := implementation
		end

	max_member: INTEGER
			-- Maximum value member
		do
			Result := access
		end

feature -- HASHABLE Implementation

	hash_code: INTEGER
			-- Hash code value
		do
			Result := value
		end

feature -- Conversion

	to_integer: INTEGER
			-- Converts `Current' to an {INTEGER}
		do
			Result := value
		ensure
			result_set: Result = value
		end

feature -- Query

	value_member (i: like value): BOOLEAN
			-- Does `i' correspond to a value member?
		do
			Result := i = implementation or i = access
		end

feature {NONE} -- Implementation

	value: INTEGER
			-- Internal value

invariant
	value_is_value_member: value_member (value)

note
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

end -- class {MATRIX_BUFFER_TYPE}
