class
	CAT_VOID_CHECK_USING_IS_EQUAL

feature {NONE} -- Testing

	void_check (a_list: LINKED_LIST[BOOLEAN])
		-- Violates the void check using is equal rule.
		local
			l_list: LINKED_LIST [INTEGER]
			l_bool: BOOLEAN
		do
			if a_list.is_equal(Void) then
				-- Test 1
			end

			if not True and then False or else not l_list.is_equal (Void) then
				-- Test 2
			end

			l_bool := l_list.is_equal(Void) -- Test 3
		end

end
