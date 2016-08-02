note
	description: "A parser the message header"
	author: "Basile Maret"

class
	IL_HEADER_PARSER


inherit
	IL_PARSER

create
	make_from_text


feature -- Basic operation

	from_field: TUPLE [STRING, STRING]
			-- Returns a tuple of the name and the email address if `text' matches a from header field
		do
			create Result.default_create
			regex.compile (From_pattern)
			if regex.matches (text) then
				Result.item (Result.lower) := regex.captured_substring (3)
				Result.item (Result.upper) := regex.captured_substring (4)
			else
				Result.item (Result.lower) := field ("From")
				Result.item (Result.upper) := ""
			end
		end

	to_field: TUPLE [STRING, STRING]
			-- Returns a tuple of the name and the email address if `text' matches a to header field
		do
			create Result.default_create
			regex.compile (To_pattern)
			if regex.matches (text) then
				Result.item (Result.lower) := regex.captured_substring (3)
				Result.item (Result.upper) := regex.captured_substring (4)
			else
				Result.item (Result.lower) := field ("To")
				Result.item (Result.upper) := ""
			end
		end

	subject_field: STRING
			-- Returns the content of a subject field if `text' matches a subject header fied
		do
			regex.compile (Subject_pattern)
			if regex.matches (text) then
				Result := regex.captured_substring (2)
			else
				create Result.make_empty
			end
		end

	date_field: DATE_TIME
			-- Returns the date of the mesage
		do
			regex.compile (Date_pattern)
			if regex.matches (text) then
				create Result.make (regex.captured_substring (3).to_integer, months.at (regex.captured_substring (2)), regex.captured_substring (1).to_integer, regex.captured_substring (4).to_integer, regex.captured_substring (5).to_integer, regex.captured_substring (6).to_integer)
			else
				create Result.make (1970, 1, 1, 0, 0, 0)
			end
		end

	field (a_field_name: STRING): STRING
			-- Return the data for the field `a_field_name'
			-- It is recommended that `a_field_name' starts with an upper case char
		require
			a_field_name_not_empty: a_field_name /= Void and then not a_field_name.is_empty
		do
			create Result.make_empty
			regex.compile (a_field_name + Field_pattern)
			if regex.matches (text) then
				Result := regex.captured_substring (1)
			else
				a_field_name.to_upper
				regex.compile (a_field_name + Field_pattern)
				if regex.matches (text) then
					Result := regex.captured_substring (1)
				end
				a_field_name.to_lower
				regex.compile (a_field_name + Field_pattern)
				if regex.matches (text) then
					Result := regex.captured_substring (1)
				end
			end
		end


feature {NONE} -- Constants

	From_pattern: STRING = "(from|From): (%"?)(.*)\2\ <(.+@.+\..+)>"
			-- Represents a "From" field in a header
			-- Example : From: Basile Maret <basile.maret@server.ch>

	To_pattern: STRING = "(to|To): (%"?)(.*)\2\ ?<(.+@.+\..+)>"
			-- Represents a "To" field in a header
			-- Example : To: Basile Maret <basile.maret@server.ch>

	Subject_pattern: STRING = "(subject|Subject): (.*)%R%N"
			-- Represents a "Subject" field in a header
			-- Example : Subject: test

	Field_pattern: STRING = ": (.*)%R%N"
			-- Represents a field in a header
			-- Example : Content-Type: text/plain; charset=utf-8; format=flowed

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
