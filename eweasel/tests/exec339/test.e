class TEST

create
	make

feature
	
	make
		local
			t1, t2: TEST1
		do
			create t1.make
			t2 := t1.twin
			if t1 /~ t2 then
				io.put_string ("Not OK for `twin'%N")
			end
			t2 := t1.standard_twin
			if t1 /~ t2 then
				io.put_string ("Not OK for `standard_twin'%N")
			end
		end

end
