class A

inherit

	$PARENT_A

feature

	a: A assign set_a

	b: A assign set_b is
		do
		end

	set_a (v: like a) is
		do
			a := v
		end

	set_b (v: like b) is
		do
		end

end