class
	TEST

create
	make

feature -- Make

	make
		do
		end

feature -- Characters

	char1: CHARACTER_32 = '测'
	char2: CHARACTER_8 = '测'	-- Error
	
	char3: CHARACTER_32 = 'é'
	char4: CHARACTER_8 = 'é'
	
	char5: CHARACTER_32 = 's'
	char6: CHARACTER_8 = 's'
	
	char7: CHARACTER_32 = '%/35797/'
	char8: CHARACTER_8 = '%/35797/'	-- Error

feature -- Strings

	str32_1: STRING_32 = "测试"
	str32_2: STRING_32 = "%/27979/%/35797/"
	str32_3: STRING_32 =
		"[
			测试
		]"
	str32_4: STRING_32 = "é"

	str8_1: STRING = "测试"	-- Error
	str8_2: STRING = "%/27979/%/35797/"	-- Error
	str8_3: STRING =	-- Error
		"[
			测试
		]"
	str8_4: STRING = "é"

end
