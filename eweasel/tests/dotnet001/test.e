class TEST 
create
	make
feature

	make is
		local
			l_d: SYSTEM_DATE_TIME
		do
			f (l_d)
			print ("Success%N")
		end

	f (o: SYSTEM_OBJECT) is
		do
		end

end
