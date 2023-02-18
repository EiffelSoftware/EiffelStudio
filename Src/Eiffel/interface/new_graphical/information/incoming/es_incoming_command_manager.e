note
	description: "Process external command other processes."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INCOMING_COMMAND_MANAGER

inherit
	COMMAND_RECEIVER

create
	make

feature {NONE} -- Initialization

	make (a_call_back: like command_receiver_callback)
			-- Initialization
		require
			a_call_back_attached: a_call_back /= Void
		do
			command_receiver_callback := a_call_back
			make_key ({COMMAND_PROTOCOL_NAMES}.eiffel_studio_key)
			set_external_command_action (agent external_command_action_handler)
		ensure
			command_receiver_callback_set: command_receiver_callback = a_call_back
		end

feature -- Action

	external_command_action_handler (a_string: READABLE_STRING_32): BOOLEAN
			-- Action to handle `a_string' as an external command
			-- Return `True' to claim the command will be handled.
		local
			l_condition_module, l_condition: STRING_32
			l_action_module, l_action: STRING_32
		do
			command_receiver_callback.reset
			if a_string /= Void and then not a_string.is_empty then
				if protocol_regex.recognizes (a_string) then
						-- 1. Module
					extract_regex.match (a_string)
					l_action_module := extract_regex.unicode_captured_substring (1)
						-- 2. Action or the condition
					extract_regex.next_match
					if extract_regex.match_count > 1 then
						l_action := extract_regex.unicode_captured_substring (1)

							-- 3. module
						extract_regex.next_match
						if extract_regex.match_count > 1 then
								-- There was conditional module.
							l_condition_module := l_action_module
							l_condition := l_action

							l_action_module := extract_regex.unicode_captured_substring (1)

								-- 4. Action
							extract_regex.next_match
							if extract_regex.match_count > 1 then
								l_action := extract_regex.unicode_captured_substring (1)
								if l_condition_module /= Void and l_condition /= Void and l_action_module /= Void and l_action /= Void then
									command_receiver_callback.on_condition_found (l_condition_module, l_condition)
									command_receiver_callback.on_action_found (l_action_module, l_action)
								end
							end
						else
							if l_action_module /= Void and l_action /= Void then
								command_receiver_callback.on_action_found (l_action_module, l_action)
							end
						end
					end
				end
				command_receiver_callback.on_command_finished
				Result := command_receiver_callback.command_resolved
			end
		end

feature -- Callback

	command_receiver_callback: ES_COMMAND_RECEIVER_CALLBACKS
			-- Command recever callbacks

feature -- Notification

	notify_created_starting_dialog (a_dialog: EB_STARTING_DIALOG)
			-- Notify current `a_dialog' has just been created.
			-- The dialog will be kept until `notify_created_starting_dialog' is called.
			-- Be careful doing this, since the dialog will not be GCed
			-- if `notify_created_starting_dialog' is not called.
		require
			a_dialog_attached: a_dialog /= Void
		do
			starting_dialog := a_dialog
			command_receiver_callback.set_starting_dialog (a_dialog)
		ensure
			starting_dialog_not_void: starting_dialog /= Void
		end

	notify_closing_starting_dialog
			-- Notify current starting dialog has just been destroyed.
		do
			starting_dialog := Void
			command_receiver_callback.set_starting_dialog (Void)
		ensure
			starting_dialog_void: starting_dialog = Void
		end

feature {NONE} -- Implementation

	starting_dialog: detachable EB_STARTING_DIALOG
			-- Reference to keep starting dialog

	id_solution: EB_SHARED_ID_SOLUTION
			-- Id solution
		once
			create Result
		end

	protocol_regex: RX_PCRE_MATCHER
			-- Regular expression matcher for parsing incoming command.
		once
			create Result.make
			Result.compile ("^(?:<([^>]*)>)+$")
		end

	extract_regex: RX_PCRE_MATCHER
			-- Regular expression matcher for parsing incoming command.
		once
			create Result.make
			Result.compile ("<([^>]*)>")
		end

invariant
	command_receiver_callback_attached: command_receiver_callback /= Void

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
