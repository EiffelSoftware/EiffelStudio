class
	TEST

create
	make

feature -- Initialization

	test: TYPED_POINTER [ like Current ]

	make is
			-- Creation procedure.
		do
			pass_to_c($Current)
			pass_from_c($test)
			if test.to_pointer /= default_pointer then
				print("Fail%N")
			else
				print("Pass%N")
			end
		end

	pass_to_c(p: POINTER) is
			-- Pass a reference value to C
		external "C" end

	pass_from_c(p: POINTER) is
			-- Retrieve a reference value from C
		external "C" end


end
