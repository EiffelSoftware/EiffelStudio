class ENSURE_MERGER

feature

	merge2 (user, new_tmp: ENSURE_AS) is
			-- Merge ensures from `user' and `new_tmp'.
		local
			ensure_then: ENSURE_THEN_AS;
			assert_list_merger: ASSERT_LIST_MERGER
		do
			if new_tmp /= Void then
				if user /= Void then
					!! assert_list_merger;
					assert_list_merger.merge2 (user.assertions, new_tmp.assertions)

					ensure_then ?= new_tmp
					if ensure_then /= Void then
						-- If the template had an `ensure then' then
						-- this should be kept.
						!ENSURE_THEN_AS! merge_result
					else
						!! merge_result
					end
					merge_result.set_assertions (assert_list_merger.merge_result)
				else
					merge_result := new_tmp
				end
			else
				-- Otherwise the result will be the same
				-- as the previous merge result.
				merge_result := user
			end
		end;

	merge_result: ENSURE_AS

end -- class ENSURE_MERGER	
