note
	description: "A server response"
	author: "Basile Maret"
	EIS: "name=Server responses", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7"

class
	IL_SERVER_RESPONSE

inherit

	IL_CONSTANTS

create
	make_with_tagged_text, make_empty, make_error

feature {NONE} -- Initialization

	make_with_tagged_text (a_text: STRING)
			-- Initialize with `a_text' as `tagged_text'
		require
			a_text_not_empty: a_text /= Void and then not a_text.is_empty
		do
			tagged_text := a_text
			create {LINKED_LIST [STRING]}untagged_responses.make
			create fetch_responses.make (0)
			status := Command_no_label
			is_error := false
			create response_code.make_empty
			create information_message.make_empty
			create current_fetch.make_with_sequence_number (0)
			last_fetch_complete := true
		ensure
			tagged_text_set: tagged_text = a_text
		end


	make_empty
			-- Create an empty server response
			-- This is used to add the untagged responses before the tagged response
		do
			tagged_text := ""
			create {LINKED_LIST [STRING]}untagged_responses.make
			create fetch_responses.make (0)
			status := Command_no_label
			is_error := false
			create response_code.make_empty
			create information_message.make_empty
			create current_fetch.make_with_sequence_number (0)
			last_fetch_complete := true
		end

	make_error
			-- Create an error response
			-- This is used when the message could not be parsed
		do
			tagged_text := ""
			create {LINKED_LIST [STRING]}untagged_responses.make
			create fetch_responses.make (0)
			status := Command_no_label
			is_error := true
			create response_code.make_empty
			create information_message.make_empty
			create current_fetch.make_with_sequence_number (0)
			last_fetch_complete := true
		end

feature -- Access

	tagged_text: STRING
			-- The text of the tagged response closing the response

	status: STRING
			-- The status of the response

	response_code: STRING
			-- The response code inside the square brackets in the tagged text

	information_message: STRING
			-- The human readable information message in the tagged text

	untagged_responses: LIST [STRING]
			-- A list of the untagged responses before the closing tagged response

	fetch_responses: HASH_TABLE [IL_FETCH, NATURAL]
			-- A table of the untagged FETCH responses before the closing tagged response

	is_error: BOOLEAN
			-- Set to true if the response could not be received from the server

	last_fetch_complete: BOOLEAN
			-- True iff there is no current fetch being built

	current_fetch: IL_FETCH
			-- The fetch currently being completed

feature -- Basic operations

	is_ok: BOOLEAN
			-- Returns true iff the status is OK
		do
			Result := status ~ Command_ok_label
		end

	add_untagged_response (a_text: STRING)
			-- add an untagged response `a_text' to `untagged_response' or create a new fetch
		require
			a_text_not_empty: a_text /= Void and then not a_text.is_empty
		local
			l_parser: IL_FETCH_PARSER
		do
			create l_parser.make_from_text (a_text)
			if l_parser.is_fetch_response then
				debugger.debug_print (debugger.debug_info, "FETCH response starting")
				create current_fetch.make_with_sequence_number (l_parser.sequence_number)
				last_fetch_complete := false
				if l_parser.parse_data (current_fetch) then
					set_fetch_complete
				end
			else
				untagged_responses.extend (l_parser.text)
			end
		end

	set_tagged_text (a_text: STRING)
			-- change the tagged_text to `a_text'
		require
			a_text_not_empty: a_text /= Void and then not a_text.is_empty
		do
			tagged_text := a_text
		ensure
			tagged_text_set: tagged_text = a_text
		end

	untagged_response_count: INTEGER
			-- Returns the number of untagged responses contained in the server response
		do
			Result := untagged_responses.count
		end

	untagged_response (i: INTEGER): STRING
			-- Returns the text of the `i'th untagged response
		require
			correct_i: i >= 0 and i < untagged_responses.count
		do
			Result := untagged_responses.first
		end

	set_status (a_status: STRING)
			-- Sets the status to `a_status'
		require
			correct_status: a_status.is_equal (Command_ok_label) or a_status.is_equal (Command_bad_label) or a_status.is_equal (Command_no_label)
		do
			status := a_status
		ensure
			status_set: status = a_status
		end

	set_response_code (a_response_code: STRING)
			-- Set the response code to `a_response_code'
		require
			a_response_code_not_void: a_response_code /= Void
		do
			response_code := a_response_code
		end

	set_information_message (a_information_message: STRING)
			-- Set the response code to `a_information_message'
		require
			a_information_message_not_void: a_information_message /= Void
		do
			information_message := a_information_message
		end

	add_literal (a_literal: STRING)
			-- Add `a_literal' to complete the last received fetch response
		require
			a_literal_not_void: a_literal /= Void
			needs_literal: literal_left > 0
			a_literal_not_too_long: a_literal.count <= literal_left
		do
			current_fetch.add_literal (a_literal)
		ensure
			literal_added: literal_left = old literal_left - a_literal.count
		end

	add_text_to_fetch (a_text: STRING)
			-- Add info from `a_text' to `current_fetch'
		require
			last_fetch_not_complete: not last_fetch_complete
			a_text_not_empty: a_text /= Void and then not a_text.is_empty
		local
			l_parser: IL_FETCH_PARSER
		do
			create l_parser.make_from_text (a_text)
			if l_parser.parse_data (current_fetch) then
				set_fetch_complete
			end
		end

	set_fetch_complete
			-- Save the current fetch and set `last_fetch_complete' to true
		do
			fetch_responses.put (current_fetch, current_fetch.sequence_number)
				last_fetch_complete := true
				debugger.debug_print (debugger.debug_info, "FETCH response finished and saved")
		end

	literal_left: INTEGER
			-- The number of chars that the current fetch parsing needs
		do
			Result := current_fetch.literal_left
		end

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
