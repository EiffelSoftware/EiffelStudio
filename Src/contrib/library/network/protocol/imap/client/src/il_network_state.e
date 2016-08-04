note
	description: "A state"
	author: "Basile Maret"
	EIS: "name=States", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-3"

deferred class
	IL_NETWORK_STATE

inherit

	IL_CONSTANTS

feature -- Access

	Not_connected_state: NATURAL = 1
	Not_authenticated_state: NATURAL = 2
	Authenticated_state: NATURAL = 3
	Selected_state: NATURAL = 4

	Min_state: NATURAL = 1
	Max_state: NATURAL = 4

feature -- Basic operation

	check_action (a_state: NATURAL; a_action: NATURAL): BOOLEAN
			-- Returns true if `a_action' is a valid action in state `a_state'
		require
			correct_state: a_state >= Min_state and a_state <= Max_state
			correct_action: a_action >= {IL_IMAP_ACTION}.Min_action and a_action <= {IL_IMAP_ACTION}.Max_action
		do
			if a_state /= not_connected_state and any_state_actions.has (a_action) then
				Result := true
			elseif a_state = not_authenticated_state then
				Result := not_authenticated_state_actions.has (a_action)
			elseif a_state = authenticated_state then
				Result := authenticated_state_actions.has (a_action)
			elseif a_state = selected_state then
				Result := selected_state_actions.has (a_action)
			else
				Result := false
			end
		end

	set_state (a_state: NATURAL)
			-- Set `state' to `a_state'
		require
			correct_state: a_state >= Min_state and a_state <= Max_state
		do
			state := a_state
			if a_state /= Selected_state then
				current_mailbox.unselect
			end
		ensure
			state = a_state
		end

	set_needs_continuation (bool: BOOLEAN)
		do
			needs_continuation := bool
		end

	update_imap_state (a_response: IL_SERVER_RESPONSE; a_state: NATURAL)
			-- Checks if the response `a_response' is OK and, if it is the case, updates the state to `a_state'
		require
			response_not_void: a_response /= Void
		do
			if a_response.status ~ Command_ok_label then
				set_state (a_state)
				debugger.debug_print (debugger.Debug_info, "Switched state ")
			end
		end

feature -- Access

	state: NATURAL
			-- Current state of the connection

	needs_continuation: BOOLEAN
			-- Set to true iff server sent a command continuation request

feature -- Implementation

	any_state_actions: LIST [NATURAL]
			-- Valid actions in any state
		once
			create {LINKED_LIST [NATURAL]}Result.make
			Result.extend ({IL_IMAP_ACTION}.Capability_action)
			Result.extend ({IL_IMAP_ACTION}.Noop_action)
			Result.extend ({IL_IMAP_ACTION}.Logout_action)
		end

	not_authenticated_state_actions: LIST [NATURAL]
			-- Valid actions in not authenticated state
		once
			create {LINKED_LIST [NATURAL]}Result.make
			Result.extend ({IL_IMAP_ACTION}.Login_action)
			Result.extend ({IL_IMAP_ACTION}.Starttls_action)
		end

	authenticated_state_actions: LIST [NATURAL]
			-- Valid actions in authenticated state
		once
			create {LINKED_LIST [NATURAL]}Result.make
			Result.extend ({IL_IMAP_ACTION}.Select_action)
			Result.extend ({IL_IMAP_ACTION}.Examine_action)
			Result.extend ({IL_IMAP_ACTION}.Create_action)
			Result.extend ({IL_IMAP_ACTION}.Delete_action)
			Result.extend ({IL_IMAP_ACTION}.Rename_action)
			Result.extend ({IL_IMAP_ACTION}.Subscribe_action)
			Result.extend ({IL_IMAP_ACTION}.Unsubscribe_action)
			Result.extend ({IL_IMAP_ACTION}.List_action)
			Result.extend ({IL_IMAP_ACTION}.Lsub_action)
			Result.extend ({IL_IMAP_ACTION}.Status_action)
			Result.extend ({IL_IMAP_ACTION}.Append_action)
		end

	selected_state_actions: LIST [NATURAL]
			-- Valid actions in selected state
		once
			create {LINKED_LIST [NATURAL]}Result.make
			Result.extend ({IL_IMAP_ACTION}.Select_action)
			Result.extend ({IL_IMAP_ACTION}.Examine_action)
			Result.extend ({IL_IMAP_ACTION}.Check_action)
			Result.extend ({IL_IMAP_ACTION}.Close_action)
			Result.extend ({IL_IMAP_ACTION}.Expunge_action)
			Result.extend ({IL_IMAP_ACTION}.Search_action)
			Result.extend ({IL_IMAP_ACTION}.Fetch_action)
			Result.extend ({IL_IMAP_ACTION}.Store_action)
			Result.extend ({IL_IMAP_ACTION}.Copy_action)
			Result.extend ({IL_IMAP_ACTION}.Uid_fetch_action)
			Result.extend ({IL_IMAP_ACTION}.Uid_store_action)
			Result.extend ({IL_IMAP_ACTION}.Uid_copy_action)
		end

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
