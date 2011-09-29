note
	description: "[
					XML tree element
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_TREE_ELEMENT

inherit
	XML_ELEMENT

create
	make,
	make_last,
	make_root

feature -- Command

	accept (a_visitor: ER_VISITOR; a_layout_constructor_index: INTEGER)
			-- Accept a visitor
		require
			not_void: a_visitor /= Void
		local
			l_cursor: XML_COMPOSITE_CURSOR
		do
			if attached name as l_name then
				if l_name.same_string (constants.ribbon_application_menu) then
					a_visitor.visit_ribbon_application_menu (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.ribbon_tabs) then
					a_visitor.visit_ribbon_tabs (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.application_commands) then
					a_visitor.visit_application_commands (Current)
				elseif l_name.same_string (constants.context_popup) then
					a_visitor.visit_context_popup (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.ribbon_helpbutton) then
					a_visitor.visit_help_button (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.ribbon_quick_access_toolbar) then
					a_visitor.visit_quick_access_toolbar (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.ribbon_size_definitions) then
					a_visitor.visit_size_definitions (Current)
				elseif l_name.same_string (constants.ribbon_contextual_tabs) then
					a_visitor.visit_contextual_tabs (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.tab_scaling_policy) then
					a_visitor.visit_scaling_policy (Current)
				end
			end

			from
				l_cursor := new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				if attached {ER_XML_TREE_ELEMENT} l_cursor.item as l_item then
					l_item.accept (a_visitor, a_layout_constructor_index)
				else
--					check item_not_valid: False end
				end

				l_cursor.forth
			end
		end

feature -- Command

	set_content (a_content: like content)
			-- Set `content' with `a_content'
		do
			content := a_content
		ensure
			set: a_content = content
		end

feature -- Query

	constants: ER_XML_CONSTANTS
			-- Constants
		once
			create Result
		end

	content: detachable STRING_32
			-- String contents
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
