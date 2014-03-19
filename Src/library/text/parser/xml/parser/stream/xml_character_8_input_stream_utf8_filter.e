note
	description: "Summary description for {XML_CHARACTER_8_INPUT_STREAM_UTF8_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CHARACTER_8_INPUT_STREAM_UTF8_FILTER

inherit
	XML_CHARACTER_8_INPUT_STREAM_FILTER

create
	make

feature {NONE} -- Initialization

	make (src: like source)
		do
			set_source (src)
		end

feature -- Access		

	last_character_code: NATURAL_32
			-- Last read character

feature -- Basic operation

	read_character_code
			-- Read a character's code
			-- and keep it in `last_character_code'
		local
			c,c2,c3,c4: NATURAL_32
		do
			last_character_code := 0
			c := source_next_character_code
			if not source.end_of_input then
				if c <= 0x7F then
						-- 0xxxxxxx				
					last_character_code := c
				elseif c <= 0xDF then
						-- 110xxxxx 10xxxxxx
					c2 := source_next_character_code
					if not source.end_of_input then
						last_character_code := ((c & 0x1F) |<< 6) |
												(c2 & 0x3F)
					end
				elseif c <= 0xEF then
						-- 1110xxxx 10xxxxxx 10xxxxxx
					c2 := source_next_character_code
					if not source.end_of_input then
						c3 := source_next_character_code
						if not source.end_of_input then
							last_character_code := ((c & 0xF) |<< 12) |
													((c2 & 0x3F) |<< 6) |
													(c3 & 0x3F)
						end
					end
				elseif c <= 0xF7 then
						-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
					c2 := source_next_character_code
					if not source.end_of_input then
						c3 := source_next_character_code
						if not source.end_of_input then
							c4 := source_next_character_code
							if not source.end_of_input then
								last_character_code := ((c & 0x7) |<< 18) |
														((c2 & 0x3F) |<< 12) |
														((c3 & 0x3F) |<< 6) |
														(c4 & 0x3F)
							end
						end
					end
				end
			end
		end

	source_next_character_code: NATURAL_32
			-- Next character code from `source'
		require
			not_end_of_input: not source.end_of_input
		do
			source.read_character_code
			Result := source.last_character_code
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
