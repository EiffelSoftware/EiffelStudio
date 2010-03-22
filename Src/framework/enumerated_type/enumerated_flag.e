note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: ": 2009-10-07 11:40:56 -0700 (Wed, 07 Oct 2009) "
	revision: ": 81044 "

deferred class
	ENUMERATED_FLAG

inherit
	ENUMERATED_TYPE [INTEGER]
		redefine
			is_valid_value
		end

convert
	item: {INTEGER}

feature {NONE} -- Access

	mask: INTEGER
			-- Flag mask, used for flag validity
		local
			l_members: like members
			i, i_upper: INTEGER
		once
			l_members := members
			from
				i := l_members.lower
				i_upper := l_members.upper
			until
				i > i_upper
			loop
				Result := Result | l_members [i]
				i := i + 1
			end
		end

feature -- Status report

	has_flag (a_flag: like Current): BOOLEAN
			-- Determines if the Current flag contains a particular flag.
			--
			-- `a_flag': Flag to compare Current against.
			-- `Result': True if Current contains `a_flag'; False otherwise.
		require
			a_flag_attached: attached a_flag
		local
			l_flag: INTEGER
		do
			l_flag := a_flag.item
			Result := (item & l_flag) = l_flag
		ensure
			item_has_flag: Result implies (item & a_flag.item) = a_flag.item
		end

   is_valid_value (n: INTEGER): BOOLEAN
			-- <Precursor>
		local
			l_assert: BOOLEAN
		do
			Result := Precursor (n) and (item & mask) = item
		ensure then
			valid_flag: Result implies (item & mask) = item
		end

feature -- Basic operations

	combine (a_flag: like Current)
			-- Combines Current with the supplied flag.
			--
			-- `a_flag': Flag to combine Current with.
		do
			internal_value := internal_value | a_flag.item
		ensure
			has_flag_a_flag: has_flag (a_flag)
		end

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
