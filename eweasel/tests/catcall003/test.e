class TEST 
feature

	make is
		local
			l: LIST [ANY]
			l_act: ACTION_SEQUENCE [TUPLE]
			l_list: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			a, b: ANY
			l_bool: BOOLEAN
			l_safe_array: ARRAY [ANY]
			l_unsafe_array: ARRAY [variant ANY]
			l_array: ARRAY [like Current]
			l_array2: ARRAY [variant TEST]
			l_simple: TEST_SIMPLE [like Current, STRING]
		do
			l_bool := a.is_equal (b)	-- This is a potential catcall
			l_bool := t.is_equal (t)	-- This is safe (no descendant)

			l_array.subcopy (l_array, 1, 2, 4)	-- This is a potential catcall
			l_array2.subcopy (l_array, 1, 2, 4)	-- This is a potential catcall

			l_safe_array.put ("STRING", 1)		-- This is safe
			l_unsafe_array.put ("STRING", 1)	-- This is not safe (variant generic)

			l_simple.f ("ADSsdA")		-- This is safe because `l_simple' has no descendant type

			l_list.start				-- This is safe, no covariant argument
			l_list.fill (l_list)		-- This is safe, no covariant redefinition of `fill'
			l_act.fill (l_act)			-- This is safe, no covariant redefinition of `fill'

			l.do_all (agent f)			-- This is a conformance issue with new rules
		end

	f (a: ANY) is
		do
		end

	t: TEST1 [STRING, STRING]

	t2: TEST_MORE_CONSTRAINT [INTEGER, ARRAY [INTEGER], HASH_TABLE [ARRAY [INTEGER], INTEGER]]

	t3: TEST1_BIS [STRING, ARRAY [ARRAY [STRING]], ARRAY [STRING]]

	t4: TEST_ARRAY [STRING, ARRAY [STRING]]	

end
