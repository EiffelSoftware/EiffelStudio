class
	B

inherit
	A
		rename g as g1
		redefine g1
		select g1
		end

	A
		rename f as f1, -- This should raise a VMCS warning if f is not replicated.
		 		assert as assert1
		select f1, assert1
		end

create
	make

feature
	make
		do
			print ("Starting `f'. %N")
			f
			print ("Starting `f1'. %N")
			f1
			print ("Ending   `f1'. %N")
		end

feature

	g1: STRING once Result := "g1%N" end

invariant
	inv: assert ("invaB: ")
	inv2: print_g ("invaB: ", g)

end
