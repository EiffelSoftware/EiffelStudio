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
			test_manifest_string_32_syntax
			test_system_string
		end

feature -- Run time

	test_char
		do
			print ("Manifest CHARACTER_32: " + (char1.code = 27979).out + "%N")
			print ("CHARACTER_32 vs ASCII: " + (({CHARACTER_32}'a').code = 97).out + "%N")
			print ("CHARACTER_32 vs Unicode: " + (({CHARACTER_32}'测').code = 27979).out + "%N")
			print ("CHARACTER_8 vs ASCII: " + (({CHARACTER_8}'a').code = 97).out + "%N")
			print ("CHARACTER_32 constant type: " + (char1.generating_type).out + "%N")
			print ("CHARACTER_8 constant type: " + (char_8.generating_type).out + "%N")
			print ("Manifest Unicode char type: " + ('测').generating_type.out + "%N")
			print ("Manifest ASCII char type: " + ('a').generating_type.out + "%N")
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

	test_manifest_string_32_syntax
		local
			l_pass: BOOLEAN
			l_str: STRING_32
		do
			l_str := str32_2
			l_pass :=
					l_str.item (1).code = 27979 and then
					l_str.item (2).code = 35797 and then
					l_str.count = 2
			print ("STRING_32 constants test syntax dec: " + l_pass.out + "%N")
			print ("STRING_32 constants test syntax dec bis: " + l_str.same_string (str32_2_dec_bis).out + "%N")
			print ("STRING_32 constants test syntax 0x: " + l_str.same_string (str32_2_0x).out + "%N")
			print ("STRING_32 constants test syntax 0x bis: " + l_str.same_string (str32_2_0x_bis).out + "%N")

			print ("STRING_32 constants test syntax 0c: " + l_str.same_string (str32_2_0c).out + "%N")
			print ("STRING_32 constants test syntax 0c bis: " + l_str.same_string (str32_2_0c_bis).out + "%N")

			print ("STRING_32 constants test syntax 0b: " + l_str.same_string (str32_2_0b).out + "%N")
			print ("STRING_32 constants test syntax 0b bis: " + l_str.same_string (str32_2_0b_bis).out + "%N")
		end

	test_system_string
		local
			l_s: SYSTEM_STRING
		do
			if {PLATFORM}.is_dotnet then
				l_s := str32_1
				l_s := {STRING_32}"测试"
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

	str32_1: STRING_32 = "测试"
	str32_2: STRING_32 = "%/27979/%/35797/"
	str32_2_dec_bis: STRING_32 = "%/27_979/%/35_797/"
	str32_2_0x: STRING_32 = "%/0x6D4B/%/0x8BD5/"
	str32_2_0x_bis: STRING_32 = "%/0x6_D4B/%/0x8_BD5/"
	str32_2_0c: STRING_32 = "%/0c66513/%/0c105725/"
	str32_2_0c_bis: STRING_32 = "%/0c66_513/%/0c10_5725/"
	str32_2_0b: STRING_32 = "%/0b0110110101001011/%/0b1000101111010101/"
	str32_2_0b_bis: STRING_32 = "%/0b0110_1101_0100_1011/%/0b1000_1011_1101_0101/"
	str32_3: STRING_32 =
		"[
			测试
		]"

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
