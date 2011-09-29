note
	description: "[
					Help button vistor when using DLL
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_LOAD_HELP_BUTTON_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_help_button
		end

feature -- Command

	visit_help_button (a_help_button: ER_XML_TREE_ELEMENT; a_layout_constructor_index: INTEGER)
			-- <Precursor>
		local
			l_data: ER_TREE_NODE_HELP_BUTTON_DATA
			l_tree_item: EV_TREE_ITEM
		do
			if attached shared.layout_constructor_list.i_th (a_layout_constructor_index) as l_layout_constructor then

				create l_data.make
				from
					a_help_button.start
				until
					a_help_button.after
				loop
					if attached {XML_ELEMENT} a_help_button.item_for_iteration as l_element then
						check l_element.name.same_string (constants.helpbutton) end
						from
							l_element.start
						until
							l_element.after
						loop
							if attached {XML_ATTRIBUTE} l_element.item_for_iteration as l_attribute then
								check l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name) end
								l_data.set_command_name (l_attribute.value)
							end
							l_element.forth
						end
					end
					a_help_button.forth
				end

				l_tree_item := l_layout_constructor.tree_item_factory_method (constants.ribbon_helpbutton)
				l_tree_item.set_data (l_data)

				l_layout_constructor.widget.extend (l_tree_item)
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
