class
	B [G -> X create default_create, do_nothing end]

inherit
	A [G]
		redefine
			f
		end

feature {NONE} -- Helpers

	f: !X
		do
		end

end