indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make, make_with_key

feature -- Encryption

	encrypt (s: STRING): STRING is
			-- Padding done if length not multiple of 8.
		do
			Result := Precursor {DES_ENCODER} (s)
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
					s.put (code.to_character, i)
				when 58..64 then
					s.put ((code + 7).to_character, i)
				when 91..96 then
					s.put ((code + 7).to_character, i)
				else
					code := code \\ 26 + 64
					s.put (code.to_character, i)
				end
				i := i + 1
			end	
		ensure
			--make sur that every character of `s' is a printable ASCII character.
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DES_ASCII_ENCODER


