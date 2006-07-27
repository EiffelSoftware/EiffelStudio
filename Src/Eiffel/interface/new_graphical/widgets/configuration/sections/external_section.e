indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXTERNAL_SECTION

inherit
	TARGET_SECTION
		rename
			make as make_target_section
		undefine
			icon
		redefine
			name,
			create_context_menu,
			create_select_actions,
			update_toolbar_sensitivity
		end

	CONF_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	make (a_external: like conf_external; a_target: like target; a_window: like configuration_window) is
			-- Create.
		require
			a_external_not_void: a_external /= Void
			a_target_not_void: a_target /= Void
			a_window_not_void: a_window /= Void and then not a_window.is_destroyed
		do
			conf_external := a_external
			target := a_target
			make_target_section (a_target, a_window)
		ensure
			external_set: conf_external = a_external
			target_set: target = a_target
		end

feature -- Access

	conf_external: CONF_EXTERNAL
			-- External for which information are displayed.

	name: STRING is
			-- Name of the section.
		do
			Result := conf_external.location
		end

	icon: EV_PIXMAP is
			-- Icon of the section.
		deferred
		end

feature -- Element update

	ask_remove_external is
			-- Ask for confirmation and remove `Current'.
		local
			l_cd: EV_CONFIRMATION_DIALOG
		do
			create l_cd.make_with_text_and_actions (conf_interface_names.target_remove_external (name), <<agent remove_external>>)
			l_cd.show_modal_to_window (configuration_window)
		end

feature {NONE} -- Implementation

	remove_external is
			-- Remove `Current' from the tree where it is displayed.
			-- Also remove the parent node if it is empty.
		local
			l_parent, l_grand_parent: EV_TREE_NODE_LIST
			l_par_node, l_grand_par_node: EV_TREE_NODE
		do
			l_parent := parent
			l_parent.start
			l_parent.prune (Current)
			l_par_node ?= l_parent
			check
				correct_parent: l_par_node /= Void
			end
			if l_parent.is_empty then
				l_grand_parent := l_par_node.parent
				l_grand_parent.start
				l_grand_parent.prune (l_par_node)
				l_grand_par_node ?= l_grand_parent
				check
					correct_grand_parent: l_grand_par_node /= Void
				end
				l_grand_par_node.enable_select
			else
				l_par_node.enable_select
			end
		end

	create_context_menu: EV_MENU is
			-- Context menu with available actions for `Current'.
		do
			create Result
			Result.extend (create {EV_MENU_ITEM}.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_external))
			Result.extend (create {EV_MENU_ITEM}.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select))
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_properties_target_externals (target, conf_external))
		end

	update_toolbar_sensitivity is
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.reset_sensitive

			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_external)
			toolbar.remove_button.enable_sensitive
		end

invariant
	external_not_void: conf_external /= Void

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
