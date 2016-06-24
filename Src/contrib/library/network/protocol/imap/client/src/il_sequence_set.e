note
	description: "A set of message sequence numbers or uids"
	author: "Basile Maret"

class
	IL_SEQUENCE_SET

create
	make_from_string, make_from_natural_range, make_from_string_range, make_from_list, make_last

feature {NONE} -- Initialization

	make_from_string (a_string: STRING)
			-- Set the sequence set to "`a_string'"
		require
			a_string_not_empty: a_string /= Void and then not a_string.is_empty
		do
			string := a_string
		ensure
			string_set: string = a_string
		end

	make_from_natural_range (first_message: NATURAL; last_message: NATURAL)
			-- Set the sequence to the range "`first_message':`last_message'"
		require
			correct_first_message: first_message >= 0
			correct_last_message: last_message >= first_message
		do
			string := first_message.out
			if last_message /~ first_message then
				string := string + ":" + last_message.out
			end
		end

	make_from_string_range (first_message: STRING; last_message: STRING)
			-- Set the sequence to the range "`first_message':`last_message'"
			-- `first_message' and `last_message' can either be "*" or a string representing a natural number
		require
			correct_first_message: first_message ~ "*" or else (first_message.is_integer and then first_message.to_integer >= 0)
			correct_last_message: last_message ~ "*" or else (last_message.is_integer and then ((first_message ~ "*" and last_message.to_integer >= 0) or else last_message.to_integer >= first_message.to_integer))
		do
			string := first_message
			if last_message /~ first_message then
				string := string + ":" + last_message
			end
		end

	make_from_list (a_list: LIST [NATURAL])
			-- Set the sequence to the list `a_list'
		require
			a_list_not_empty: a_list /= Void and then not a_list.is_empty
		do
			create string.make_empty
			across
				a_list as n
			loop
				string := string + n.item.out + ","
			end
			string.remove_tail (1)
		end

	make_last
			-- Set the sequence to "*"
		do
			string := "*"
		ensure
			string ~ "*"
		end

feature -- Access

	string: STRING
			-- The string representation of the sequence set

invariant
	string_not_empty: not string.is_empty

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
