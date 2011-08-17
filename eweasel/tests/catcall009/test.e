class TEST

create
	make

feature
	 make
		local
			t: TUPLE [x: ANY]
			y: STRING
			x: ANY
	 	do
	 		create y.make_empty
	 		create x
	 		t := [y]
			t.x := x

			t := [x]
			t.x := x
	 	end

end
