class REQUIRE_MERGER

feature
	
	merge2 (user, new_tmp: REQUIRE_AS) is
			-- Merge requires from `user' file and `new_tmp'.
		local
			require_else: REQUIRE_ELSE_AS
			assert_list_merger: ASSERT_LIST_MERGER
		do
			if new_tmp /= Void then
				if user /= Void then
					!! assert_list_merger;
					assert_list_merger.merge2 (user.assertions, new_tmp.assertions)

					require_else ?= new_tmp
					if require_else /= Void then
						-- If `new_tmp' is a `require else' statement
						-- then the merge result should be one.
						!REQUIRE_ELSE_AS! merge_result
					else
						!! merge_result
					end
					merge_result.set_assertions (assert_list_merger.merge_result)
				else
					merge_result := new_tmp
				end
			else
				-- Otherwise the result will be the same
				-- as the result of the previous merge
				merge_result := user
			end
		end;

	merge_result: REQUIRE_AS

end -- class REQUIRE_MERGER
