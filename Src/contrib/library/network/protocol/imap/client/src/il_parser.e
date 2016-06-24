note
	description: "A parser for the server responses"
	author: "Basile Maret"
	EIS: "name=Server responses", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7"

class
	IL_PARSER

inherit

	IL_CONSTANTS

	IL_IMAP_ACTION

create
	make_from_text

feature {NONE} -- Initialization

	make_from_text (a_text: STRING)
			-- Create a parser which will parse `a_text'
		require
			a_text_not_empty: not a_text.is_empty
		do
			text := a_text
			create regex.make
		ensure
			text_set: text = a_text
		end

feature -- Access

	text: STRING
			-- The string we need to parse

	regex: RX_PCRE_REGULAR_EXPRESSION

feature -- Basic operations

	is_tagged_response: BOOLEAN
			-- Returns true iff the text matches a tagged response
		do
			regex.compile (Tagged_response_pattern)
			Result := regex.matches (text)
		end

	matches_connection_ok: BOOLEAN
			-- Returns true iff the text matches a successful imap connection response
		do
			regex.compile (Connection_ok_pattern)
			Result := regex.matches (text)
		end

	match_capabilities: LIST [STRING]
			-- Returns a list of all the capabilities matched in text
			-- Returns an empty list if `text' doesn't match a correct capability response
		do
			regex.compile (Capabilities_pattern)
			create {LINKED_LIST [STRING]}Result.make
			if regex.matches (text) then
				create regex.make
				regex.compile (Capability_pattern)
				from
					regex.match (text)
				until
					not regex.has_matched
				loop
					Result.extend (regex.captured_substring (0))
					regex.next_match
				end
			end
		end

	matches_bye: BOOLEAN
			-- Returns true iff the text matches a BYE response
		do
			regex.compile (Bye_pattern)
			Result := regex.matches (text)
		end

	tag: STRING
			-- Returns the tag from the text
		do
			regex.compile (Tag_pattern)
			if regex.matches (text) then
				Result := regex.captured_substring (1)
			else
				Result := ""
			end
		end

	status: STRING
			-- Returns the status from the text
		do
			regex.compile (Status_pattern)
			if regex.matches (text) then
				Result := regex.captured_substring (1)
			else
				Result := ""
			end
		ensure
			correct_status: Result.is_equal (Command_ok_label) or Result.is_equal (Command_bad_label) or Result.is_equal (Command_no_label)
		end

	number: INTEGER
			-- Returns the integer after "il" in `text'
		do
			regex.compile (Integer_from_tag_pattern)
			if regex.matches (text) then
				Result := regex.captured_substring (1).to_integer
			else
				Result := -1
			end
		end

	status_data: STRING_TABLE [INTEGER]
			-- Return the status data contained in the untagged response `text'
		local
			l_data: STRING
		do
			regex.compile (Status_data_response_pattern)
			if regex.matches (text) then
				l_data := regex.captured_substring (1)
				regex.compile (Status_data_pattern)
				create Result.make (0)
				from
					regex.match (l_data)
				until
					not regex.has_matched
				loop
					Result.put (regex.captured_substring (2).to_integer, regex.captured_substring (1))
					regex.next_match
				end
			else
				create Result.make (0)
			end
		end

	search_results: LIST [INTEGER]
			-- Return the ids of the messages in the search result
		local
			l_ids: STRING
		do
			create {LINKED_LIST [INTEGER]}Result.make
			regex.compile (Search_result_pattern)
			if regex.matches (text) then
				l_ids := regex.captured_substring (1)
				regex.compile (Integer_pattern)
				from
					regex.match (l_ids)
				until
					not regex.has_matched
				loop
					Result.extend (regex.captured_substring (0).to_integer)
					regex.next_match
				end
			end
		end

	response_code: STRING
			-- Return the response code in the bracket if text is matching a tagged message with a response code
		do
			regex.compile (Response_code_pattern)
			if regex.matches (text) then
				Result := regex.captured_substring (2)
			else
				create Result.make_empty
			end
		end

	information_message: STRING
			-- Return the information message if text is matching a tagged message with an information message
		do
			regex.compile (Information_message_pattern)
			if regex.matches (text) then
				Result := regex.captured_substring (3)
			else
				create Result.make_empty
			end
		end

	is_fetch_response: BOOLEAN
			-- Returns true iff the text matches an untagged fetch response
		do
			regex.compile (First_line_fetch_pattern)
			Result := regex.matches (text)
		end

feature {NONE} -- Regex Constants

	Connection_ok_pattern: STRING = "^\* OK (.*)$"
			-- Represents the first message sent by the server when opening a connection
			-- Example : * OK The Microsoft Exchange IMAP4 service is ready.

	Bye_pattern: STRING = "^\* BYE (.*)%R%N$"
			-- Represents a BYE response
			-- Example : * BYE Logging out

	Capability_pattern: STRING = "(([A-Z]|=|rev|\d|\+|-)+)"
			-- Represent an item of a CAPABILITY response
			-- Example : IMAP4rev1
			-- Example : AUTH=PLAIN
			-- Could be matched in : * CAPABILITY IMAP4rev1 LITERAL+ SASL-IR LOGIN-REFERRALS ID ENABLE IDLE AUTH=PLAIN AUTH=CRAM-MD5

	Capabilities_pattern: STRING = "^\* ([A-Z]|=|rev|\d|\+|-| )*IMAP4rev1([A-Z]|=|rev|\d|\+|-| )*%R%N$"
			-- Represent a CAPABILITY response
			-- Example : * CAPABILITY IMAP4rev1 LITERAL+ SASL-IR LOGIN-REFERRALS ID ENABLE IDLE AUTH=PLAIN AUTH=CRAM-MD5

	Untagged_response_pattern: STRING = "^\* (.*)%R%N$"
			-- Represents an untagged response
			-- Example : * 3 EXISTS
			-- Example : * OK [UIDNEXT 17] Predicted next UID

	Tagged_response_pattern: STRING = "^il\d+ .*%R%N$"
			-- Represents a tagged response
			-- Example : il2 OK Logged in

	Tag_pattern: STRING = "^(\*|il\d+|\+) "
			-- Represents the first part of a response. It is either a * (untagged), a tag (tagged) or a + (continuation request)

	Integer_from_tag_pattern: STRING = "^il(\d+)$"
			-- Represents a tag and captures the tag number

	Status_pattern: STRING = "^il\d+ (OK|NO|BAD)"
			-- Represents the beginning of a tagged response and captures its status (OK, NO or BAD)
			-- Match example : il5 OK
			-- Could be matched in : il5 OK Status completed.

	Status_data_response_pattern: STRING = "^\* STATUS .* \((.+)\)%R%N$"
			-- Represents an untagged STATUS response
			-- Example : * STATUS INBOX (RECENT 2)


	Status_data_pattern: STRING = "(MESSAGES|RECENT|UIDNEXT|UIDVALIDITY|UNSEEN) ([0-9]+) ?"
			-- Repesents one of the data item of a STATUS response and its value
			-- Match example : RECENT 2
			-- Could be matched in : * STATUS INBOX (RECENT 2 MESSAGES 243)

	Search_result_pattern: STRING = "^\* SEARCH ([0-9 ]+)%R%N$"
			-- Represents a SEARCH untagged response and captures the uids
			-- Example : * SEARCH 1 2 3

	Integer_pattern: STRING = "\d+"
			-- Represents an integer

	Response_code_pattern: STRING = "^il\d+ (OK|NO|BAD) \[([A-Z]+)].*%R%N$"
			-- Matches a tagged response and captures the response code
			-- Example : il6 OK [READ-WRITE] Select completed (0.000 secs).
			-- Example would cature : READ-WRITE

	Information_message_pattern: STRING = "^il\d+ (OK|NO|BAD) (\[.+] )?(.*)%R%N$"
			-- Matches a tagged response and captures the information message. This is an optional human readable message at the end of the response
			-- Example : il6 OK [READ-WRITE] Select completed (0.000 secs).
			-- Example would capture : Select completed (0.000 secs).

	Date_pattern: STRING = ".*[A-Za-z]+, (\d?\d) ([A-Z][a-z][a-z]) (\d\d\d\d) (\d?\d):(\d\d):(\d\d)"
			-- Represents a date as present in the header field "Date"
			-- Example : Mon, 16 Nov 2015 11:52:34 +0100

	First_line_fetch_pattern: STRING = "^\* (\d+) FETCH \([^{]*\)?({(\d+)})?%R%N$"
			-- Represents the first line of a multiline untagged FETCH response
			-- Example : * 3 FETCH (BODY[HEADER] {553}


feature {NONE} -- Constants

	Tag_position: INTEGER = 1

	Command_result_position: INTEGER = 2

	Untagged_label: String = "*"

feature {NONE} -- Implementation

	months: STRING_TABLE[INTEGER]
			-- maps the months abreviation to their number
		once
			create Result.make (12)
			Result.put (1, "Jan")
			Result.put (2, "Feb")
			Result.put (3, "Mar")
			Result.put (4, "Apr")
			Result.put (5, "May")
			Result.put (6, "Jun")
			Result.put (7, "Jul")
			Result.put (8, "Aug")
			Result.put (9, "Sep")
			Result.put (10, "Oct")
			Result.put (11, "Nov")
			Result.put (12, "Dec")
		end

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
