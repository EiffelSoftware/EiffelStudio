indexing
	description: "Dialog to add or remove targets and change the order of the targets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_DIALOG

inherit
	LIST_DIALOG
		redefine
			initialize,
			on_up,
			on_down,
			on_add,
			on_remove
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
		end

feature -- Access

	conf_system: CONF_SYSTEM
			-- Configuration system.

feature -- Update

	set_conf_system (a_system: like conf_system) is
			-- Set `conf_system' to `a_system'.
		require
			a_system_not_void: a_system /= Void
		do
			conf_system := a_system
		ensure
			conf_system_set: conf_system /= Void
		end

feature {NONE} -- Agents

	on_up is
			-- Called if an item should be moved up.
		local
			l_item: EV_LIST_ITEM
			i: INTEGER
			l_parent: CONF_TARGET
			wd: EV_WARNING_DIALOG
		do
			check
				conf_system_set: conf_system /= Void
			end
			l_item := list.selected_item
			if l_item /= Void  then
				i := list.index_of (l_item, 1)
				if i > 1 then
						-- we can't move an item up if we inherit from the item.
					l_parent := conf_system.targets.item (l_item.text.to_string_8)
					if l_parent /= Void and then l_parent.extends /= Void and then l_parent.extends.name.is_equal (list.i_th (i-1).text.to_string_8) then
						create wd.make_with_text (target_move_up_extends)
						wd.show_modal_to_window (Current)
					else
						Precursor {LIST_DIALOG}
					end
				end
			end
		end

	on_down is
			-- Called if an item should be moved down.
		local
			l_item: EV_LIST_ITEM
			i: INTEGER
			l_parent: CONF_TARGET
			wd: EV_WARNING_DIALOG
		do
			check
				conf_system_set: conf_system /= Void
			end
			l_item := list.selected_item
			if l_item /= Void  then
				i := list.index_of (l_item, 1)
				if i > 1 then
						-- we can't move an item down if the item below inherits from us.
					l_parent := conf_system.targets.item (list.i_th (i+1).text.to_string_8)
					if l_parent /= Void and then l_parent.extends /= Void and then l_parent.extends.name.is_equal (l_item.text.to_string_8) then
						create wd.make_with_text (target_move_down_extends)
						wd.show_modal_to_window (Current)
					else
						Precursor {LIST_DIALOG}
					end
				end
			end
		end

	on_add is
			-- Called if an item should be added.
		local
			wd: EV_WARNING_DIALOG
			l_found: BOOLEAN
			l_target: STRING
		do
			check
				conf_system_set: conf_system /= Void
			end
			l_target := new_item_name.text
			from
				list.start
			until
				l_found or list.after
			loop
				l_found := list.item.text.is_equal (l_target)
				list.forth
			end
			if l_found then
				create wd.make_with_text (target_add_duplicate)
				wd.show_modal_to_window (Current)
			else
				Precursor {LIST_DIALOG}
			end
		end

	on_remove is
			-- Called if an item should be removed.
		local
			l_item: EV_LIST_ITEM
			l_target: CONF_TARGET
			wd: EV_WARNING_DIALOG
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
		do
			check
				conf_system_set: conf_system /= Void
			end
			l_item := list.selected_item
			if l_item /= Void then
				l_target := conf_system.targets.item (l_item.text.to_string_8)
				if conf_system.library_target = l_target then
					create wd.make_with_text (target_remove_library_target)
					wd.show_modal_to_window (Current)
				elseif conf_system.targets.count = 1 then
					create wd.make_with_text (target_remove_last)
					wd.show_modal_to_window (Current)
				else
					from
						l_targets := conf_system.targets
						l_targets.start
					until
						wd /= Void or l_targets.after
					loop
						if l_targets.item_for_iteration.extends = l_target then
							create wd.make_with_text (target_remove_extends (l_targets.item_for_iteration.name))
						end
						l_targets.forth
					end
					if wd /= Void then
						wd.show_modal_to_window (Current)
					else
						Precursor {LIST_DIALOG}
					end
				end
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
