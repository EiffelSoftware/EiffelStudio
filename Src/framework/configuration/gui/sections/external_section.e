note
	description: "Section of settings for externals."
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
			context_menu,
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

	make (a_external: like conf_external; a_target: like target; a_window: like configuration_window)
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

	name: READABLE_STRING_32
			-- Name of the section.
		local
			i, j: like {STRING}.index_of_code
		do
				-- Use the first line of a description if available.
			if attached conf_external.description as d and then not d.is_empty then
					-- There is a non-empty description. Look for a new line.
				i := d.index_of_code (('%R').code.as_natural_32, 1)
				j := d.index_of_code (('%N').code.as_natural_32, 1)
				if i = 0 then
					i := j
				elseif j /= 0 then
					i := i.min (j)
				end
				if i = 0 then
						-- There is no new line. Use the whole description.
					Result := d
				else
						-- Use the first line of the description.
					Result := d.substring (1, i - 1)
				end
			else
					-- There is no description. Use location.
				Result := conf_external.location
			end
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		deferred
		end

feature -- Element update

	ask_remove_external
			-- Ask for confirmation and remove `Current'.
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (
				conf_interface_names.target_remove_external (name), configuration_window, agent remove_external, Void)
		end

feature {NONE} -- Implementation

	remove_external
			-- Remove `Current' from the tree where it is displayed.
			-- Also remove the parent node if it is empty.
		local
			l_grand_parent: EV_TREE_NODE_LIST
		do
			check has_parent: attached parent as l_parent then
				l_parent.start
				l_parent.prune (Current)
				check
					correct_parent: attached {EV_TREE_NODE} l_parent as l_par_node
				then
					if l_parent.is_empty then
						l_grand_parent := l_par_node.parent
						if l_grand_parent /= Void then
							l_grand_parent.start
							l_grand_parent.prune (l_par_node)
							check correct_grand_parent: attached {EV_TREE_NODE} l_grand_parent as l_grand_par_node then
								l_grand_par_node.enable_select
							end
						else
							check correct_grand_parent: False end
						end
					else
						l_par_node.enable_select
					end
				end
			end
		end

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		local
			l_item: EV_MENU_ITEM
		do
			create Result.make (2)

			create l_item.make_with_text_and_action (conf_interface_names.general_remove, agent ask_remove_external)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.general_delete_icon)

			create l_item.make_with_text_and_action (conf_interface_names.menu_properties, agent enable_select)
			Result.extend (l_item)
			l_item.set_pixmap (conf_pixmaps.tool_properties_icon)
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		do
			create Result
			Result.extend (agent configuration_window.show_properties_target_externals (target, conf_external))
		end

	update_toolbar_sensitivity
			-- Enable/disable buttons in `toobar'.
		do
			toolbar.remove_button.select_actions.wipe_out
			toolbar.remove_button.select_actions.extend (agent ask_remove_external)
			toolbar.remove_button.enable_sensitive
		end

invariant
	external_not_void: conf_external /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
