note
	description: "[
					Ribbon item's identifier names uniqueness checker
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_IDENTIFIER_UNIQUENESS_CHECKER

feature -- Command

	on_focus_out (a_text: EV_TEXT_FIELD; a_tree_data: detachable ER_TREE_NODE_DATA)
			-- Handle `a_text' focus out action
		local
			l_colors: EV_STOCK_COLORS
		do
			if attached a_tree_data as l_data then
				a_text.change_actions.block
				-- Restore to text stored in command name
				if attached l_data.command_name as l_command_name then
					a_text.set_text (l_command_name)
				else
					a_text.remove_text
				end
				create l_colors
				a_text.set_foreground_color (l_colors.black)
				a_text.change_actions.resume
			end
		end

	on_identifier_name_change (a_text: EV_TEXT_FIELD; a_tree_data: detachable ER_TREE_NODE_DATA)
			-- Handle text change actions of `a_text'
		require
			not_void: a_text /= Void
		local
			l_colors: EV_STOCK_COLORS
			l_already_set: BOOLEAN
		do
			if attached a_tree_data as l_data then
				if attached a_text.text as l_text
					and then not l_text.is_empty then
					if attached l_data.command_name as l_command_name then
						if l_text.same_string (l_command_name) then
							l_already_set := True
						end
					end
					create l_colors
					if not l_already_set then
						if not is_name_conflict (a_text) then
							-- no conflict
							l_data.set_command_name (a_text.text)
							a_text.set_foreground_color (l_colors.black)
						else
							-- name conflict
							a_text.set_foreground_color (l_colors.red)
						end
					end
				else
					l_data.set_command_name (void)
				end

			end
		end

feature -- Query

	is_name_conflict (a_text: EV_TEXT_FIELD): BOOLEAN
			-- If `a_text's text conflict with existing items'
		local
			l_list: ARRAYED_LIST [EV_TREE_NODE]
		do
			if attached a_text.text as l_text
				and then not l_text.is_empty then
				l_list := all_items_with_identifier (l_text)
				if l_list.count >= 1 then
					Result := True
				else
					Result := False
				end
			end
		end

	all_items_with_identifier (a_identifier: STRING): ARRAYED_LIST [EV_TREE_NODE]
			-- Find out all items which name is same as `a_identifier'
		require
			not_void: a_identifier /= Void
			not_empty: not a_identifier.is_empty
		local
			l_shared: ER_SHARED_TOOLS
			l_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
		do
			from
				create Result.make (10)
				create l_shared
				l_list := l_shared.layout_constructor_list
				l_list.start
			until
				l_list.after
			loop

				Result.merge_right (all_item_with_identifier_in_layout_constructor (l_list.item, a_identifier))
				l_list.forth
			end

		end

feature {NONE} -- Implementation

	parent_window_of_widget (a_widget: EV_WIDGET): detachable EV_WINDOW
			-- Parent window of `a_widget'
		require
			not_void: a_widget /= Void
		do
			if attached a_widget.parent as l_parent then
				if attached {EV_WINDOW} l_parent as l_window then
					Result := l_window
				else
					Result := parent_window_of_widget (l_parent)
				end
			end
		end

	all_item_with_identifier_in_layout_constructor (a_layout_constructor: ER_LAYOUT_CONSTRUCTOR; a_identifier_name: STRING): ARRAYED_LIST [EV_TREE_NODE]
			-- FIXME: need visitor pattern? ER_LAYOUT_CONSTRUCTOR.all_items_with
		require
			not_void: a_layout_constructor /= Void
			not_void: a_identifier_name /= Void and then not a_identifier_name.is_empty
		local
			l_tree: EV_TREE
		do
			from
				create Result.make (10)
				l_tree := a_layout_constructor.widget
				l_tree.start
			until
				l_tree.after
			loop
				all_item_with_identifier_recursive (l_tree.item, a_identifier_name, Result)
				l_tree.forth
			end
		end

	all_item_with_identifier_recursive (a_item: EV_TREE_NODE; a_identifier_name: STRING; a_list: ARRAYED_LIST [EV_TREE_NODE])
			-- Find all items which name same as `a_identifier_name' recursively.
		require
			not_void: a_item /= Void
			not_void: a_identifier_name /= Void and then not a_identifier_name.is_empty
			not_void: a_list /= Void
		do
			if attached {ER_TREE_NODE_DATA} a_item.data as l_data then
				if attached l_data.command_name as l_identifier_name then
					if l_identifier_name.same_string (a_identifier_name) then
						a_list.extend (a_item)
					end
				end
			end
			from
				a_item.start
			until
				a_item.after
			loop
				all_item_with_identifier_recursive (a_item.item, a_identifier_name, a_list)
				a_item.forth
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
