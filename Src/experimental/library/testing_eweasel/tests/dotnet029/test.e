class TEST

inherit
	A
	B
	
create
	make
	
feature {NONE} -- Creation
	
	make is
			-- Run test.
		local
			x: A
			y: B
		do
			x := Current
			x.a := x.a
			y := Current
			y.b := y.b
		end

feature {NONE} -- Implementation

	get_a: ANY is
			-- Feature with name and signature that matches
			-- those of the inherited getter method for `a'
		do
		end

	set_a (v: ANY) is
			-- Feature with name and signature that matches
			-- those of the inherited setter method for `a'
		do
		end

	get_b (v: ANY): ANY is
			-- Feature with name that matches the inherited
			-- getter method for `b' but differs in signature
		do
		end

	set_b (v1, v2: ANY) is
			-- Feature with name that matches the inherited
			-- getter method for `b' but differs in signature
		do
		end

end