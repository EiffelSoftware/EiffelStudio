class B

inherit

	A
		redefine
			is_equal
		end

feature

	is_less (other: like Current): BOOLEAN
		do
			print ("is_less%N")
		end

	is_equal (other: like Current): BOOLEAN
		do
			print ("is_equal%N")
		end

end