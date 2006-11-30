class TEST1
inherit
	TEST2
		redefine
			insert
		end 

feature -- Access 

	insert (rec: INTEGER) is
		do
			print ("Called once%N")
			if rec >= 0 then
				insert (rec - 1)
				Precursor (rec - 1)
			end
		end

end	
