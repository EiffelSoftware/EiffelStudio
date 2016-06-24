note
	description: "A parser for list of mailbox names"
	author: "Basile Maret"
	EIS: "name=LIST command", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-6.3.8"
	EIS: "name=LIST response", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7.2.2"
	EIS: "name=LSUB command", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-6.3.9"
	EIS: "name=LSUB response", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7.2.3"

class
	IL_NAME_LIST_PARSER

inherit

	IL_PARSER

create
	make_from_response

feature {NONE} -- Initialization

	make_from_response (a_response: IL_SERVER_RESPONSE; is_lsub: BOOLEAN)
			-- Create a parser which will parse `a_response'
		require
			correct_response: a_response /= Void and then not a_response.is_error
		do
			text := a_response.tagged_text
			mailbox_list := a_response.untagged_responses
			create regex.make
			if is_lsub then
				Command := Lsub
			else
				Command := List
			end
		ensure
			text_set: text = a_response.tagged_text
			mailbox_list_set: mailbox_list = a_response.untagged_responses
		end

feature -- Basic operations

	mailbox_names: LIST [IL_NAME]
			-- Return a list with the mailbox names
		local
			l_mailbox: IL_NAME
			l_raw_path, l_raw_attributes: STRING
		do
			create {LINKED_LIST [IL_NAME]}Result.make
			regex.compile (List_item_pattern)
			from
				mailbox_list.start
			until
				mailbox_list.after
			loop
				regex.compile (list_item_pattern)
				if regex.matches (mailbox_list.item) then
					l_raw_path := regex.captured_substring (3)
					create l_mailbox.make_with_raw_path (l_raw_path)
					parse_raw_path (l_raw_path, l_mailbox, regex.captured_substring (2))
					if not regex.captured_substring (2).is_empty then
						l_mailbox.set_hierarchy_delimiter (regex.captured_substring (2).at (1))
					end
					l_raw_attributes := regex.captured_substring (1)
					parse_raw_attributes (l_raw_attributes, l_mailbox)
					Result.extend (l_mailbox)
				end
				mailbox_list.forth
			end
		end

feature {NONE} -- Constants

	List: STRING = "LIST"
			-- LIST command

	Lsub: STRING = "LSUB"
			-- LSUB command

	Command: STRING
			-- The command to execute.

	List_item_pattern: STRING
			-- Represents antagged LIST or LSUB response depending on Command
			-- Example : * LIST (\HasChildren) "." INBOX
		once
			Result := "^\* " + Command + " \((.*)\) %"(.*)%" (.+)%R%N$"
		end

	Raw_attributes_pattern: STRING = "(\\.+)"
			-- Represents an attribute of a mailbox
			-- Example : \HasChildren

feature {NONE} -- Implementation

	mailbox_list: LIST [STRING]

	parse_raw_path (a_raw_path: STRING; a_mailbox: IL_NAME; hierarchy_delimiter: STRING)
			-- Sets the path and name to `a_mailbox' from `a_raw_path'
		require
			a_raw_path_not_empty: a_raw_path /= Void and then not a_raw_path.is_empty
			a_mailbox_not_void: a_mailbox /= Void
			hierarchy_delimiter_not_void: hierarchy_delimiter /= Void
		local
			l_path_regex: RX_PCRE_REGULAR_EXPRESSION
			l_raw_path_pattern: STRING
		do
			if hierarchy_delimiter.is_empty then
				a_mailbox.set_name (a_raw_path)
			else

					-- We build the pattern depending on the hierarchy delimiter
				l_raw_path_pattern := "([^.]+)("
				if escaped_chars.has (hierarchy_delimiter) then
					l_raw_path_pattern := l_raw_path_pattern + "\"
				end
				l_raw_path_pattern := l_raw_path_pattern + hierarchy_delimiter + "?)"
				create l_path_regex.make
				l_path_regex.compile (l_raw_path_pattern)
				from
					l_path_regex.match (a_raw_path)
				until
					not l_path_regex.has_matched
				loop
					if l_path_regex.captured_substring (2).is_empty then -- This is the name of the mailbox
						a_mailbox.set_name (l_path_regex.captured_substring (1))
					else -- This is an element of the path
						a_mailbox.add_path_level (l_path_regex.captured_substring (1))
					end
					l_path_regex.next_match
				end
			end
		end

	parse_raw_attributes (a_raw_attributes: STRING; a_mailbox: IL_NAME)
			-- Sets the attributes `a_mailbox' from `a_raw_attributes'
		local
			l_attributes_regex: RX_PCRE_REGULAR_EXPRESSION
		do
			create l_attributes_regex.make
			l_attributes_regex.compile (Raw_attributes_pattern)
			from
				l_attributes_regex.match (a_raw_attributes)
			until
				not l_attributes_regex.has_matched
			loop
				a_mailbox.add_attribute (l_attributes_regex.captured_substring (0))
				l_attributes_regex.next_match
			end
		end

	escaped_chars: LIST [STRING]
			-- Charachters we need to escape in regex
		once
			create {LINKED_LIST [STRING]}Result.make
			Result.extend ("\")
			Result.extend ("^")
			Result.extend ("$")
			Result.extend (".")
			Result.extend ("[")
			Result.extend ("|")
			Result.extend ("(")
			Result.extend (")")
			Result.extend ("?")
			Result.extend ("*")
			Result.extend ("+")
			Result.extend ("{")
		end

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
