class TEST

create
	make

feature -- Test

	make is
			-- Execute test.
		local
			l_doubles: ARRAY [REAL_64]
		do
			l_doubles := <<1.3, 1.3, 1.3>>
			if l_doubles.for_all (agent equal_double (?, l_doubles.item (1))) then
				print ("OK%N")
			else
				print ("Bug%N")
			end

			if l_doubles.for_all (agent equal (?, l_doubles.item (1))) then
				print ("OK%N")
			else
				print ("Bug%N")
			end
		end

	equal_double (a_first, a_second: DOUBLE): BOOLEAN is
			-- Is `a_first' equal to `a_second'?
			-- Can't use `equal' because it crashes EiffelStudio.
		do
			Result := (a_first = a_second)
		ensure
			definition: Result = (a_first = a_second)
		end

end
