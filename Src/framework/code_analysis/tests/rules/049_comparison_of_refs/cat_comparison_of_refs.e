class
	CAT_COMPARISON_OF_REFS

feature {NONE} -- Test

	comparison (a_list: LINKED_LIST[BOOLEAN])
		-- Violates the comparison of object references rule.
		local
			l_bool: BOOLEAN
			l_list: LINKED_LIST [BOOLEAN]
			l_int: INTEGER
			l_ref_int: INTEGER_REF
		do

			-- Cases that should not violate the rule.
			l_bool := 4 = l_int
			l_bool := 5 = l_ref_int
			l_bool := l_ref_int = l_bool

			-- Cases that should violate the rule.
			if l_list = a_list then
				l_bool := l_ref_int = l_ref_int
			else
				l_bool := Void = l_ref_int
				l_bool := l_ref_int = a_list
			end
		end

end
