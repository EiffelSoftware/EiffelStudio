class 
	TEST
creation
	make
feature
	make 
		local
			l_a: A [INTEGER_REF]
		do
			create l_a
			l_a.test (42)
			print("%N")
		end
end

