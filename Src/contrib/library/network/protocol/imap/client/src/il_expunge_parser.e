note
	description: "A parser for the EXPUNGE server responses"
	author: "Basile Maret"
	EIS: "name=EXPUNGE command", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-6.4.3"
	EIS: "name=EXPUNGE response", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7.4.1"

class
	IL_EXPUNGE_PARSER

inherit

	IL_PARSER

create
	make_from_response

feature {NONE} -- Initialization

	make_from_response (a_response: IL_SERVER_RESPONSE)
			-- Create a parser which will parse `a_response'.
		require
			correct_response: a_response /= Void and then not a_response.is_error
		do
			text := a_response.tagged_text
			untagged_responses := a_response.untagged_responses
			create regex.make
		ensure
			text_set: text = a_response.tagged_text
			mailbox_list_set: untagged_responses = a_response.untagged_responses
		end

feature -- Basic Operations

	parse_expunged: LIST [INTEGER]
			-- Parse the response and return the list of deleted messages.
		do
			create {LINKED_LIST [INTEGER]}Result.make
			from
				untagged_responses.start
			until
				untagged_responses.after
			loop
				regex.compile (Expunge_pattern)
				if regex.matches (untagged_responses.item) then
					Result.extend (regex.captured_substring (1).to_integer)
				end
				untagged_responses.forth
			end
		end

feature {NONE} -- Constants

	Expunge_pattern: STRING = "^\* ([0-9]+) EXPUNGE%R%N$"
			-- Represents an untagged EXPUNGE response and captures the sequence number
			-- Example : * 44 EXPUNGE

feature {NONE} -- Implementation

	untagged_responses: LIST [STRING]

;note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
