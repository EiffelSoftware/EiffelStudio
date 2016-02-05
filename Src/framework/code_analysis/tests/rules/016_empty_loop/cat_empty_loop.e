class
	CAT_EMPTY_LOOP

feature {None} --Test

	emtpy_loop
		-- Violates the empty loop code analysis rule.
		local
			l_bool: BOOLEAN
			l_list: LINKED_LIST[INTEGER]
		do
			across l_list as p loop
				-- Test 1
			end

			from
				l_list.start
			until
				l_list.after
			loop
				-- Test 2
			end
		end
end
