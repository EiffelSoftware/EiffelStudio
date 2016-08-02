note
	description: "A manager for the server responses"
	author: "Basile Maret"
	EIS: "name=Server responses", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7"

class
	IL_RESPONSE_MANAGER

inherit

	IL_CONSTANTS

create
	make_with_network

feature {NONE} -- Initialization

	make_with_network (a_network: IL_NETWORK)
			-- Create and set `network' to `a_network'
		require
			a_network_not_void: a_network /= Void
		do
			network := a_network
			create responses_table.make (0)
			last_tag_received := Tag_prefix + "0"
			Max_stored_responses := Default_max_stored_responses
		ensure
			network_set: network = a_network
		end

feature -- Basic operations

	was_connection_ok: BOOLEAN
			-- Returns true if the last response sent by the server was an OK untagged response
		local
			l_parser: IL_PARSER
		do
			create l_parser.make_from_text (network.line)
			Result := l_parser.matches_connection_ok
		end

	update_responses (a_tag: STRING)
			-- Updates the response table with responses up to `tag'
		require
			tag_not_empty: a_tag /= Void and then not a_tag.is_empty
		do
			from
			until
				responses_table.has (a_tag) or not network.is_connected or network.needs_continuation
			loop
				get_next_response
			end
			remove_old_responses
		end

	response (a_tag: STRING): IL_SERVER_RESPONSE
			-- Returns the server response that the server gave for command with tag `a_tag'
		require
			tag_not_empty: a_tag /= Void and then not a_tag.is_empty
		local
			l_server_response: detachable IL_SERVER_RESPONSE
		do
			from
			until
				responses_table.has (a_tag) or not network.is_connected or network.needs_continuation
			loop
				get_next_response
			end
			l_server_response := responses_table.at (a_tag)
			if attached {IL_SERVER_RESPONSE} l_server_response then
				Result := l_server_response
			else
				create Result.make_error
			end
			remove_old_responses
		ensure
			Result_not_void: Result /= Void
		end

	set_max_stored_responses (a_max: INTEGER)
			-- Change the number of stored response. When this number is reached, the oldest responses are removed
		require
			a_max_correct: a_max > 0
		do
			max_stored_responses := a_max
		end

feature {NONE} -- Implementation

	get_next_response
			-- Gets the next response from the network, parse it and add it to the response array
		local
			l_response, l_tag: STRING
			l_parser: IL_PARSER
			l_server_response: detachable IL_SERVER_RESPONSE
		do
			l_response := network.line
			if not l_response.is_empty then
				l_response.append_string ("%N")

				-- The first two branches are when the current fetch needs to be completed.
				l_server_response := responses_table.at (Next_response_tag)
				if attached {IL_SERVER_RESPONSE} l_server_response and then l_server_response.literal_left > 0 then
					add_literal_action (l_response, l_server_response)

				elseif attached {IL_SERVER_RESPONSE} l_server_response and then not l_server_response.last_fetch_complete then
					create l_parser.make_from_text (l_response)
					if l_parser.is_tagged_response then
						l_server_response.set_fetch_complete
						tagged_action (l_response, l_parser, l_parser.tag)
					elseif l_parser.is_fetch_response then
						l_server_response.set_fetch_complete
						untagged_action (l_parser)
						check_for_mailbox_update (l_response)
					else
						l_server_response.add_text_to_fetch (l_response)
					end

				-- This branch is for all other cases
				else
					create l_parser.make_from_text (l_response)
					l_tag := l_parser.tag
					if l_parser.matches_bye then
						bye_action
					elseif l_tag ~ "*" then
						untagged_action (l_parser)
						check_for_mailbox_update (l_response)
					elseif l_tag ~ "+" then
							-- When the l_tag is "+", the server needs the continuation of the request
						network.set_needs_continuation (true)
					elseif l_parser.is_tagged_response  then
						tagged_action (l_response, l_parser, l_tag)
					else
						debugger.debug_print (debugger.debug_warning, debugger.Could_not_parse_response)
					end
				end
			else
				network.set_state ({IL_NETWORK_STATE}.Not_connected_state)
				debugger.debug_print (debugger.debug_warning, "Empty answer received. We are now disconnected")
			end
		end

	bye_action
			-- When the response is a bye response, we are in a disconnected state
		do
			network.set_state ({IL_NETWORK_STATE}.Not_connected_state)
			debugger.debug_print (debugger.Debug_warning, "BYE answer received. We are now disconnected")
		end

	untagged_action (a_parser: IL_PARSER)
			-- When the response is an untagged response
		require
			a_parser_not_void: a_parser /= Void
		local
			l_server_response: detachable IL_SERVER_RESPONSE
		do
				-- We create a temporary entry in the `responses_table' to store the new IL_SERVER_RESPONSE
			if responses_table.has (Next_response_tag) then
				l_server_response := responses_table.at (Next_response_tag)
				if l_server_response = Void then
					create l_server_response.make_empty
				end
			else
				create l_server_response.make_empty
				responses_table.put (l_server_response, Next_response_tag)
			end
			l_server_response.add_untagged_response (a_parser.text)
		end

	add_literal_action (a_response: STRING; server_response: IL_SERVER_RESPONSE)
			-- When the response is the continuation of the previous one
		require
			a_response_not_empty: a_response /= Void and then not a_response.is_empty
			server_response_needs_literal: server_response /= Void and then server_response.literal_left > 0
		do
			server_response.add_literal (a_response)
		end

	empty_action (a_response: STRING)
			-- When the response has an empty tag
		local
			l_server_response: detachable IL_SERVER_RESPONSE
		do
				-- When the tag is empty, it means this is the continuation of the previous message
			check
				previous_response_exists: responses_table.has (Next_response_tag)
			end
			l_server_response := responses_table.at (Next_response_tag)
			if l_server_response /= Void then
				l_server_response.untagged_responses.last.append (" " + a_response)
			end
		end

	tagged_action (a_response: STRING; a_parser: IL_PARSER; tag: STRING)
			-- When the response is a tagged response
		local
			l_server_response: detachable IL_SERVER_RESPONSE
		do
				-- We check for a temporary entry in the `response_table'. If it exists this will be the IL_SERVER_RESPONSE.
			if responses_table.has (Next_response_tag) then
				l_server_response := responses_table.at (Next_response_tag)
				responses_table.remove (Next_response_tag)
			end
			if l_server_response = Void then
				create l_server_response.make_empty
			end
			l_server_response.set_tagged_text (a_response)
			l_server_response.set_status (a_parser.status)

			if a_parser.status /~ Command_ok_label then
				debugger.debug_print (debugger.debug_warning, debugger.Server_response_not_ok)
			end

			l_server_response.set_response_code (a_parser.response_code)
			l_server_response.set_information_message (a_parser.information_message)

			responses_table.put (l_server_response, tag)
			last_tag_received := tag
		end

	check_for_mailbox_update (a_response: STRING)
			-- Check if the response contains information about the open mailbox and update it if it is the case
		require
			a_response_not_empty: a_response /= Void and then not a_response.is_empty
		local
			l_mailbox_parser: IL_MAILBOX_PARSER
		do
			if network.state = {IL_NETWORK_STATE}.selected_state then
				create l_mailbox_parser.make_from_text (a_response)
				l_mailbox_parser.status_update
			end
		end

	remove_old_responses
			-- Removes the responses older than last_response - Max_stored_responses
		local
			l_last_tag_number_received: INTEGER
			i: INTEGER
			l_parser: IL_PARSER
			l_key: STRING
		do
			if responses_table.count > Max_stored_responses then
				create l_parser.make_from_text (last_tag_received)
				l_last_tag_number_received := l_parser.number
				from
					i := last_tag_deleted
				until
					i > l_last_tag_number_received - Max_stored_responses
				loop
					l_key := Tag_prefix + i.out
					responses_table.remove (l_key)
					last_tag_deleted := i
					i := i + 1
				end
			end
		end

	responses_table: HASH_TABLE [IL_SERVER_RESPONSE, STRING]

	last_tag_received: STRING

	last_tag_deleted: INTEGER

	network: IL_NETWORK

	Max_stored_responses: INTEGER
			-- The default maximum number of responses we store in the response manager before we start to remove them

;note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
