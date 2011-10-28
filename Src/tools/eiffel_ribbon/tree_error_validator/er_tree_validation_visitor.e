note
	description: "[
		Tree validation visitor common ancestor
		All Ribbon Markup error please check: "Understanding Markup Compiler Messages"
		http://msdn.microsoft.com/en-us/library/windows/desktop/dd316918(v=vs.85).aspx
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_TREE_VALIDATION_VISITOR

feature -- Command

	visit_ribbon_tabs (a_tree_node: EV_TREE_NODE)
			-- Vision `ribbon.tabs' node
		do
		end

	is_error_found: BOOLEAN
			-- Found error?

feature {NONE} -- Implementation

	display_error_on_tree_node (a_tree_node: EV_TREE_NODE; a_text: STRING_32)
			-- Display error feedback on `a_tree_node'
		require
			not_void: a_tree_node /= Void and a_text /= Void
		local
			l_feedback: ER_FEEDBACK_INDICATOR
		do
			create l_feedback.make_for_error (a_tree_node.width, a_tree_node.height)
			l_feedback.disconnect_from_window_manager
			l_feedback.set_position (a_tree_node.screen_x, a_tree_node.screen_y)
			l_feedback.set_error_text (a_text)
			--FIXME: Clear all previous feedback indicators first
			l_feedback.show_on (a_tree_node)
		end

;note
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
