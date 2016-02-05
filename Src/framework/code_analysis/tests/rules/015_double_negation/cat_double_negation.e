class
	CAT_DOUBLE_NEGATION

feature {NONE} -- Test

	double_negation: INTEGER
		-- Violates the double negation code analysis rule.
		local
			l_boolean_1, l_boolean_2: BOOLEAN
			l_dummy_val: INTEGER
		do
			if not not l_boolean_1 then
				l_dummy_val := 1
			end

			if not (not l_boolean_1) then
				l_dummy_val := 2
			end

			if (not not not l_boolean_1) and not (not l_boolean_2) then
				l_dummy_val := 3
			end

			Result := l_dummy_val
		end

end
