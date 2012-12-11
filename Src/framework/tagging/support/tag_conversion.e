note
	description: "[
		Simple string conversion routines used by tagging classes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAG_CONVERSION

feature -- Conversion

	immutable_string (a_tag: READABLE_STRING_GENERAL): IMMUTABLE_STRING_32
		require
			a_tag_attached: a_tag /= Void
		do
			if attached {IMMUTABLE_STRING_32} a_tag as l_result then
				Result := l_result
			else
				create Result.make_from_string_general (a_tag)
			end
		ensure
			result_attached: Result /= Void
			result_equal: a_tag.same_string (Result)
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
