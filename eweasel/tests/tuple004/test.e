class TEST
 
create
    make
 
feature
 
    make is
		local
			t: TUPLE [a: BOOLEAN; b: INTEGER; c: STRING]
			s: STRING
		do 
			t := [False, 0, s]
			print (t.hash_code)
			print ("%N")
		end

end
