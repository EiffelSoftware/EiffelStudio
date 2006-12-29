class
	TEST

inherit
	IVERSION_2
		rename
			apply_2 as iversion_apply,
			apply as iversion_2_apply
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		do
			print ("Success%N")
		end

feature {NONE} -- Implementation

	iversion_apply: INTEGER is
		do
		end

	iversion_2_apply is
		do
		end

end
