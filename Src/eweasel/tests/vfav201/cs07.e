class C

inherit
	A
	B
		rename
			f$(COUNT) as x alias "[]"
		end

end