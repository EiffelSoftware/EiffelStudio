
class TEST

create
	make

feature
	 make
	 	do
			create x.make
			create y.make (2.5)
	 	end


	t: TUPLE [a: TEST2 b: TUPLE [c: INTEGER d: TEST3 [DOUBLE]]]

	x: like t.a
	
	y: like t.b.d
end
