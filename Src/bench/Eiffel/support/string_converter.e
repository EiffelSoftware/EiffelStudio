indexing
	description: "Object that translates an Eiffel string into a valid C string."
	date: "$Date$";
	revision: "$Revision$"

class STRING_CONVERTER

feature -- Conversion

	escaped_string (s: STRING): STRING is
			-- Escaped version of `s'.
		require
			valid_arguments: s /= Void
		do
			create Result.make (s.count)
			escape_string (Result, s)
		ensure
			result_not_void: Result /= Void
		end

feature -- Commands

	escape_string (buffer: STRING; s: STRING) is
			-- Append `buffer' with the escaped version of `s'
		require
			valid_arguments: s /= Void and then buffer /= Void
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := s.count
			variant
				i
			until
				i > nb
			loop
				escape_char(buffer,s.item (i))
				i := i + 1
			end
		end

	escape_char (buffer: STRING; c: CHARACTER) is
			-- Write char `c' with C escape sequences
		require
			valid_buffer: buffer /= Void
		do
			inspect c
			 	when '"' then
					buffer.append_character ('\')
					buffer.append_character ('"')
			 	when '\' then
					buffer.append_character ('\')
					buffer.append_character ('\')
				when '%'' then
					buffer.append_character ('\')
					buffer.append_character (''')
				when '?' then
					buffer.append_character ('\')
					buffer.append_character ('?')
				else
					if c < ' ' or c > '%/127/' then
						-- Assume ASCII set, sorry--RAM.
						buffer.append_character ('\')
						putoctal (buffer,c.code)
					else
						buffer.append_character (c)
					end
			end
		end

feature {NONE} -- Implementations

	putoctal (buffer: STRING; i: INTEGER) is
			-- Print octal representation of `i' into `buffer'
			--| always generate 3 digits
		local
			val, remain: INTEGER
			s, t: STRING
		do
			if i = 0 then
				buffer.append ("000")
			elseif i < 8 then
				buffer.append ("00")
				buffer.append_integer (i)
			else
				if i < 64 then
					buffer.append_character ('0')
				end
				
				create s.make (3)
				from
					val := i
				variant
					val + 1
				until
					val = 0
				loop
					remain := val \\ 8
					val := val // 8
					t := remain.out
					s.prepend (t)
				end
				buffer.append (s)
			end
		end


end -- class STRING_CONVERTER
