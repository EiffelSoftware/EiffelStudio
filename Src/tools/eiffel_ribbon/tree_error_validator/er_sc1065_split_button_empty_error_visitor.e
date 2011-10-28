note
	description: "[
		Check for split button child empty error
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SC1065_SPLIT_BUTTON_EMPTY_ERROR_VISITOR

inherit
	ER_TREE_VALIDATION_VISITOR
		redefine
			visit_ribbon_tabs
		end

feature -- Command

	visit_ribbon_tabs (a_tree_node: EV_TREE_NODE)
			-- <Precursor>
		do
			visit_node_recursive (a_tree_node)
		end

feature {NONE} -- Implementation

	visit_node_recursive (a_tree_node: EV_TREE_NODE)
			-- Visit tree node recursively
		do
			if a_tree_node.text.same_string ({ER_XML_CONSTANTS}.split_button) then
				if a_tree_node.count < 1 then
					-- At least one child
					is_error_found := True

					display_error_on_tree_node (a_tree_node, "The 'SplitButton' control must contain at least one child control of type 'Button', 'ToggleButton', or 'CheckBox'. ")
				end
			else
				across a_tree_node as l_cursor loop
					visit_node_recursive (l_cursor.item)
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
