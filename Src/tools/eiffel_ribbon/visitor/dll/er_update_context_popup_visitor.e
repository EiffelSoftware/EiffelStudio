note
	description: "[
					Context popup vistor when using DLL
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_UPDATE_CONTEXT_POPUP_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_context_popup
		end

feature -- Command

	visit_context_popup (a_context_popups: ER_XML_TREE_ELEMENT; a_layout_constructor_index: INTEGER)
			-- <Precursor>
		local
			l_tree_item: EV_TREE_ITEM
			l_helper: ER_LOAD_VISION_TREE_VISITOR
		do
			if attached shared.layout_constructor_list.i_th (a_layout_constructor_index) as l_layout_constructor then
				l_tree_item := l_layout_constructor.tree_item_factory_method (a_context_popups.name)
				-- Add root "Context Popup" node to first layout constructor
				l_layout_constructor.widget.extend (l_tree_item)

				-- Query values from markup XML
				check valid: attached a_context_popups.name as l_text and then l_text.same_string ({ER_XML_CONSTANTS}.context_popup) end

				from
					create l_helper
					a_context_popups.start
				until
					a_context_popups.after
				loop
					if attached {ER_XML_TREE_ELEMENT} a_context_popups.item_for_iteration as l_item then
						if l_item.name.same_string ({ER_XML_CONSTANTS}.context_popup_mini_toolbars) or else
						l_item.name.same_string ({ER_XML_CONSTANTS}.context_popup_context_menus) then
							l_helper.create_vision_tree_recursive (l_tree_item, l_item)
						elseif l_item.name.same_string ({ER_XML_CONSTANTS}.context_popup_context_maps) then
							-- Handle context maps here
						else
							check not_possible: False end
						end
					end

					a_context_popups.forth
				end

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
