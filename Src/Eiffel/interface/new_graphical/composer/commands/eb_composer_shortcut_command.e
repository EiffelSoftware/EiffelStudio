note
	description: "Command to provide global shortcut for composer actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPOSER_SHORTCUT_COMMAND

inherit
	EB_COMMAND

	EB_SHARED_MANAGERS

	EB_SHARED_PREFERENCES

	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	make
		local
			l_shortcut: SHORTCUT_PREFERENCE
			acc: ES_ACCELERATOR_AND_THEN_KEY
		do

			l_shortcut := preferences.editor_data.shortcuts.item (composer_manager.preferences_prefix + "*")
			if l_shortcut = Void then
					-- Default
				l_shortcut := preferences.editor_data.custom_shortcut (composer_manager.preferences_prefix + "*", [False, True, False, "e"])
			end
			create acc.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator := acc
			acc.actions.extend (agent execute_with_key)
			set_referred_shortcut (l_shortcut)
		end

feature -- Execution

	execute_with_key (k: EV_KEY)
		local
			is_ctrl, is_alt, is_shift: BOOLEAN
		do
			is_ctrl := ev_application.ctrl_pressed
			is_alt := ev_application.alt_pressed
			is_shift := ev_application.shift_pressed
			composer_manager.process_command_for_shortcut (k, is_ctrl, is_alt, is_shift)
		end

	execute
		do
			check should_not_occurs: False end
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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

