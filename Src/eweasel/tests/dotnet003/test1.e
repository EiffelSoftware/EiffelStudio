class
	TEST1

inherit
	ANY
		redefine
			copy
		end

feature

	copy (other: like Current) is
		do
			Precursor {ANY} (other)
		end
		
end
