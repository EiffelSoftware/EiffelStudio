indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DES_ASCII_ENCODER

inherit
	DES_ENCODER
		redefine
			encrypt
		end

creation
	make, make_with_key

feature -- Encryption

	encrypt (s: STRING): STRING is
			-- Padding done if length not multiple of 8.
		do
			Result := {DES_ENCODER} Precursor (s)
			convert_to_ascii (Result)
		end

feature  -- Implementation

	convert_to_ascii (s: STRING) is
			-- Convert `s' into a printable characters string.
		require
			s_not_void: s /= Void
			s_exists: s.count > 0
		local
			i, count: INTEGER
			code: INTEGER
		do
			from
				i := 1
				count := s.count
			until
				i > count
			loop
				code := s.item (i).code
				inspect
					code
				when 0..47 then
					code := code \\ 10 + 48
					s.put (code.ascii_char, i)
				when 58..64 then
					s.put ((code + 7).ascii_char, i)
				when 91..96 then
					s.put ((code + 7).ascii_char, i)
				else
					code := code \\ 26 + 64
					s.put (code.ascii_char, i)
				end
				i := i + 1
			end	
		ensure
			--make sur that every character of `s' is a printable ASCII character.
		end

end -- class DES_ASCII_ENCODER
