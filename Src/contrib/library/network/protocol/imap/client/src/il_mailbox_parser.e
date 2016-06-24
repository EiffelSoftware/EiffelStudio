note
	description: "A parser to get a mailbox data from server responses"
	author: "Basile Maret"
	EIS: "name=SELECT command", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-6.3.1"
	EIS: "name=EXAMINE command", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-6.3.2"
	EIS: "name=Mailbox size response", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7.3"

class
	IL_MAILBOX_PARSER

inherit

	IL_PARSER
		redefine
			make_from_text
		end

create
	make_from_response, make_from_text

feature {NONE} -- Initialization

	make_from_response (a_response: IL_SERVER_RESPONSE; a_name: STRING)
			-- Create a parser which will parse `a_response'.
		require
			correct_response: a_response /= Void and then not a_response.is_error
		do
			text := a_response.tagged_text
			untagged_responses := a_response.untagged_responses
			create regex.make
			name := a_name
		ensure
			text_set: text = a_response.tagged_text
			mailbox_list_set: untagged_responses = a_response.untagged_responses
		end

	make_from_text (a_text: STRING)
			-- Create a parser which will parse `a_text'.
		do
			precursor (a_text)
			create name.make_empty
			create {LINKED_LIST [STRING]}untagged_responses.make
		end

feature -- Basic Operations

	parse_mailbox
			-- Parse the mailbox from the response and save it to `currentmailbox'.
		require
			text_is_tagged: not is_untagged_text
		local
			l_matched: BOOLEAN
		do
			current_mailbox.set_selected (name)
			regex.compile (Tagged_mailbox_response_pattern)
			regex.match (text)
			if regex.captured_substring (1) ~ "READ-ONLY" then
				current_mailbox.set_read_only (True)
			else
				current_mailbox.set_read_only (False)
			end
			across
				untagged_responses as response
			loop
				l_matched := False
				regex.compile (Exists_pattern)
				if regex.matches (response.item) then
					current_mailbox.set_exists (regex.captured_substring (1).to_integer)
					l_matched := True
				end
				if not l_matched then
					regex.compile (Recent_pattern)
					if regex.matches (response.item) then
						current_mailbox.set_recent (regex.captured_substring (1).to_integer)
						l_matched := True
					end
				end
				if not l_matched then
					regex.compile (Unseen_pattern)
					if regex.matches (response.item) then
						current_mailbox.set_unseen (regex.captured_substring (1).to_integer)
						l_matched := True
					end
				end
				if not l_matched then
					regex.compile (Uid_next_pattern)
					if regex.matches (response.item) then
						current_mailbox.set_uid_next (regex.captured_substring (1).to_integer)
						l_matched := True
					end
				end
				if not l_matched then
					regex.compile (Uid_validity_pattern)
					if regex.matches (response.item) then
						current_mailbox.set_uid_validity (regex.captured_substring (1).to_integer)
						l_matched := True
					end
				end
				if not l_matched then
					regex.compile (Flag_response_pattern)
					if regex.matches (response.item) then
						current_mailbox.set_flags (parse_flags (regex.captured_substring (1)))
						l_matched := True
					end
				end
				if not l_matched then
					regex.compile (Permanent_flags_pattern)
					if regex.matches (response.item) then
						current_mailbox.set_permanent_flags (parse_flags (regex.captured_substring (1)))
					end
				end
			end
			current_mailbox.unset_updated
		end

	status_update
			-- Update the current mailbox with info from text
		require
			text_is_untagged: is_untagged_text
		local
			l_matched: BOOLEAN
		do
			regex.compile (Exists_pattern)
			if regex.matches (text) then
				current_mailbox.set_exists (regex.captured_substring (1).to_integer)
				l_matched := true
			end
			if not l_matched then
				regex.compile (Recent_pattern)
				if regex.matches (text) then
					current_mailbox.set_recent (regex.captured_substring (1).to_integer)
					l_matched := true
				end
			end
			if not l_matched then
				regex.compile (Expunge_pattern)
				if regex.matches (text) then
					current_mailbox.add_recent_expunge (regex.captured_substring (1).to_integer)
					l_matched := true
				end
			end
			if not l_matched then
				regex.compile (Fetch_pattern)
				if regex.matches (text) then
					current_mailbox.add_recent_flag_fetch (regex.captured_substring (1).to_integer, parse_flags (regex.captured_substring (2)))
				end
			end
		end

	is_untagged_text: BOOLEAN
			-- Returns true iff the text is and untagged response
		do
			regex.compile (Untagged_response_pattern)
			Result := regex.matches (text)
		end

feature {NONE} -- Constants

	Tagged_mailbox_response_pattern: STRING = "^il\d+ OK \[(READ-ONLY|READ-WRITE)].*%R%N$"
			-- Represents the tagged response of a SELECT or EXAMINE command
			-- Example : il2 OK [READ-WRITE] Select completed (0.000 secs).

	Flag_response_pattern: STRING = "^\* FLAGS \((.+)\)%R%N$"
			-- Represents a FLAGS untagged response
			-- Example : * FLAGS (\Answered \Flagged \Deleted \Seen \Draft NonJunk)

	Flag_pattern: STRING = "([^ ]+)"
			-- Represents a single flag
			-- Match example : \Answered
			-- Could be matched in : * FLAGS (\Answered \Flagged \Deleted \Seen \Draft NonJunk)

	Exists_pattern: STRING = "^\* ([0-9]+) EXISTS%R%N$"
			-- Represents an untagged EXISTS response and captures the number
			-- Example : * 243 EXISTS

	Recent_pattern: STRING = "^\* ([0-9]+) RECENT%R%N$"
			-- Represents an untagged RECENT response and captures the number
			-- Example : * 1 RECENT

	Expunge_pattern: STRING = "^\* ([0-9]+) EXPUNGE%R%N$"
			-- Represents an untagged EXPUNGE response and captures the number
			-- Example : * 1 EXPUNGE

	Unseen_pattern: STRING = "^\* OK \[UNSEEN ([0-9]+)].*%R%N$"
			-- Represents an untagged response with UNSEEN data and captures the sequence number
			-- Example : * OK [UNSEEN 12] Message 12 is first unseen

	Permanent_flags_pattern: STRING = "^\* OK \[PERMANENTFLAGS \((.+)\)].*%R%N$"
			-- Represents an untagged response with PERMANENTFLAGS data and captures the flags
			-- Example : * OK [PERMANENTFLAGS (\Answered \Flagged \Deleted \Seen \Draft NonJunk \*)] Flags permitted.

	Uid_next_pattern: STRING = "^\* OK \[UIDNEXT ([0-9]+)].*%R%N$"
			-- Represents an untagged response with UIDNEXT data and captures the next uid
			-- Example : * OK [UIDNEXT 1564] Predicted next UID

	Uid_validity_pattern: STRING = "^\* OK \[UIDVALIDITY ([0-9]+)].*%R%N$"
			-- Represents an untagged response with UIDVALIDITY data and captures the number
			-- Example : * OK [UIDVALIDITY 1447670969] UIDs valid

	Fetch_pattern: STRING = "^\* ([0-9]+) FETCH \(FLAGS \((.+)\)\)%R%N$"
			-- Represents an untagged FETCH response with flags as a status update
			-- Example : * 3 FETCH (FLAGS (\Seen \Draft))

feature {NONE} -- Implementation

	untagged_responses: LIST [STRING]

	name: STRING

	parse_flags (a_raw_flags: STRING): LIST [STRING]
			-- Return a list containing the flags in `raw_flags'
		local
			l_flag_regex: RX_PCRE_REGULAR_EXPRESSION
		do
			create {LINKED_LIST [STRING]}Result.make
			create l_flag_regex.make
			l_flag_regex.compile (Flag_pattern)
			from
				l_flag_regex.match (a_raw_flags)
			until
				not l_flag_regex.has_matched
			loop
				Result.extend (l_flag_regex.captured_substring (0))
				l_flag_regex.next_match
			end
		end
note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
