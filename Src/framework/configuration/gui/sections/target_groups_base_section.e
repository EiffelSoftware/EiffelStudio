note
	description: "Objects that ..."
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
			l_group: like conf_item_type
			l_group_sec: like section_item_type
		do
			l_dial := create_add_dialog
			l_dial.show_modal_to_window (configuration_window)
			if l_dial.is_ok then
				l_group := l_dial.last_group

					-- create and select the section
				l_group_sec := create_group_section (l_group)
				extend (l_group_sec)
				expand
				l_group_sec.enable_select
			end
		end

	set_groups (a_groups: HASH_TABLE [like conf_item_type, STRING])
			-- Set groups.
		require
			a_groups_ok: a_groups /= Void and then not a_groups.is_empty
		local
			l_sort_list: DS_ARRAYED_LIST [like conf_item_type]
			l_group: like conf_item_type
			l_group_sec: like section_item_type
		do
				-- sort groups alphabetically
			create l_sort_list.make (a_groups.count)
			from
				a_groups.start
			until
				a_groups.after
			loop
				l_sort_list.force_last (a_groups.item_for_iteration)
				a_groups.forth
			end
			l_sort_list.sort (create {DS_QUICK_SORTER [like conf_item_type]}.make (create {KL_COMPARABLE_COMPARATOR [like conf_item_type]}.make))

			from
				l_sort_list.start
			until
				l_sort_list.after
			loop
				l_group := l_sort_list.item_for_iteration
				l_group_sec := create_group_section (l_group)
				extend (l_group_sec)
				l_sort_list.forth
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

	add_dialog_type: CREATE_GROUP_DIALOG
			-- Type of the dialog to create a new item.
		deferred
		end

	conf_item_type: CONF_GROUP
			-- Type of configuration objects represented.
		deferred
		end

	section_item_type: GROUP_SECTION
			-- Type of sections contained.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
