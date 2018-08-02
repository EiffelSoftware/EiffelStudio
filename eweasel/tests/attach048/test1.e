class
	TEST1 [G -> detachable COMPARABLE, H -> detachable NUMERIC]

create
	default_create,
	from_comparable

convert
	to_test: {TEST},
	from_comparable ({COMPARABLE})

feature

	test1 (a_item: G)
		local
			b: BOOLEAN
		do
			b := a_item < item (2) -- VUTA(2): `a_item` should be attached to make a call. 
		end

	test2 (a_item: G)
		local
			b: BOOLEAN
		do
			if a_item /= Void then
				b := a_item < item (2) -- VWOE: argument `item (2)` should be attached.
			end
		end

	test3 (a_item: G)
		local
			b: BOOLEAN
		do
			b := item (2) < a_item -- VUTA(2): `item (2)` should be attached to make a call.
		end

	test4 (a_item: G)
		local
			b: BOOLEAN
		do
			if a_item /= Void then
				b := item (2) < a_item -- VUTA(2): `item (2)` should be attached to make a call.
			end
		end
		
	test5 (a_item: G)
		local
			b: BOOLEAN
		do
			b := a_item.is_less (item (2)) -- VUTA(2): `a_item` should be attached to make a call. 
		end

	test6 (a_item: G)
		local
			b: BOOLEAN
		do
			if a_item /= Void then
				b := a_item.is_less (item (2)) -- VUAR(2): argument `item (2)` should be attached.
			end
		end

	test7 (a_item: G)
		local
			b: BOOLEAN
		do
			b := item (2).is_less (a_item) -- VUTA(2): `item (2)` should be attached to make a call.
		end

	test8 (a_item: G)
		local
			b: BOOLEAN
		do
			if a_item /= Void then
				b := item (2).is_less (a_item) -- VUTA(2): `item (2)` should be attached to make a call.
			end
		end

	test1p (a_item: H)
		local
			a: detachable ANY
		do
			a := + a_item -- VUTA(2): `a_item` should be attached to make a call.
		end

	test2p (a_item: H)
		local
			a: detachable ANY
		do
			if a_item /= Void then
				a := + a_item
			end
		end

	test3p (a_item: H)
		local
			a: detachable ANY
		do
			a := a_item.identity -- VUTA(2): `a_item` should be attached to make a call.
		end

	test4p (a_item: H)
		local
			a: detachable ANY
		do
			if a_item /= Void then
				a := a_item.identity
			end
		end

	test1c (b: TEST)
		local
			a: detachable TEST1 [G, H]
			c: TEST
		do
			c := a + b -- VWOE: `a` neither conforms nor converts to `{TEST}`. (For conversion `{attached TEST1}` is needed.)
		end

	test2c (b: TEST)
		local
			a: detachable TEST1 [G, H]
			c: TEST
		do
			if a /= Void then
				c := a + b
			end
		end

	test3c (b: TEST)
		local
			a: detachable TEST1 [G, H]
			c: TEST
		do
			c := b + a -- VWOE: `a` neither conforms nor converts to `{TEST}`. (For conversion `{attached TEST1}` is needed.)
		end

	test4c (b: TEST)
		local
			a: detachable TEST1 [G, H]
			c: TEST
		do
			if a /= Void then
				c := b + a
			end
		end

	test1f (a: detachable COMPARABLE)
		local
			b: BOOLEAN
		do
			b := a < Current -- VWOE: `a` neither conforms nor converts to `{TEST1}`. (For conversion `{attached COMPARABLE}` is needed.)
		end

	test2f (a: detachable COMPARABLE)
		local
			b: BOOLEAN
		do
			if a /= Void then
				b := a < Current
			end
		end

	test3f (a: detachable COMPARABLE)
		local
			b: BOOLEAN
		do
			b := Current < a -- VWOE: `a` neither conforms nor converts to `{TEST1}`. (For conversion `{attached COMPARABLE}` is needed.)
		end

	test4f (a: detachable COMPARABLE)
		local
			b: BOOLEAN
		do
			if a /= Void then
				b := Current < a
			end
		end

	test1g (a: COMPARABLE)
		local
			b: BOOLEAN
		do
			b := a < Current
		end

	test2g (a: COMPARABLE)
		local
			b: BOOLEAN
		do
			if a /= Void then
				b := a < Current
			end
		end

	test3g (a: COMPARABLE)
		local
			b: BOOLEAN
		do
			b := Current < a
		end

	test4g (a: COMPARABLE)
		local
			b: BOOLEAN
		do
			if a /= Void then
				b := Current < a
			end
		end

	item (i: INTEGER): G
		local
			l_g: detachable G
		do
			check l_g /= Void end
			Result := l_g
		end

feature -- Basic operations

	plus alias "+" (other: detachable TEST1 [G, H]): TEST1 [G, H]
		do
			Result := Current
		end

	less alias "<" (other: detachable TEST1 [G, H]): BOOLEAN
		do
		end

feature -- Conversion

	from_comparable (c: COMPARABLE)
		do
		end

	to_test: TEST
		do
			create Result.make (<<>>)
		end

end
