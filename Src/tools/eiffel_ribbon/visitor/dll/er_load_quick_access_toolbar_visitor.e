note
	description: "[
					Quick Access Toolbar vistor when using DLL
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_LOAD_QUICK_ACCESS_TOOLBAR_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_quick_access_toolbar
		end

feature -- Command

	visit_quick_access_toolbar (a_quick_access_toolbar: ER_XML_TREE_ELEMENT; a_layout_constructor_index: INTEGER)
			-- <Precursor>
		local
			l_data: ER_TREE_NODE_QUICK_ACCESS_TOOLBAR_DATA
			l_tree_item: EV_TREE_ITEM
			l_helper: ER_LOAD_VISION_TREE_VISITOR
		do
			if attached shared.layout_constructor_list.i_th (a_layout_constructor_index) as l_layout_constructor then

				create l_data.make
				l_tree_item := l_layout_constructor.tree_item_factory_method (constants.ribbon_quick_access_toolbar)

				from
					create l_helper
					a_quick_access_toolbar.start
				until
					a_quick_access_toolbar.after
				loop
					if attached {XML_ELEMENT} a_quick_access_toolbar.item_for_iteration as l_element then
						if l_element.name.same_string (constants.quick_access_toolbar) then
							from
								l_element.start
							until
								l_element.after
							loop
								if attached {XML_ATTRIBUTE} l_element.item_for_iteration as l_attribute then
									if l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name) then
										l_data.set_command_name (l_attribute.value)
									else
										check invalid_tag: False end
									end
								elseif attached {XML_ELEMENT}l_element.item_for_iteration as l_sub_element and then
									l_sub_element.name.same_string (constants.quick_access_toolbar_application_defaults) then

									from
										l_sub_element.start
									until
										l_sub_element.after
									loop
										l_helper.create_vision_tree_recursive (l_tree_item, l_sub_element.item_for_iteration)
										l_sub_element.forth
									end
								end
								l_element.forth
							end
						end
					end
					a_quick_access_toolbar.forth
				end

				l_tree_item.set_data (l_data)

				l_layout_constructor.widget.extend (l_tree_item)
				l_layout_constructor.expand_tree
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
