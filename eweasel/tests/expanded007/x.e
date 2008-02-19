expanded class X
inherit
	B[ANY, STRING]
	C[STRING]
		rename
			f as h
		select
			h
		end
end
