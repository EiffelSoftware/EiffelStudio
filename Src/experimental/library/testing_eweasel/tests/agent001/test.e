class TEST
create
	make

feature

	make is
		local
			t: TEST2
		do
			create t.make (agent f (2))
			print (t.query.last_result)
			print ("%N")
		end

	f (a: INTEGER): INTEGER is
		do
			print (a)
			print ("%N")
			Result := 1
		end

end
