class REQUIRE_MERGER

feature
	
	merge2 (u, n: REQUIRE_AS) is
			-- Merge requires from `u'ser file and `n'ew template.
		local
			require_else: REQUIRE_ELSE_AS
			assert_list_merger: ASSERT_LIST_MERGER
		do
			if n /= Void then
				if u /= Void then
					!! assert_list_merger;
					assert_list_merger.merge2 (u.assertions, n.assertions)

					require_else ?= n
					if require_else /= Void then
						!REQUIRE_ELSE_AS! merge_result
					else
						!! merge_result
					end
					merge_result.set_assertions (assert_list_merger.merge_result)
				else
					merge_result := n
				end
			else
				-- Otherwise the result will be the same
				-- as the result of the previous merge
				merge_result := u
			end
		end;

	merge_result: REQUIRE_AS

end -- class REQUIRE_MERGER
