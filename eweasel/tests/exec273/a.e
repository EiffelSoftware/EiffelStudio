expanded class A

inherit

	ANY
		redefine
			copy
		end

feature -- Cloning

	copy (other: like Current) is
		do
			io.put_string ("cloned, ")
		end

end