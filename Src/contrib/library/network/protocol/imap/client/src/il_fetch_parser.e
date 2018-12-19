note
	description: "A parser for the FETCH server response"
	author: "Basile Maret"
	EIS: "name=FETCH command", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-6.4.5"
	EIS: "name=FETCH response", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7.4.2"

class
	IL_FETCH_PARSER

inherit

	IL_PARSER
	redefine
		make_from_text
	end

create
	make_from_text

feature {NONE} -- Initialization

	make_from_text (a_text: STRING)
			-- Create a parser which will parse `a_text'.
		do
			Precursor (a_text)
			create fetch.make_with_sequence_number (0)
		end

feature -- Basic operations

	sequence_number: NATURAL
			-- Returns the sequence number fetched from `text' or returns 0 if `text' did not match.
		do
			regex.compile (First_line_fetch_pattern)
			if regex.matches (text) then
				Result := regex.captured_substring (1).to_natural
			else
				Result := 0
			end
		end

	parse_data (a_fetch: IL_FETCH): BOOLEAN
			-- Parse the data from fetch and add it to `a_fetch'.
			-- Returns true iff the fetch is complete
		require
			a_fetch_not_void: a_fetch /= Void
		do
			fetch := a_fetch
			regex.compile (Fetch_end_pattern)
			if regex.matches (text) then
				Result := true
			else
				regex.compile (Complete_fetch_pattern)

				if regex.matches (text) then
					text := regex.captured_substring (1)
					Result := true
				else
					fetch_bodyb
					Result := false
				end
				fetch_bodystructure
				fetch_body
				fetch_envelope
				fetch_internaldate
				fetch_flags
				fetch_size
				fetch_uid
			end

		end

feature {NONE} -- Constants

	Bodyb_pattern: STRING = "(BODY(\.PEEK)?(\[.*])|RFC822|RFC822\.HEADER|RFC822.TEXT) {(\d+)}%R%N"
			-- Captures the beginning of a data item which will have its value on the following lines
			-- Match example : BODY[TEXT] {6}
			-- Could be matched in : * 3 FETCH (FLAGS (\Seen \Draft) UID 16 BODY[TEXT] {6}

	Body_pattern: STRING = "(BODY) \((((?![A-Z] \().)*)\)"
			-- Represents a BODY data item with its value.
			-- Match example : BODY ("text" "plain" ("charset" "utf-8" "format" "flowed") NIL NIL "7bit" 6 1)
			-- Could be matched in : * 3 FETCH (BODY ("text" "plain" ("charset" "utf-8" "format" "flowed") NIL NIL "7bit" 6 1) UID 16)

	Flags_pattern: STRING = "(FLAGS) \(([^)]*)\)"
			-- Represents a FLAGS data item with its value
			-- Match example : FLAGS (\Seen \Draft)
			-- Could be matched in : * 3 FETCH (FLAGS (\Seen \Draft) UID 16 BODY[TEXT] {6}

	Bodystructure_pattern: STRING = "(BODYSTRUCTURE) \((((?![A-Z] \().)*)\)"
			-- Represents a BODYSTRUCTURE data item with its value
			-- Match example : BODYSTRUCTURE ("text" "plain" ("charset" "utf-8" "format" "flowed") NIL NIL "7bit" 6 1 NIL NIL NIL NIL)
			-- Could be matched in : * 3 FETCH (BODYSTRUCTURE ("text" "plain" ("charset" "utf-8" "format" "flowed") NIL NIL "7bit" 6 1 NIL NIL NIL NIL) UID 16)

	Envelope_pattern: STRING = "(ENVELOPE) \(((%"[^%"]*%" ?|\((\((%"[^%"]*%" ?|NIL ?)+\))+\) ?|NIL ?)+)\)"
			-- Represents an ENVELOPE data item with its value
			-- Match example : ENVELOPE ("Mon, 16 Nov 2015 11:52:34 +0100" "subject" (("Basile Maret" NIL "basile.maret" "server.ch")) (("Basile Maret" NIL "basile.maret" "server.ch")) (("Basile Maret" NIL "basile.maret" "server.ch")) ((NIL NIL "someone.else" "server.com")) NIL NIL NIL "<5649B572.1070608@server.ch>"))

	Internaldate_pattern: STRING = "(INTERNALDATE) %"([^%"]*)%""
			-- Represents an INTERNALDATE data item with its value
			-- Match example : INTERNALDATE "16-Nov-2015 11:52:34 +0100"

	Size_pattern: STRING = "(RFC822\.SIZE) (\d+)"
			-- Represents a RFC822.SIZE data item with its value
			-- Match example : RFC822.SIZE 559
			-- Could be matched in : * 3 FETCH (UID 16 RFC822.SIZE 559)

	Uid_pattern: STRING = "(UID) (\d+)"
			-- Represents a UID data item with its value
			-- Match example : UID 16
			-- Could be matched in : * 3 FETCH (FLAGS (\Seen \Draft) UID 16 BODY[TEXT] {6}

	Fetch_end_pattern: STRING = "^ ?\)%R%N$"
			-- Represents the end of a FETCH untagged response. This is only a single closing parenthesis ) preceded by an optional white space

	Complete_fetch_pattern: STRING = "^\* \d+ FETCH \(([^{]*)\)%R%N$"
			-- Represent a one line untagged FETCH response
			-- Example : * 3 FETCH (UID 16 FLAGS (\Seen \Draft) RFC822.SIZE 559 INTERNALDATE "16-Nov-2015 11:52:34 +0100")

feature {NONE} -- Implementation

	fetch: IL_FETCH

	fetch_body
			-- Parses body data if text matches it
		local
			l_new_data: TUPLE [INTEGER, STRING]
			l_body: STRING
		do
			regex.compile (Body_pattern)
			if regex.matches (text) then
				l_body := regex.captured_substring (2)
				create l_new_data.default_create
				l_new_data.put (l_body.count, 1)
				l_new_data.put (l_body, 2)
				fetch.data.extend (l_new_data, regex.captured_substring (1))
			end
		end

	fetch_bodyb
			-- Parses a body data if text matches it
		local
			l_size: INTEGER
		do
			regex.compile (Bodyb_pattern)
			if regex.matches (text) then
				fetch.set_last_key (regex.captured_substring (1))
				l_size := regex.captured_substring (4).to_integer
				fetch.last_item.put (l_size, 1)
				fetch.last_item.put (create {STRING}.make_empty, 2)
				fetch.set_literal_left (l_size)
			end
		end

	fetch_flags
			-- Parses flags data if text matches it
		local
			l_new_data: TUPLE [INTEGER, STRING]
			l_flags: STRING
		do
			regex.compile (Flags_pattern)
			if regex.matches (text) then
				l_flags := regex.captured_substring (2)
				create l_new_data.default_create
				l_new_data.put (l_flags.count, 1)
				l_new_data.put (l_flags, 2)
				fetch.data.extend (l_new_data, regex.captured_substring (1))
			end
		end

	fetch_bodystructure
			-- Parses bodystructure data if text matches it
		local
			l_new_data: TUPLE [INTEGER, STRING]
			l_bodystructure: STRING
		do
			regex.compile (Bodystructure_pattern)
			if regex.matches (text) then
				l_bodystructure := regex.captured_substring (2)
				create l_new_data.default_create
				l_new_data.put (l_bodystructure.count, 1)
				l_new_data.put (l_bodystructure, 2)
				fetch.data.extend (l_new_data, regex.captured_substring (1))
			end
		end

	fetch_envelope
			-- Parses envelope data if text matches it
		local
			l_new_data: TUPLE [INTEGER, STRING]
			l_envelope: STRING
		do
			regex.compile (Envelope_pattern)
			if regex.matches (text) then
				l_envelope := regex.captured_substring (2)
				create l_new_data.default_create
				l_new_data.put (l_envelope.count, 1)
				l_new_data.put (l_envelope, 2)
				fetch.data.extend (l_new_data, regex.captured_substring (1))
			end
		end

	fetch_internaldate
			-- Parses internaldate data if text matches it
		local
			l_new_data: TUPLE [INTEGER, STRING]
			l_internaldate: STRING
		do
			regex.compile (Internaldate_pattern)
			if regex.matches (text) then
				l_internaldate := regex.captured_substring (2)
				create l_new_data.default_create
				l_new_data.put (l_internaldate.count, 1)
				l_new_data.put (l_internaldate, 2)
				fetch.data.extend (l_new_data, regex.captured_substring (1))
			end
		end

	fetch_size
			-- Parses size data if text matches it
		local
			l_new_data: TUPLE [INTEGER, STRING]
			l_size: STRING
		do
			regex.compile (Size_pattern)
			if regex.matches (text) then
				l_size := regex.captured_substring (2)
				create l_new_data.default_create
				l_new_data.put (l_size.count, 1)
				l_new_data.put (l_size, 2)
				fetch.data.extend (l_new_data, regex.captured_substring (1))
			end
		end

	fetch_uid
			-- Parses uid data if text matches it
		local
			l_new_data: TUPLE [INTEGER, STRING]
			l_uid: STRING
		do
			regex.compile (Uid_pattern)
			if regex.matches (text) then
				l_uid := regex.captured_substring (2)
				create l_new_data.default_create
				l_new_data.put (l_uid.count, 1)
				l_new_data.put (l_uid, 2)
				fetch.data.extend (l_new_data, regex.captured_substring (1))
			end
		end

note
	copyright: "2015-2018, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
