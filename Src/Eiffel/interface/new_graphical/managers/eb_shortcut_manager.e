indexing
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

	make is
			-- Initialization
		do
			create post_updating_actions
		end

feature -- Access

	update_commands is
			-- Update all commands.
		do
			window_manager.refresh_commands
			post_updating_actions.call (Void)
		end

	update_external_commands is
			-- Update external commands.
		do
			window_manager.refresh_external_commands
			post_updating_actions.call (Void)
		end

	propagate_accelerators (a_dev_window: EB_DEVELOPMENT_WINDOW) is
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
				post_updating_actions.extend_kamikaze (agent (a_dev_window.docking_manager).propagate_accelerators)
			else
				a_dev_window.docking_manager.propagate_accelerators
			end
		end

feature {EB_COMMAND} -- Access

	post_updating_actions: EV_NOTIFY_ACTION_SEQUENCE;
			-- Called after updating EB_COMMANDs.

invariant
	post_updating_actions_not_void: post_updating_actions /= Void

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
