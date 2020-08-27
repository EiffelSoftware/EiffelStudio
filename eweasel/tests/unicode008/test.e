class
	TEST

create
	make

feature -- Make

	make
		do
				-- Comments.
			-- report ({CHARACTER_32} '+', 0x2B, 01)	-- 2B:	00..7F
			-- report ({CHARACTER_32} '¢', 0xA2, 02)	-- C2 A2:	C2..DF	80..BF
			-- report ({CHARACTER_32} '࠰', 0x0830, 03)	-- E0 A0 B0:	E0	A0..BF	80..BF
			-- report ({CHARACTER_32} '–', 0x2013, 04)	-- E2 80 93:	E1..EC	80..BF	80..BF
			-- report ({CHARACTER_32} '脣', 0x8123, 05)	-- E8 84 A3:	E1..EC	80..BF	80..BF
			-- report ({CHARACTER_32} 'ힰ', 0xD7B0, 06)	-- ED 9E B0:	ED	80..9F	80..BF
			-- report ({CHARACTER_32} '﮿', 0xFBBF, 07)	-- EF AE BF:	EE..EF	80..BF	80..BF
			-- report ({CHARACTER_32} '🀙', 0x1F019, 08)	-- F0 9F 80 99:	F0	90..BF	80..BF	80..BF
			-- report ({CHARACTER_32} '󠀡', 0xE0021, 09)	-- F3 A0 80 A1:	F1..F3	80..BF	80..BF	80..BF
			-- report ({CHARACTER_32} '􀀀', 0x100000, 10)	-- F4 80 80 80:	F4	80..8F	80..BF	80..BF

			io.put_string ("Character tests:")
			io.put_new_line
			report ({CHARACTER_32} '+', 0x2B, 01)	-- 2B:	00..7F
			report ({CHARACTER_32} '¢', 0xA2, 02)	-- C2 A2:	C2..DF	80..BF
			report ({CHARACTER_32} '࠰', 0x0830, 03)	-- E0 A0 B0:	E0	A0..BF	80..BF
			report ({CHARACTER_32} '–', 0x2013, 04)	-- E2 80 93:	E1..EC	80..BF	80..BF
			report ({CHARACTER_32} '脣', 0x8123, 05)	-- E8 84 A3:	E1..EC	80..BF	80..BF
			report ({CHARACTER_32} 'ힰ', 0xD7B0, 06)	-- ED 9E B0:	ED	80..9F	80..BF
			report ({CHARACTER_32} '﮿', 0xFBBF, 07)	-- EF AE BF:	EE..EF	80..BF	80..BF
			report ({CHARACTER_32} '🀙', 0x1F019, 08)	-- F0 9F 80 99:	F0	90..BF	80..BF	80..BF
			report ({CHARACTER_32} '󠀡', 0xE0021, 09)	-- F3 A0 80 A1:	F1..F3	80..BF	80..BF	80..BF
			report ({CHARACTER_32} '􀀀', 0x100000, 10)	-- F4 80 80 80:	F4	80..8F	80..BF	80..BF

			io.put_string ("String tests:")
			io.put_new_line
			report (({STRING_32} "+") [1], 0x2B, 01)	-- 2B:	00..7F
			report (({STRING_32} "¢") [1], 0xA2, 02)	-- C2 A2:	C2..DF	80..BF
			report (({STRING_32} "࠰") [1], 0x0830, 03)	-- E0 A0 B0:	E0	A0..BF	80..BF
			report (({STRING_32} "–") [1], 0x2013, 04)	-- E2 80 93:	E1..EC	80..BF	80..BF
			report (({STRING_32} "脣") [1], 0x8123, 05)	-- E8 84 A3:	E1..EC	80..BF	80..BF
			report (({STRING_32} "ힰ") [1], 0xD7B0, 06)	-- ED 9E B0:	ED	80..9F	80..BF
			report (({STRING_32} "﮿") [1], 0xFBBF, 07)	-- EF AE BF:	EE..EF	80..BF	80..BF
			report (({STRING_32} "🀙") [1], 0x1F019, 08)	-- F0 9F 80 99:	F0	90..BF	80..BF	80..BF
			report (({STRING_32} "󠀡") [1], 0xE0021, 09)	-- F3 A0 80 A1:	F1..F3	80..BF	80..BF	80..BF
			report (({STRING_32} "􀀀") [1], 0x100000, 10)	-- F4 80 80 80:	F4	80..8F	80..BF	80..BF

			io.put_string ("Operator tests:")
			io.put_new_line
			report ((+ Current).to_character_32, 0x2B, 01)	-- 2B:	00..7F
			report ((–¢ Current).to_character_32, 0xA2, 02)	-- C2 A2:	C2..DF	80..BF
			report ((–࠰ Current).to_character_32, 0x0830, 03)	-- E0 A0 B0:	E0	A0..BF	80..BF
			report ((–– Current).to_character_32, 0x2013, 04)	-- E2 80 93:	E1..EC	80..BF	80..BF
			report ((–⭌ Current).to_character_32, 0x2B4C, 05)	-- E8 84 A3:	E1..EC	80..BF	80..BF
			-- report ((–ힰ Current).to_character_32, 0xD7B0, 06)	-- ED 9E B0:	ED	80..9F	80..BF
			report ((–﮿ Current).to_character_32, 0xFBBF, 07)	-- EF AE BF:	EE..EF	80..BF	80..BF
			report ((–𝛁 Current).to_character_32, 0x1D6C1, 08)	-- F0 9D 9B 81:	F0	90..BF	80..BF	80..BF
			-- report ((–󠀡 Current).to_character_32, 0xE0021, 09)	-- F3 A0 80 A1:	F1..F3	80..BF	80..BF	80..BF
			-- report ((–􀀀 Current).to_character_32, 0x100000, 10)	-- F4 80 80 80:	F4	80..8F	80..BF	80..BF

		end

feature {NONE} -- Output

	report (value: CHARACTER_32; code: NATURAL_32; test: NATURAL_8)
		do
			io.put_string ("	Test #")
			io.put_natural_8 (test // 10)
			io.put_natural_8 (test \\ 10)
			if value.natural_32_code = code then
				io.put_string (": OK")
			else
				io.put_string (": Failed. Expected ")
				io.put_natural_32 (code)
				io.put_string (" but got ")
				io.put_natural_32 (value.natural_32_code)
			end
			io.put_new_line
		end

feature {TEST} -- Tests: operators

	operator_01 alias "+": NATURAL_32	-- 2B:	00..7F
		do
			Result := 0x2B
		end

	operator_02 alias "–¢": NATURAL_32	-- C2 A2:	C2..DF	80..BF
		do
			Result := 0xA2
		end

	operator_03 alias "–࠰": NATURAL_32	-- E0 A0 B0:	E0	A0..BF	80..BF
		do
			Result := 0x830
		end

	operator_04 alias "––": NATURAL_32	-- E2 80 93:	E1..EC	80..BF	80..BF
		do
			Result := 0x2013
		end

	operator_05 alias "–⭌": NATURAL_32	-- E2 AD 8C:	E1..EC	80..BF	80..BF
		do
			Result := 0x2B4C
		end

--	operator_06 alias "–ힰ": NATURAL_32	-- ED 9E B0:	ED	80..9F	80..BF
--		do
--			Result := 0xD7B0
--		end

	operator_07 alias "–﮿": NATURAL_32	-- EF AE BF:	EE..EF	80..BF	80..BF
		do
			Result := 0xFBBF
		end

	operator_08 alias "–𝛁": NATURAL_32	-- F0 9D 9B 81:	F0	90..BF	80..BF	80..BF
		do
			Result := 0x1D6C1
		end

--	operator_09 alias "–󠀡": NATURAL_32	-- F3 A0 80 A1:	F1..F3	80..BF	80..BF	80..BF
--		do
--			Result := 0xE0021
--		end

--	operator_10 alias "–􀀀": NATURAL_32	-- F4 80 80 80:	F4	80..8F	80..BF	80..BF
--		do
--			Result := 0x100000
--		end

end
