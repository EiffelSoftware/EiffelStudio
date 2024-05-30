note
	description: "[
			Manages all available composer operations.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPOSER_MANAGER

inherit
	EB_SHARED_PREFERENCES
		rename
			preferences as eb_preferences
		end

	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	ACCESS_CONTROL_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Create
		do
			preferences := eb_preferences.preferences

				-- create the commands
			create feature_setter_adder_command.make (Current)
			create feature_remover_command.make (Current)
			create class_creator_adder_command.make (Current)

				-- All commands except `shortcut_command` which is hidden
			all_commands := {ARRAY [EB_COMPOSER_COMMAND_I]} <<
					feature_setter_adder_command,
					feature_remover_command,
					class_creator_adder_command
				>>

			create shortcut_command.make
		end

	accelerator: EV_ACCELERATOR

feature -- Commands

	all_commands: ITERABLE [EB_COMPOSER_COMMAND_I]

	shortcut_command: EB_COMPOSER_SHORTCUT_COMMAND

	feature_setter_adder_command: EB_COMPOSER_ADD_SETTER_COMMAND

	feature_remover_command: EB_COMPOSER_FEATURE_REMOVER_COMMAND

	class_creator_adder_command: EB_COMPOSER_ADD_CREATOR_COMMAND

feature -- Query

	process_command_for_shortcut (k: EV_KEY; is_ctrl, is_alt, is_shift: BOOLEAN)
		local
			cmd: EB_COMPOSER_COMMAND_I
			acc: EV_ACCELERATOR
			done: BOOLEAN
		do
			across
				all_commands as ic
			until
				done
			loop
				cmd := ic.item
				acc := cmd.composer_and_then_accelerator
				if acc /= Void then
					if
						acc.key.code = k.code and then
						acc.control_required = is_ctrl and then
						acc.alt_required = is_alt and then
						acc.shift_required = is_shift
					then
						done := True
						acc.actions.call (Void)
					end
				end
			end
		end

feature -- Execution

	update_all_commands (a_window: EV_WINDOW)
		do
			across
				all_commands as ic
			loop
				ic.item.update (a_window)
			end
			shortcut_command.update (a_window)
		end

feature -- Access

	preferences_prefix: STRING = "editor.composer."

	feature_setter_adder: COMPOSER_FEATURE_SETTER_ADDER
		do
			create Result.make
		end

	feature_remover: COMPOSER_FEATURE_REMOVER
		do
			create Result.make
		end

	class_creator_adder: COMPOSER_CLASS_CREATOR_ADDER
		do
			create Result.make
		end

feature -- Element change

	enable_sensitive
			-- Enable the commands.
		do
			across
				all_commands as ic
			loop
				ic.item.enable_sensitive
			end
		end

	disable_sensitive
			-- Disable the commands and forget undo informations.
		do
			across
				all_commands as ic
			loop
				ic.item.disable_sensitive
			end
		end


feature -- Basic operation

	execute_composer (a_action: COMPOSER_ACTION)
			-- Execute `a_action'.
		do
			process_under_control ("run", agent (act: COMPOSER_ACTION)
					do
						disable_sensitive
						window_manager.on_composer_start
						act.reset
						act.execute
						if not act.succeed then
							if attached act.last_error_message as err then
								prompts.show_error_prompt (err, Void,Void)
							else
								prompts.show_error_prompt ("Operation failed", Void,Void)
							end
						end
						window_manager.on_composer_end
						enable_sensitive
					end (a_action)
				)
		end

feature {NONE} -- Implementation

	preferences: PREFERENCES
			-- The EiffelStudio preferences system.


invariant
	preferences_not_void: preferences /= Void

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
