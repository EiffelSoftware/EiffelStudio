note
	test: "测试"
	test: "Test 测试 Test"

class
	TEST

create
	make

feature -- Make

	make
		do
			test_char
			test_string_32
			test_string_8
			test_system_string
		end

feature -- Run time

	test_char
		do
			print ("Manifest CHARACTER_32: " + (char1.code = 27979).out + "%N")
			print ("CHARACTER_8 vs Unicode: " + (({CHARACTER_8}'测').code = 75).out + "%N")
			print ("CHARACTER_32 vs ASCII: " + (({CHARACTER_32}'a').code = 97).out + "%N")
			print ("CHARACTER_32 vs Unicode: " + (({CHARACTER_32}'测').code = 27979).out + "%N")
			print ("CHARACTER_8 vs ASCII: " + (({CHARACTER_8}'a').code = 97).out + "%N")
			print ("CHARACTER_32 constant type: " + (char1.generating_type).out + "%N")
			print ("CHARACTER_8 constant type: " + (char_8.generating_type).out + "%N")
			print ("Manifest Unicode char type: " + ('测').generating_type.out + "%N")
			print ("Manifest ASCII char type: " + ('a').generating_type.out + "%N")
			print ("CHARACTER_8 typed Unicode character type: " + ({CHARACTER_8}'测').generating_type.out + "%N")
			print ("CHARACTER_32 ASCII character type: " + ({CHARACTER_32}'a').generating_type.out + "%N")
			print ("CHARACTER_32 typed Unicode character type: " + ({CHARACTER_32}'测').generating_type.out + "%N")
			print ("CHARACTER_8 typed ASCII character type: " + ({CHARACTER_8}'a').generating_type.out + "%N")
		end

	test_string_32
		local
			l_pass: BOOLEAN
			l_str: STRING_32
		do
			l_pass :=
					str32_1.item (1).code = 27979 and then
					str32_1.item (2).code = 35797 and then
					str32_1.count = 2
			print ("STRING_32 constants test 1: " + l_pass.out + "%N")

			l_pass :=
					str32_2.item (1).code = 27979 and then
					str32_2.item (2).code = 35797 and then
					str32_2.count = 2
			print ("STRING_32 constants test 2: " + l_pass.out + "%N")

			l_pass :=
					str32_3.item (1).code = 27979 and then
					str32_3.item (2).code = 35797 and then
					str32_3.count = 2
			print ("STRING_32 constants test 3: " + l_pass.out + "%N")

			l_str := once_str_in_feature
			l_pass :=
					l_str.item (1).code = 27979 and then
					l_str.item (2).code = 35797 and then
					l_str.count = 2
			print ("STRING_32 constants test 4: " + l_pass.out + "%N")

			l_str := str_in_feature
			l_pass :=
					l_str.item (1).code = 27979 and then
					l_str.item (2).code = 35797 and then
					l_str.count = 2
			print ("STRING_32 constants test 5: " + l_pass.out + "%N")
		end

	test_string_8
		local
			l_pass: BOOLEAN
		do
				-- STRING_8
			l_pass :=
					str8_1.item (1).code = 0xE6 and then
					str8_1.item (2).code = 0xB5 and then
					str8_1.item (3).code = 0x8B and then
					str8_1.item (4).code = 0xE8 and then
					str8_1.item (5).code = 0xAF and then
					str8_1.item (6).code = 0x95 and then
					str8_1.count = 6
			print ("STRING_8 constants test 1: " + l_pass.out + "%N")

			l_pass :=
					str8_2.item (1).code = 0xE6 and then
					str8_2.item (2).code = 0xB5 and then
					str8_2.item (3).code = 0x8B and then
					str8_2.item (4).code = 0xE8 and then
					str8_2.item (5).code = 0xAF and then
					str8_2.item (6).code = 0x95 and then
					str8_2.count = 6
			print ("STRING_8 constants test 2: " + l_pass.out + "%N")

			l_pass :=
					str8_3.item (1).code = 0xE6 and then
					str8_3.item (2).code = 0xB5 and then
					str8_3.item (3).code = 0x8B and then
					str8_3.item (4).code = 0xE8 and then
					str8_3.item (5).code = 0xAF and then
					str8_3.item (6).code = 0x95 and then
					str8_3.count = 6
			print ("STRING_8 constants test 3: " + l_pass.out + "%N")
		end

	test_system_string
		local
			l_s: SYSTEM_STRING
		do
			if {PLATFORM}.is_dotnet then
				l_s := str32_1
				l_s := {STRING_32}"测试"
				l_s := str8_1
				l_s := "a"
			end
		end

feature -- Comment 注释测试

	-- 注释测试
	-- Comment Test 注释测试 Comment Test

feature -- Characters

	char1: CHARACTER_32 = '测'
	char_8: CHARACTER = 's'

feature -- Strings

	str32_1: STRING_32 = {STRING_32}"测试"
	str32_2: STRING_32 = {STRING_32}"%/27979/%/35797/"
	str32_3: STRING_32 =
		{STRING_32}
		"[
			测试
		]"

	str8_1: STRING = "测试"
	str8_2: STRING = "%/27979/%/35797/"
	str8_3: STRING =
		"[
			测试
		]"

		-- Conversion
	str8_4: STRING = {STRING_32}"测试"
	str8_5: STRING = {STRING_32}"%/27979/%/35797/"
	str8_6: STRING =
		{STRING_32}
		"[
			测试
		]"

	str1: STRING =
		"[
			Test 测试 Test.
			这是一段用于测试的中文。
		]"
	str2: STRING = "Test %/27979/ %/35797/ Test code points."

	once_str_in_feature: STRING_32
		local
			l_str: STRING_32
		do
			l_str := (once {STRING_32} "测试")
			Result := l_str
		end

	str_in_feature: STRING_32
		local
			l_str: STRING_32
		do
			l_str := ({STRING_32} "测试")
			Result := l_str
		end

end
