note
	description: "[
					Contextual tabs vistor when using DLL
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CONTEXTUAL_TABS_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_contextual_tabs
		end

feature -- Command

	visit_contextual_tabs (a_contextual_tabs: ER_XML_TREE_ELEMENT; a_layout_constructor_index: INTEGER)
			-- <Precursor>
		local
			l_ribbon_contextual_tabs: EV_TREE_ITEM
			l_data: ER_TREE_NODE_TAB_GROUP_DATA
			l_tree_item: EV_TREE_ITEM
			l_helper: ER_LOAD_VISION_TREE_VISITOR
		do
			if attached shared.layout_constructor_list.i_th (a_layout_constructor_index) as l_layout_constructor then
				l_ribbon_contextual_tabs := l_layout_constructor.tree_item_factory_method (constants.ribbon_contextual_tabs)

				from
					a_contextual_tabs.start
				until
					a_contextual_tabs.after
				loop
					if attached {XML_ELEMENT} a_contextual_tabs.item_for_iteration as l_element then

						check l_element.name.same_string (constants.tab_group) end
						create l_data.make
						l_tree_item := l_layout_constructor.tree_item_factory_method (constants.tab_group)
						l_tree_item.set_data (l_data)

						create l_helper
						from
							l_element.start
						until
							l_element.after
						loop
							if attached {XML_ATTRIBUTE} l_element.item_for_iteration as l_attribute then
								check l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name) end
								l_data.set_command_name (l_attribute.value)
							elseif attached {XML_ELEMENT} l_element.item_for_iteration as l_tab then
								check l_tab.name.same_string (constants.tab) end
								-- Add tab
								l_helper.create_vision_tree_recursive (l_tree_item, l_element.item_for_iteration)
							end
							l_element.forth
						end

						l_ribbon_contextual_tabs.extend (l_tree_item)
					end
					a_contextual_tabs.forth
				end

				if not l_ribbon_contextual_tabs.is_empty then
					l_layout_constructor.widget.extend (l_ribbon_contextual_tabs)
					l_layout_constructor.expand_tree
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
