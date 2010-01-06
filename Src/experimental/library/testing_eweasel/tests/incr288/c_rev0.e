class C [G]
inherit
	B [G, STRING]
		rename
			f as g
		end

	B [G, STRING]
		select
			f
		end

end
