note
	description: "Summary description for {APP_OUTPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APP_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (f: FILE)
		do
			output := f
			create offset.make_empty
			tab := "    "
		end

feature -- Access

	output: FILE

	offset: STRING

	tab: STRING

feature -- Operation

	indent
		do
			offset.append (tab)
		ensure
			old (offset.count) + tab.count = offset.count
		end

	exdent
		require
			offset.count >= tab.count
		do
			offset.remove_tail (tab.count)
		end

	flush
		do
			output.flush
		end

	last_was_newline: BOOLEAN

	put_string (s: READABLE_STRING_32)
		local
			i,j,n: INTEGER
			c: CHARACTER
		do
			if last_was_newline then
				last_was_newline := False
				output.put_string (offset)
			end
			if s.has ('%N') then
				from
					i := 1
					j := 1
					n := s.count
				until
					i <= 0 or j > n
				loop
					i := s.index_of ('%N', j)
					if i > 0 then
						output.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s.substring (j, i)))
						if i = n then
							last_was_newline := True
						else
							output.put_string (offset)
						end
						j := i + 1
					else
						output.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s.substring (j, n)))
					end
				end
				if s [s.count] = '%N' then
					last_was_newline := True
				end
			else
				output.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s))
			end
		end

	put_line_divider
		do
			put_string (line_divider)
		end

	line_divider: STRING_8
		local
			i: INTEGER
		once
			create Result.make (30 + 2)
			from
				i := 30
				create Result.make (i + 2)
--				Result.append_character ('%N')
			until
				i = 0
			loop
				Result.append_character ('_')
				i := i - 1
			end
			Result.append_character ('%N')
			Result.append_character ('%N')
		end


end
