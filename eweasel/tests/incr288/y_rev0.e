class Y
inherit
	B[ANY, STRING]
	C[ANY]
		rename
			f as h
		select
			h
		end
--	SYSTEM_OBJECT
end
