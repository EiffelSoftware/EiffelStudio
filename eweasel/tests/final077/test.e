class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_string: STRING
			l_context: STRING
		do
			l_string := "1"
			l_context := "22"

			print (l_string + "%N")
			l_string := l_context.string.plus (create {STRING}.make_from_string (l_string))
			print (l_string + "%N")
		end

end
