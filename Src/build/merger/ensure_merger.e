class ENSURE_MERGER

feature

	merge2 (u, n: ENSURE_AS) is
			-- Merge ensures from `u'ser and `n'ew.
		local
			ensure_then: ENSURE_THEN_AS;
			assert_list_merger: ASSERT_LIST_MERGER
		do
			if n /= Void then
				if u /= Void then
					!! assert_list_merger;
					assert_list_merger.merge2 (u.assertions, n.assertions)

					ensure_then ?= n
					if ensure_then /= Void then
						!ENSURE_THEN_AS! merge_result
					else
						!! merge_result
					end
					merge_result.set_assertions (assert_list_merger.merge_result)
				else
					merge_result := n
				end
			else
				-- Otherwise the result will be the same
				-- as the previous merge result.
				merge_result := u
			end
		end;

	merge_result: ENSURE_AS

end -- class ENSURE_MERGER	
