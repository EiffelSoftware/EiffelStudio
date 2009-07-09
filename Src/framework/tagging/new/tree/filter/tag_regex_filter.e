note
	description: "Summary description for {TAG_REGEX_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_REGEX_FILTER [G -> TAG_ITEM]

inherit
	TAG_SPARSE_TREE_FILTER [G]

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create positive_matchers.make_default
			create negative_matchers.make_default
		end

feature {NONE} -- Access

	positive_matchers: DS_ARRAYED_LIST [like new_matcher]
			-- List of matchers which tags of node have to match
			--
			-- Note: if `positive_matchers' is empty, a node is included by default.

	negative_matchers: DS_ARRAYED_LIST [like new_matcher]
			-- List of matchers which nodes are not allowed to match

feature -- Status report

	has_expression: BOOLEAN
			-- Are nodes currently filtered?
		do
			Result := not (positive_matchers.is_empty and negative_matchers.is_empty)
		end

feature -- Status setting

	set_expression (an_expr: READABLE_STRING_8)
			-- Set expression which will be used to filter nodes.
		local
			i: INTEGER
			l_expr: detachable STRING
			l_pos, l_add: BOOLEAN
			c: CHARACTER
			l_new: like new_matcher
		do
			remove_expression

			from
				i := 1
			until
				i > an_expr.count
			loop
				c := an_expr.item (i)

				if not c.is_space then
					l_add := True
					if l_expr = Void then
						create l_expr.make (20)
						l_pos := True
						if c = '+' then
							l_add := False
						elseif c = '-' then
							l_add := False
							l_pos := False
						end
					end
					if l_add then
						l_expr.append_character (c)
					end
				end
				i := i + 1
				if i > an_expr.count or else an_expr.item (i).is_space then
					if l_expr /= Void then
						if not l_expr.is_empty then
							l_new := new_matcher (l_expr)
							if l_pos then
								positive_matchers.force_last (l_new)
							else
								negative_matchers.force_last (l_new)
							end
						end
						l_expr := Void
					end
				end
			end
		end

	remove_expression
			-- Remove current expression, including all nodes by default.
		do
			positive_matchers.wipe_out
			negative_matchers.wipe_out
		end

feature -- Query

	is_node_included (a_sparse_tree: TAG_SPARSE_TREE [G]; a_node: TAG_TREE_NODE [G]): TUPLE [BOOLEAN, BOOLEAN]
			-- <Precursor>
		local
			l_matchers: like positive_matchers
			l_matcher: like new_matcher
			l_inside, l_check_children: BOOLEAN
			l_tag: STRING
		do
			if a_node.is_root then
				l_inside := positive_matchers.is_empty
				l_check_children := not (l_inside and negative_matchers.is_empty)
			else
				l_tag := a_node.tag

					-- Check positive matchers
				from
					l_inside := True
					l_matchers := positive_matchers
					l_matchers.start
					l_check_children := not l_matchers.is_empty
				until
					l_matchers.after or not l_inside
				loop
					l_matcher := l_matchers.item_for_iteration
					l_matcher.set_text (l_tag)
					l_inside := l_matcher.search_for_pattern and (l_matcher.has_leading_wild or l_matcher.found_at = 1)

						-- If pattern starts with a wild string/character, we should check children
					l_check_children := not l_inside and
						(l_matcher.has_leading_wild or l_matcher.pattern.count > l_tag.count)

					l_matchers.forth
				end

				check inside_implies_dont_check_children: l_inside implies not l_check_children end

					-- Check negative matchers
				from
					l_matchers := negative_matchers
					l_matchers.start
				until
					l_matchers.after or not l_inside
				loop
					l_matcher := l_matchers.item_for_iteration
					l_matcher.set_text (l_tag)
					l_inside := not (l_matcher.search_for_pattern  and (l_matcher.has_leading_wild or l_matcher.found_at = 1))

						-- If pattern starts with a wild, we should check children
					l_check_children := l_inside and
						(l_check_children or l_matcher.has_leading_wild or l_matcher.pattern.count > l_tag.count)

					l_matchers.forth
				end
			end
			Result := [l_inside, l_check_children]
		end

feature {NONE} -- Factory

	new_matcher (a_pattern: STRING): TAG_KMP_WILD
			-- Create a new wild string matcher.
			--
			-- `a_pattern': Pattern to be used for matching.
			-- `Result': New matcher.
		do
			create Result.make_empty
			Result.set_pattern (a_pattern)
			Result.enable_case_sensitive
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
