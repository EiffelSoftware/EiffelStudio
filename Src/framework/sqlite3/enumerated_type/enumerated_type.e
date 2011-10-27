note
	description: "[
		Fake enumerated type
	]"
	legal   : "See notice at end of class."
	status  : "See notice at end of class.";
	date    : "$Date$"
	revision: "$Revision$"

deferred class
	ENUMERATED_TYPE [G -> NUMERIC]

inherit
	ANY
		redefine
			default_create, out
		end

feature {ENUMERATED_TYPE} -- Initialization

	frozen default_create
			-- Default initialization.
		do
			make (members.item (members.lower))
		end

	frozen make (n: G)
			-- Initializes instance from base entity `n'
			--
			-- `n': A numerical value associated with a member of `Current'
		require
			n_is_valid_value: is_valid_value (n)
		do
			internal_value := n
		ensure
			internal_value_set: internal_value = n
		end

feature {ENUMERATED_TYPE} -- Access

	frozen internal_value: G
			-- Internal raw value (do not rename!)

feature -- Query

	is_valid_value (n: G): BOOLEAN
			-- Determines if `n' a value associated with a member of `Current'.
			--
			-- `n': A numerical value to check for validity against members of `Current'.
			-- `Result': True if `n' a valid member, False otherwise.
		do
			Result := members.has (n)
		end

feature {NONE} -- Factory

	members: ARRAY [G]
			-- Array of all members of `Current'.
			--
			-- Note to Implementers: This function should be a once!
		deferred
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
			result_lower_is_one: Result.lower = 1
			result_upper_is_count: Result.upper = Result.count
			same_result: Result = members
		end

feature -- Conversion

	frozen item: G
			-- `Current' as a {NUMERIC} value
		do
			Result := internal_value
		ensure
			result_set: Result = internal_value
			result_is_valid_value: is_valid_value (Result)
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := internal_value.out
		end

invariant
	is_valid_value: is_valid_value (internal_value)

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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

end
