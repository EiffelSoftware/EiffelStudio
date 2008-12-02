class
	TEST

create
	make

feature

	make
		local
			i: INTEGER
		do
			i := 4
			if i.divisible (2) then --| Seg violation |--
				print ("i=" + i.out + " is divisible by 2%N")
			end
		end

end
