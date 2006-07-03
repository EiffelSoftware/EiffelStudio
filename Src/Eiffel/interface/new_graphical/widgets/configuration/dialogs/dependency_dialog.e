indexing
	description: "Dialog to add or remove dependencies."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEPENDENCY_DIALOG

inherit
	LIST_DIALOG
		redefine
			initialize,
			new_item_name,
			on_add
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		do
			Precursor {LIST_DIALOG}
			modify_button.hide
			up_button.hide
			down_button.hide
		end

feature -- Access

	conf_target: CONF_TARGET
			-- Configuration target.

feature {NONE} -- GUI elements

	new_item_name: EV_COMBO_BOX

feature -- Update

	set_conf_target (a_target: like conf_target) is
			-- Set `conf_target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		local
			l_sorted_groups: DS_ARRAYED_LIST [STRING]
		do
			conf_target := a_target
			create l_sorted_groups.make_from_array (a_target.groups.current_keys)
			l_sorted_groups.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))

			new_item_name.set_strings (l_sorted_groups.to_array)
			new_item_name.disable_edit
		ensure
			conf_target_set: conf_target /= Void
		end

feature {NONE} -- Agents

	on_add is
			-- Called if an item should be added.
		local
			wd: EV_WARNING_DIALOG
		do
			check
				conf_target_set: conf_target /= Void
			end
			if not conf_target.groups.has (new_item_name.text.to_string_8) then
				create wd.make_with_text (cluster_dependency_group_not_exist)
				wd.show_modal_to_window (Current)
			else
				Precursor {LIST_DIALOG}
			end
		end

indexing
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
