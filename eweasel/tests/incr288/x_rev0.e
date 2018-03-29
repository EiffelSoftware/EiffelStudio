expanded class X
inherit
	B[ANY, STRING]
	C[ANY]
		rename
			f as h
		select
			h
		end
end
