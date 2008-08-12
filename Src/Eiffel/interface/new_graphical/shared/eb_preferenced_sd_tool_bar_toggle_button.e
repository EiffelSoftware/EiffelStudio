indexing
	description: "[
					Toolbar toggle button with the ability to synchronize its status with its related preference.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON

inherit
	SD_TOOL_BAR_TOGGLE_BUTTON
		rename
			make as make_base
		end

	EB_RECYCLABLE
		undefine
			copy,
			is_equal,
			default_create
		redefine
			internal_detach_entities
		end

create
	make

feature{NONE} -- Initialization

	make (a_preference: BOOLEAN_PREFERENCE) is
			-- Initialize `preference' with `a_preference'.
		require
			a_preference_attached: a_preference /= Void
		do
			make_base
			preference := a_preference
			create synchronizer
			button_status_change_agent := agent notify_synchronizer (Current)
			preference_status_change_agent := agent notify_synchronizer (preference)

			synchronizer.register_host (
				preference,
				[
					agent (a_syn: EB_VALUE_SYNCHRONIZER [BOOLEAN]) do preference.change_actions.extend (preference_status_change_agent) end,
					agent (a_syn: EB_VALUE_SYNCHRONIZER [BOOLEAN]) do preference.change_actions.prune_all (preference_status_change_agent) end,
					agent: BOOLEAN do Result := preference.value end,
					agent preference.set_value
				],
				True
			)

			synchronizer.register_host (
				Current,
				[
					agent (a_syn: EB_VALUE_SYNCHRONIZER [BOOLEAN]) do select_actions.extend (button_status_change_agent) end,
					agent (a_syn: EB_VALUE_SYNCHRONIZER [BOOLEAN]) do select_actions.prune_all (button_status_change_agent) end,
					agent: BOOLEAN do Result := is_selected end,
					agent set_selection_status
				],
				False
			)
		end

feature -- Access

	preference: BOOLEAN_PREFERENCE
			-- Boolean preference associated with Current
			-- Current is reponsible for synchronizing with `preference'

feature {NONE} -- Implementation

	synchronizer: EB_VALUE_SYNCHRONIZER [BOOLEAN]
			-- Synchronizer used to synchroize selection status of Current toggle button and its associated `preference'

	button_status_change_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to be performed when selection status of Current toggle button changes

	preference_status_change_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to be performed when value of `preference' changes

	set_selection_status (b: BOOLEAN) is
			-- Set selection status of Current toggle button with `b'.
			-- `b' is True means enable selection of Current,
			-- `b' is False means disable selection of Current.
		do
			if b then
				enable_select
			else
				disable_select
			end
		ensure
			selection_status_set: (b implies is_selected) and then (not b implies not is_selected)
		end

	notify_synchronizer (a_value_host: ANY)	is
			-- Notify `synchronizer' that value from `a_value_host' changes
		require
			a_value_host_valid: a_value_host = Current or else a_value_host = preference
		do
			synchronizer.on_value_change_from (a_value_host)
		ensure
			value_synchronized: synchronizer.is_value_synchronized
		end

feature{NONE} -- Recycle

	internal_recycle is
			-- To be called when the button has became useless.
		do
			synchronizer.wipe_out_hosts
			select_actions.wipe_out
			pointer_button_press_actions.wipe_out
		end

	internal_detach_entities is
			-- <Precursor>
		do
			pointer_button_press_actions := Void
			preference := Void
			button_status_change_agent := Void
			preference_status_change_agent := Void
			synchronizer := Void
			Precursor
		end

invariant
	preference_attached: is_interface_usable implies preference /= Void
	synchronizer_attached: is_interface_usable implies synchronizer /= Void
	button_status_change_agent_attached: is_interface_usable implies button_status_change_agent /= Void
	preference_status_change_agent_attached: is_interface_usable implies preference_status_change_agent /= Void

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

end -- class EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON
