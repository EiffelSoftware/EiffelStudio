class TEST1 [G]
create
	make
feature

	a: G
	b: STRING
	c: STRING

	make (a_a: like a; a_b: like b; a_c: like c) is
		do
			a := a_a
			b := a_b
			c := a_c
		end
end
