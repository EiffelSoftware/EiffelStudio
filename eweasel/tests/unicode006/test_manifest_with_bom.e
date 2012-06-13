﻿class
	TEST

create
	make

feature -- Make

	make
		do
		end

feature -- Run time

	test_char
		local
			l_char_8: CHARACTER_8
			l_char_32: CHARACTER_32
		do
				-- iso-8859-1 no compatible unicode
			l_char_8 := {CHARACTER_8}'测'	-- Error
			l_char_8 := {CHARACTER_32}'测'	-- Error
			l_char_8 := '测'	-- Error
				
				-- iso-8859-1
			l_char_8 := {CHARACTER_8}'a'
			l_char_8 := {CHARACTER_32}'a'	-- Error
			l_char_8 := 'a'
				
				-- iso-8859-1 compatible unicode
			l_char_8 := {CHARACTER_8}'é'
			l_char_8 := {CHARACTER_32}'é'	-- Error
			l_char_8 := 'é'
			
				-- iso-8859-1 no compatible unicode
			l_char_32 := {CHARACTER_8}'测'	-- Error
			l_char_32 := {CHARACTER_32}'测'
			l_char_32 := '测'
			
				-- iso-8859-1
			l_char_32 := {CHARACTER_8}'a'
			l_char_32 := {CHARACTER_32}'a'
			l_char_32 := 'a'
			
				-- iso-8859-1 compatible unicode
			l_char_32 := {CHARACTER_8}'é'
			l_char_32 := {CHARACTER_32}'é'
			l_char_32 := 'é'
		end

	test_string_32
		local
			l_str: STRING_32
		do
			l_str := {STRING_32} "测试"
			l_str := {STRING_32} "%/27979/%/35797/"
			l_str :=
				{STRING_32}
				"[
					测试
				]"
				
			l_str := (once {STRING_32} "测试")
			
			l_str := "测试"	-- Error
			l_str := "%/27979/%/35797/"	-- Error
			l_str :=	-- Error
				"[
					测试
				]"
				
			l_str := (once "测试") 	-- Error
		end

	test_string_8
		local
			l_str: STRING_8
		do
			l_str := {STRING_32} "测试"
			l_str := {STRING_32} "%/27979/%/35797/"
			l_str :=
				{STRING_32}
				"[
					测试
				]"
				
			l_str := (once {STRING_32} "测试")
			
			l_str := "测试" 	-- Error
			l_str := "%/27979/%/35797/" 	-- Error
			l_str := 	-- Error
				"[
					测试
				]"

			l_str := (once "测试") 	-- Error
		end

end
