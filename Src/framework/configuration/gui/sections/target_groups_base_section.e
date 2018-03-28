note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TARGET_GROUPS_BASE_SECTION

inherit
	TARGET_SECTION
		undefine
			name,
			icon,
			update_toolbar_sensitivity,
			context_menu
		redefine
			create_select_actions
		end

	CONF_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Element update

	add_group
			-- Add a new external.
		local
			l_dial: like add_dialog_type
			l_group_sec: like section_item_type
		do
			l_dial := create_add_dialog
			l_dial.show_modal_to_window (configuration_window)
			if attached l_dial.last_group as g then
					-- create and select the section
				l_group_sec := create_group_section (g)
				extend (l_group_sec)
				expand
				l_group_sec.enable_select
			end
		end

	set_groups (a_groups: STRING_TABLE [like conf_item_type])
			-- Set groups.
		require
			a_groups_ok: a_groups /= Void and then not a_groups.is_empty
		local
			l_sorted_list: ARRAYED_LIST [like conf_item_type]
			l_group: like conf_item_type
			l_group_sec: like section_item_type
			l_sorter: QUICK_SORTER [like conf_item_type]
		do
				-- sort groups alphabetically
			create l_sorted_list.make (a_groups.count)
			from
				a_groups.start
			until
				a_groups.after
			loop
				l_sorted_list.extend (a_groups.item_for_iteration)
				a_groups.forth
			end
			create l_sorter.make (create {COMPARABLE_COMPARATOR [like conf_item_type]})
			l_sorter.sort (l_sorted_list)

			from
				l_sorted_list.start
			until
				l_sorted_list.after
			loop
				l_group := l_sorted_list.item_for_iteration
				l_group_sec := create_group_section (l_group)
				extend (l_group_sec)
				l_sorted_list.forth
			end
		end

feature {NONE} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_empty_section (conf_interface_names.selection_tree_select_node))
		end

	create_group_section (a_group: like conf_item_type): like section_item_type
			-- Create a new group section item.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	create_add_dialog: like add_dialog_type
			-- Create a dialog to add a new group.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Type anchors

	add_dialog_type: ADD_GROUP_DIALOG
			-- Type of the dialog to create a new item.
		require
			is_executable: False
		deferred
		ensure
			is_executable: False
		end

	conf_item_type: CONF_GROUP
			-- Type of configuration objects represented.
		require
			is_executable: False
		deferred
		ensure
			is_executable: False
		end

	section_item_type: GROUP_SECTION
			-- Type of sections contained.
		require
			is_executable: False
		deferred
		ensure
			is_executable: False
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
