class B [G]

inherit
	A [G]
		redefine
			h
		end

feature

	h (a: ?ANY): !TEST
		external "C inline"
			alias "return eif_access($a);"
		end

end