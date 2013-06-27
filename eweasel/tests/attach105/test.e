class TEST

feature

	f (a: detachable A [B [TEST]]): detachable TEST
		do
		ensure
			attached a.generating_type -- VUTA(2)
			attached x.generating_type -- VUTA(2)
			attached Result.generating_type -- VUTA(2)
		end

	g (a: detachable TEST): detachable TEST
		do
			check attached a then end
			check attached x then end
			check attached Result then end
		ensure
			attached a.generating_type -- VUTA(2)
			attached x.generating_type -- VUTA(2)
			attached Result.generating_type -- VUTA(2)
		end

	h: detachable TEST
		do
			x := Current
			Result := Current
		ensure
			attached x.generating_type -- VUTA(2)
			attached Result.generating_type -- VUTA(2)
		end

feature -- Data

	x: detachable TEST

end
