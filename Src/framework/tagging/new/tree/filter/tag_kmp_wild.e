note
	description: "Summary description for {TAG_KMP_WILD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_KMP_WILD

inherit
	KMP_WILD
		redefine
			set_pattern
		end

create
	make,
	make_empty

feature -- Status report

	has_leading_wild: BOOLEAN
			-- Does pattern begin with a wild character?

feature -- Status setting

	set_pattern (a_new_pattern: STRING)
			-- <Precursor>
		do
			has_leading_wild := not a_new_pattern.is_empty and then (
				a_new_pattern.item (1) = character_representation or
				a_new_pattern.item (1) = string_representation)
			Precursor (a_new_pattern)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
