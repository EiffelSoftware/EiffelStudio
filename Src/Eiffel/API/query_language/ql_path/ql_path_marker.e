note
	description: "Path marker used in Eiffel Query Language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_PATH_MARKER

create
	make

feature{NONE} -- Implementation

	make (a_opener: READABLE_STRING_GENERAL ; a_closer: READABLE_STRING_GENERAL)
			-- Initialize `opener' with `a_opener' and `closer' with `a_closer'.
		require
			a_opener_attached: a_opener /= Void
			a_closer_attached: a_closer /= Void
		do
			create opener.make_from_string_general (a_opener)
			create closer.make_from_string_general (a_closer)
		ensure
			opener_attached: opener /= Void
			opener_set: opener.same_string_general (a_opener)
			closer_attached: closer /= Void
			closer_set: closer.same_string_general (a_closer)
		end

feature -- Access

	path_name (a_base_name: READABLE_STRING_GENERAL): STRING_32
			-- Path name of `a_base_name'
		require
			a_base_name_attached: a_base_name /= Void
		do
			create Result.make (a_base_name.count + opener.count + closer.count)
			if not opener.is_empty then
				Result.append (opener)
			end
			Result.append_string_general (a_base_name)
			if not closer.is_empty then
				Result.append (closer)
			end
		end

	base_name (a_path_name: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- Base name from `a_path_name'
		require
			a_path_name_attached: a_path_name /= Void
			a_path_name_valid: is_equipped_with_marker (a_path_name)
		local
			l_start, l_end: INTEGER
		do
			l_start := opener.count + 1
			l_end := a_path_name.count - closer.count
			Result := a_path_name.substring (l_start, l_end)
		ensure
			result_attached: Result /= Void
		end

	opener: IMMUTABLE_STRING_32
			-- Opener for path name

	closer: IMMUTABLE_STRING_32
			-- Closer for path name

feature -- Status report

	is_equipped_with_marker (a_path_component: READABLE_STRING_GENERAL): BOOLEAN
			-- If `a_path_component' equipped with current path marker?
		require
			a_path_component_attached: a_path_component /= Void
			not_a_path_component_is_empty: not a_path_component.is_empty
		local
			l_opener: like opener
			l_closer: like closer
			l_head: READABLE_STRING_GENERAL
			l_tail: READABLE_STRING_GENERAL
		do
			l_opener := opener
			l_closer := closer
			Result := a_path_component.count > l_opener.count + l_closer.count
			if Result and then not l_opener.is_empty then
				l_head := a_path_component.substring (1, l_opener.count)
				Result := l_head.is_case_insensitive_equal (l_opener)
			end
			if Result and then not l_closer.is_empty then
				l_tail := a_path_component.substring (a_path_component.count - l_closer.count + 1, a_path_component.count)
				Result := l_tail.is_case_insensitive_equal (l_closer)
			end
		end

invariant
	opener_attached: opener /= Void
	closer_attached: closer /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
