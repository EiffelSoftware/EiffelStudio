class TEST1
inherit
	ANY
		redefine
			is_equal
		end

feature

	is_equal (v: like Current): BOOLEAN
		do
			attr := v
		end

	attr: like Current

	f
		do
			print ("Calling TEST1.f%N")
		end

end
