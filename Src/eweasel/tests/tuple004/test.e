class TEST
 
create
    make
 
feature
 
    make is
		local
			t: TUPLE [a: BOOLEAN; b: INTEGER; c: STRING]
		do
			create t
			print (t.hash_code)
			print ("%N")
		end

end
