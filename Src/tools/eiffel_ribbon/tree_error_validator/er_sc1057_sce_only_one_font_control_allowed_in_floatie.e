note
	description: "[
		The minitoolbar can only contain one font control.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SC1057_SCE_ONLY_ONE_FONT_CONTROL_ALLOWED_IN_FLOATIE

inherit
	ER_TREE_VALIDATION_VISITOR
		redefine
			visit_context_popup
		end

feature -- Command

	visit_context_popup (a_tree_node: EV_TREE_NODE)
			-- <Precursor>
		do
			visit_node_recursive (a_tree_node)
		end

feature {NONE} -- Implementation

	visit_node_recursive (a_tree_node: EV_TREE_NODE)
			-- Visit tree node recursively
		local
			l_counter: CELL [INTEGER]
		do
			if a_tree_node.text.same_string ({ER_XML_CONSTANTS}.mini_toolbar) then
				create l_counter.put (0)
				visit_mini_toolbar_node (a_tree_node, l_counter)
				if l_counter.item > 1 then
						-- At most one font control
					is_error_found := True
					display_error_on_tree_node (a_tree_node, "The minitoolbar can only contain one font control.")
				end
			else
				across a_tree_node as l_cursor loop
					visit_node_recursive (l_cursor.item)
				end
			end
		end

	visit_mini_toolbar_node (a_tree_node: EV_TREE_NODE; a_font_control_count: CELL [INTEGER])
			-- Visit mini toolbar node
		do
			if a_tree_node.text.same_string ({ER_XML_CONSTANTS}.font_control) then
				a_font_control_count.put (a_font_control_count.item + 1)
			else
				across a_tree_node as l_cursor loop
					visit_mini_toolbar_node (l_cursor.item, a_font_control_count)
				end
			end
		end
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
