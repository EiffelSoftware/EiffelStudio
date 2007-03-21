class B

inherit
	ANY
		redefine
			is_equal
		end
feature

	is_equal (other: like Current): BOOLEAN is
		do
			io.put_string ("B.is_equal")
			io.put_new_line
		end

end
