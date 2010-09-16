class
	TEST3 [G]

feature

	feature_with_old (g: G) is
		do
		ensure
			same_g: old g = g
			valid_type: g /= Void implies equal (old generating_type_of (g).out, expected_type)
		end

	expected_type: STRING is
		local
			l_int: INTERNAL
			t: TEST3 [G]
		do
			create l_int
			create t
			Result := l_int.type_name_of_type (l_int.generic_dynamic_type (t, 1))
		end

feature {NONE} -- Helper

	generating_type_of (g: G): STRING
		require
			g_attached: g /= Void
		do
			Result := g.generating_type
		ensure
			result_attached: Result /= Void
		end

end
