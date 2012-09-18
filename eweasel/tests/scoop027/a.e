class A

create
	make

feature {NONE} -- Creation

	make (a_string: separate STRING)
		
		do
			create str.make_from_separate (a_string)
			print (str + "%N")
		end

	str: STRING

end
