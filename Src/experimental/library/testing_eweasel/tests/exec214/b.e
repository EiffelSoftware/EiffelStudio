class B

inherit

	$PARENT_B

	A
		redefine
			a, b
		end

feature

	a: A assign set_a

	b: A assign set_b

	c: A assign set_c

	d: like Current assign set_d

	e: A

	set_c (v: like c) is
		do
			c := v
		end
	
	set_d (v: like d) is
		do
			d := v
		end

	set_e (v: like e) is
		do
			e := v
		end

end