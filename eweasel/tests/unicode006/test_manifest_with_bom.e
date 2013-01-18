class
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
			
				-- Unicode point numbers
			l_char_8 := {CHARACTER_8}'%/35797/'		-- Error
			l_char_8 := {CHARACTER_32}'%/35797/'	-- Error
			l_char_8 := '%/35797/'	-- Error
			
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
			
				-- Unicode point numbers
			l_char_32 := {CHARACTER_8}'%/35797/'	-- Error
			l_char_32 := {CHARACTER_32}'%/35797/'
			l_char_32 := '%/35797/'
		end

	test_string
		local
			l_str: STRING_32
			l_str_8: STRING_8
		do
			l_str := {STRING_32} "测试"
			l_str := {STRING_32} "%/27979/%/35797/"
			l_str := {STRING_32}
				"[
					测试
				]"
				
			l_str := (once {STRING_32} "测试")
			
			l_str_8 := "测试"	-- Error
			l_str_8 := "%/27979/%/35797/"	-- Error
			l_str_8 :=	-- Error
				"[
					测试
				]"
				
			l_str_8 := (once "测试") 	-- Error
		end

end
