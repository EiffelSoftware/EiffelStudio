class TEST

create
	make

feature
	 make
		local
			t: TUPLE [x: variant ANY]
			t2: TUPLE [x: ANY]
			y: STRING
			x: ANY
	 	do
	 		create y.make_empty
	 		create x
	 		t := [y]
			t.x := x

			t2 := [x]
			t2.x := x
	 	end

end
