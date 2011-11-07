note
	description: "[
		Valid tree before saving project
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_VALIDATOR

feature -- Command

	check_tree
			-- Start tree validation checking
		local
			l_shared: ER_SHARED_TOOLS
			l_visitors: like all_visitors
			l_all: ER_SHARED_TOOLS
		do
			create l_all
			across l_all.all_feedback_indicators as l_feedback_indicator
			loop
				l_feedback_indicator.item.destroy
			end
			l_all.all_feedback_indicators.wipe_out

			-- Check from first layout constructor until last one
			is_valid := True
			create l_shared
			across l_shared.layout_constructor_list as l_layout_constructor loop
				across l_layout_constructor.item.widget as l_tree_item loop
					l_visitors := all_visitors
					visit_tree_recursively (l_tree_item.item, l_visitors)
					if is_valid then
						from
							l_visitors.start
						until
							l_visitors.after or not is_valid
						loop
							is_valid := not l_visitors.item.is_error_found
							l_visitors.forth
						end
					end
				end
			end
		end

feature -- Query

	is_valid: BOOLEAN
			-- Is tree valid?

feature {NONE}	-- Implementation

	visit_tree_recursively (a_tree_node: EV_TREE_NODE; a_visitors: ARRAYED_LIST [ER_TREE_VALIDATION_VISITOR])
			-- Visit tree recursively
		do
			if a_tree_node.text.same_string ({ER_XML_CONSTANTS}.ribbon_tabs) then
				across a_visitors as l_visitor loop
					l_visitor.item.visit_ribbon_tabs (a_tree_node)
				end
			elseif a_tree_node.text.same_string ({ER_XML_CONSTANTS}.context_popup) then
				across a_visitors as l_visitor loop
					l_visitor.item.visit_context_popup (a_tree_node)
				end
			end

		end

	all_visitors: ARRAYED_LIST [ER_TREE_VALIDATION_VISITOR]
			-- All error visitors
		local
			l_split_button_empty_visitor: ER_SC1065_SPLIT_BUTTON_EMPTY_ERROR_VISITOR
			l_mini_toolbar_empty_visitor: ER_SC1053_MINI_TOOLBAR_CANNOT_EMPTY_VISITOR
			l_too_few_control_for_size_definition: ER_SC1031_TOO_FEW_CONTROLS_FOR_SIZE_DEFINITION
			l_too_many_control_for_size_definition: ER_SC1032_TOO_MANY_CONTROLS_FOR_SIZE_DEFINITION
			l_wrong_control_type: ER_SC1046_WRONG_CONTROL_TYPE
			l_sc1057: ER_SC1057_SCE_ONLY_ONE_FONT_CONTROL_ALLOWED_IN_FLOATIE
		do
			create Result.make (10)

			create l_split_button_empty_visitor
			Result.extend (l_split_button_empty_visitor)

			create l_mini_toolbar_empty_visitor
			Result.extend (l_mini_toolbar_empty_visitor)

			create l_too_few_control_for_size_definition
			Result.extend (l_too_few_control_for_size_definition)

			create l_too_many_control_for_size_definition
			Result.extend (l_too_many_control_for_size_definition)

			create l_wrong_control_type
			Result.extend (l_wrong_control_type)

			create l_sc1057
			Result.extend (l_sc1057)
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
