expanded class X
inherit
	B[ANY]
	C[ANY]
		rename
			f as g
		select
			g
		end
end
