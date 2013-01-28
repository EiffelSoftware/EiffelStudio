class 
	TEST
create
	make

feature
	
	make
		local
			l_str32: STRING_32
			l_str8: STRING_8
		do
			if not str32.same_string_general (str8) then
				io.put_string ("Not ok%N")
			end
			l_str32 := {STRING_32} "This is a test"
			l_str8 := {STRING_8} "This is a test"
			if not l_str32.same_string_general (l_str8) then
				io.put_string ("Not ok%N")
			end
		end

	str32: STRING_32 = "TEST"
	str8: STRING_8 = "TEST"

end

