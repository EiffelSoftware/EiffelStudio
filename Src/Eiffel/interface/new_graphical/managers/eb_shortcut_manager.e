note
	description: "Shortcut manager."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHORTCUT_MANAGER

inherit
	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			create post_updating_actions.make (1)
		end

feature -- Access

	update_commands
			-- Update all commands.
		do
			window_manager.refresh_commands
			post_updating_actions.do_all (agent (a_tuple: TUPLE [a_window: EB_VISION_WINDOW; a_list: EV_NOTIFY_ACTION_SEQUENCE])
											do
												a_tuple.a_list.call (Void)
											end)
		end

	update_external_commands
			-- Update external commands.
		do
			window_manager.refresh_external_commands
			post_updating_actions.do_all (agent (a_tuple: TUPLE [a_window: EB_VISION_WINDOW; a_list: EV_NOTIFY_ACTION_SEQUENCE])
											do
												a_tuple.a_list.call (Void)
											end)
		end

	propagate_accelerators (a_dev_window: EB_DEVELOPMENT_WINDOW)
			-- Progagate accelerators to undocked windows.
			-- This should be called after updating all commands.
			-- If there is no post actions (important part of refreshing accelerators in a window),
			-- we propagate directly.
			-- Otherwise we make it part of post actions.
		require
			a_dev_window_not_void: a_dev_window /= Void
			a_docking_manager_not_void: a_dev_window.docking_manager /= Void
		do
			if not post_updating_actions.is_empty then
				post_updating_actions_of (a_dev_window.window).extend_kamikaze (agent (a_dev_window.docking_manager).propagate_accelerators)
			else
				a_dev_window.docking_manager.propagate_accelerators
			end
		end

	clear_actions (a_develop_window: EB_VISION_WINDOW)
			-- Clear actions related with `a_develop_window'.
			-- `a_develop_window' is value from EB_DEBELOPMENT_WINDOW.window.
		require
			not_void: a_develop_window /= Void
		do
			from
				post_updating_actions.start
			until
				post_updating_actions.after
			loop
				if post_updating_actions.item.dev_win = a_develop_window then
					post_updating_actions.remove
				else
					post_updating_actions.forth
				end
			end
		end

feature {EB_COMMAND} -- Access

	post_updating_actions_of (a_win: EB_VISION_WINDOW): EV_NOTIFY_ACTION_SEQUENCE
			-- `a_win' is from EB_DEVELOPMENT_WINDOW.window
			-- Actions related with `a_win'.
		require
			not_void: a_win /= Void
		do
			from
				post_updating_actions.start
			until
				post_updating_actions.after or Result /= Void
			loop
				if post_updating_actions.item.dev_win = a_win then
					Result := post_updating_actions.item.actions
				end
				post_updating_actions.forth
			end

			if Result = Void then
				create Result
				post_updating_actions.extend ([a_win, Result])
			end
		ensure
			not_void: Result /= Void
		end

	post_updating_actions: ARRAYED_LIST [TUPLE [dev_win: EB_VISION_WINDOW; actions: EV_NOTIFY_ACTION_SEQUENCE]];
			-- Called after updating EB_COMMANDs.
			-- Item count should same size as total EB_DEVELOPMENT_WINDOW count.

invariant
	post_updating_actions_not_void: post_updating_actions /= Void

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
