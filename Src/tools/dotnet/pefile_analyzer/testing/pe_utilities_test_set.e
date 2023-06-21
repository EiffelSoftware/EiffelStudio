note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	PE_UTILITIES_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_type_signature_compression
			-- New test routine
		local
			mp: MANAGED_POINTER
			tok: INTEGER
			s: STRING
			i,n: INTEGER
			n8: NATURAL_8
			u1,u2: INTEGER_32
			sz: INTEGER
		do
if False then
			tok := 0x02000012
--			create mp.make (4 * 1)
--			sz := compress_data (0x48, mp)

			create mp.make (4 * 1)
			sz := compress_type_token (tok, mp)

			from
				i := 0
				n := sz
				create s.make (n)
			until
				i >= n
			loop
				n8 := mp.read_natural_8_le (i)
				s.append (n8.to_hex_string)
				s.append_character ('-')
				i := i + 1
			end
			s.remove_tail (1) -- remove ending -

			assert ("bytes", s.is_case_insensitive_equal_general ("48"))

			u1 := uncompressed_data (mp, sz)
			assert ("uncompressed_data", u1 = 0x48)
end
if False then
			tok := 0x02001234
			create mp.make (4 * 1)
			sz := compress_type_token (tok, mp)

			from
				i := 0
				n := sz
				create s.make (n)
			until
				i >= n
			loop
				n8 := mp.read_natural_8_le (i)
				s.append (n8.to_hex_string)
				s.append_character ('-')
				i := i + 1
			end
			s.remove_tail (1) -- remove ending -

			assert ("bytes", s.is_case_insensitive_equal_general ("C0-00-48-D0"))

			u1 := uncompressed_data (mp, sz)
			assert ("uncompressed_data", u1 = 0x48D0)

			u2 := uncompressed_type_token (u1)
			assert ("token retrieved", u2 = tok)
end

if False then

			tok := 0x0100_0123
			create mp.make (4 * 1)
			sz := compress_type_token (tok, mp)

			from
				i := 0
				n := sz
				create s.make (n)
			until
				i >= n
			loop
				n8 := mp.read_natural_8_le (i)
				s.append (n8.to_hex_string)
				s.append_character ('-')
				i := i + 1
			end
			s.remove_tail (1) -- remove ending -

			assert ("bytes", s.is_case_insensitive_equal_general ("84-8D"))

			u1 := uncompressed_data (mp, sz)
			assert ("uncompressed_data", u1 = 0x48D)

			u2 := uncompressed_type_token (u1)
			assert ("token retrieved", u2 = tok)
end

if True then

			tok := 0x0200_0111
			create mp.make (4 * 1)
			sz := compress_type_token (tok, mp)

			from
				i := 0
				n := sz
				create s.make (n)
			until
				i >= n
			loop
				n8 := mp.read_natural_8_le (i)
				s.append (n8.to_hex_string)
				s.append_character ('-')
				i := i + 1
			end
			s.remove_tail (1) -- remove ending -

			assert ("bytes", s.is_case_insensitive_equal_general ("84-44"))

			u1 := uncompressed_data (mp, sz)
			assert ("uncompressed_data", u1 = 0x444)

			u2 := uncompressed_type_token (u1)
			assert ("token retrieved", u2 = tok)
end
		end

	uncompressed_data (v: MANAGED_POINTER; nb: INTEGER): INTEGER
		local
--			i1, i2, i3, i4: NATURAL_32
--			n32: NATURAL_32
		do
			Result := {PE_SIGNATURE_BLOB_ITEM}.uncompressed_data (v, 0, nb)
--			i1 := v.read_natural_8 (0)
--			if nb = 1 then
--				n32 := i1
--			else
--				i2 := v.read_natural_8 (1)
--				if nb = 2 then
--					n32 := (i1 |<< 8)
--							+ i2
--							- 0x0000_8000
--				elseif nb = 4 then
--					i3 := v.read_natural_8 (2)
--					i4 := v.read_natural_8 (3)

--					n32 := (i1 |<< 24).to_natural_32
--							+ (i2 |<< 16).to_natural_32
--							+ (i3 |<< 8).to_natural_32
--							+ (i4).to_natural_32
--							- 0xC000_0000
--				end
--			end
--			Result := n32.to_integer_32
		end

	compress_data (i: INTEGER; mp: MANAGED_POINTER): INTEGER
			-- Compress `i' using Partition II 22.2 specification
			-- and store it at currrent_position in current.
		require
			valid_i: i <= 0x1FFFFFFF
		local
			l_pos, l_incr: INTEGER
			l_val: INTEGER
		do
			l_pos := 0

			if i <= 0x7F then
					-- Simply copy first byte.
				mp.put_integer_8_le (i.to_integer_8, l_pos)
				l_incr := 1;
			elseif i <= 0x3FFF then
					-- Copy two bytes added with 0x00008000.
				l_val := i + 0x00008000
				mp.put_integer_8_le (((l_val & 0x0000FF00) |>> 8).to_integer_8, l_pos)
				mp.put_integer_8_le ((l_val & 0x000000FF).to_integer_8, l_pos + 1)
				l_incr := 2
			else
					-- Copy four bytes added with 0xC0000000
				l_val := i + 0xC0000000
				mp.put_integer_8_le (((l_val & 0xFF000000) |>> 24).to_integer_8, l_pos)
				mp.put_integer_8_le (((l_val & 0x00FF0000) |>> 16).to_integer_8, l_pos + 1)
				mp.put_integer_8_le (((l_val & 0x0000FF00) |>> 8).to_integer_8, l_pos + 2)
				mp.put_integer_8_le ((l_val & 0x000000FF).to_integer_8, l_pos + 3)
				l_incr := 4
			end
			l_pos := l_pos + l_incr
			Result := l_incr
		end

	uncompressed_type_token (v: INTEGER): INTEGER
		local
--			enc: INTEGER
--			val: NATURAL_32
--			tag: NATURAL_32
		do
			Result := {PE_SIGNATURE_BLOB_ITEM}.uncompressed_type_token (v).to_integer_32
--			enc := (v & 0x0000_0003)
--			val := (v |>> 2).to_natural_32
--			inspect
--				enc
--			when 0 then
--					-- TypeDef Token
--				tag := {PE_TABLES}.ttypedef
--			when 1 then
--					-- Typeref Token
--				tag := {PE_TABLES}.ttyperef
--			when 2 then
--					-- TypeSpec Token
--				tag := {PE_TABLES}.ttypespec
--			else
--				check known: False end
--				tag := {PE_TABLES}.ttypedef
--			end
--			Result := ((tag |<< 24) + val).to_integer_32
		end

	compress_type_token (i: INTEGER; mp: MANAGED_POINTER): INTEGER
			-- Compress token `i' using Partition II 22.2.8 specification
			-- and store it at current_position in current.
		local
			l_header: NATURAL_32
			l_val: INTEGER
			l_encoding: INTEGER
		do
			l_header := (i & 0xFF00_0000).to_natural_32 |>> 24
			l_val := i & 0x00FF_FFFF

			if l_header = {PE_TABLES}.ttyperef then
					-- TypeRef token
				l_encoding := 1
			elseif l_header = {PE_TABLES}.ttypedef then
					-- TypeDef token
				l_encoding := 0
			elseif l_header = {PE_TABLES}.ttypespec then
					-- TypeSpec token
				l_encoding := 2
			else
				check
					known_type_token_header: False
				end
			end

			l_val := (l_val |<< 2) | l_encoding

			Result := compress_data (l_val, mp)
		end

end


