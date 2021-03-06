note
	description: "When breakpoint hits do ... on set of breakpoints..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BREAKPOINT_WHEN_HITS_ACTION_WITH_TAGS_I

inherit
	BREAKPOINT_WHEN_HITS_ACTION_I

feature -- Properties

	tags: SPECIAL [STRING_32]
			-- Tags identifiying the set of breakpoints
			--| This can be either a real tag,
			--|		foo, bar, ...
			--| or a path to stop point such as:
			--|		[cluster_name.CLASS_NAME.feature_name.index]
			--|     [CLASS_NAME.feature_name.index]

feature -- Change

	set_tags (a_tags: like tags)
			--
		do
			tags := a_tags
		end

	set_tags_from_string (a_s32: STRING_32)
			--
		local
			lst: LIST [STRING_32]
			i: INTEGER
			s: STRING_32
			l_tags: like tags
		do
			lst := a_s32.split (',')
			if lst.count = 0 then
				tags := Void
			else
				from
					lst.start
					create l_tags.make_filled (lst.first, lst.count)
					tags := l_tags
					lst.forth
					i := 1
				until
					lst.after
				loop
					s := lst.item
					s.left_adjust
					s.right_adjust
					l_tags[i] := s
					i := i + 1
					lst.forth
				end
			end
		end

feature -- Query

	tags_as_string: STRING_32
			-- String representation of the `tags'.
		local
			i: INTEGER
		do
			if attached tags as t and then t.count > 0 then
				from
					i := 0
					create Result.make_from_string (t[i])
					i := i + 1
				until
					i >= t.count
				loop
					Result.append_character (',')
					Result.append_string (t[i])
					i := i + 1
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
