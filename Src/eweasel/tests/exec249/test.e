class TEST
inherit
	TEST1
create
	make

feature

	can_complete (a_key: STRING; b1, b2, b3: BOOLEAN): BOOLEAN is
			--
		do
			print (a_key)
			print ("%N")
			print (b1)
			print ("%N")
			print (b2)
			print ("%N")
			print (b3)
			print ("%N")
			Result := True
		end

end
