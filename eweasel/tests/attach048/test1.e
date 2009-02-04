class
	TEST1 [G -> COMPARABLE]

feature

	test1 (a_item: G)
		local
			b: BOOLEAN
		do
			b := a_item < item (2)
		end

	test2 (a_item: G)
		local
			b: BOOLEAN
		do
			if a_item /= Void then
				b := a_item < item (2)
			end
		end

	test3 (a_item: G)
		local
			b: BOOLEAN
		do
			b := item (2) < a_item
		end

	test4 (a_item: G)
		local
			b: BOOLEAN
		do
			if a_item /= Void then
				b := item (2) < a_item
			end
		end
		
	test5 (a_item: G)
		local
			b: BOOLEAN
		do
			b := a_item.is_less (item (2))
		end

	test6 (a_item: G)
		local
			b: BOOLEAN
		do
			if a_item /= Void then
				b := a_item.is_less (item (2))
			end
		end

	test7 (a_item: G)
		local
			b: BOOLEAN
		do
			b := item (2).is_less (a_item)
		end

	test8 (a_item: G)
		local
			b: BOOLEAN
		do
			if a_item /= Void then
				b := item (2).is_less (a_item)
			end
		end

	item (i: INTEGER): G
		local
			l_g: ?G
		do
			check l_g /= Void end
			Result := l_g
		end

end
