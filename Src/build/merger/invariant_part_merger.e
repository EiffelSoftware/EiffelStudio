class INVARIANT_PART_MERGER

inherit
    COMPILER_EXPORTER

feature

	merge2 (user, new_tmp: INVARIANT_AS) is
			-- Merge invariant-parts `user' and `new_tmp'.
			-- It will be allowed to have more than
			-- one assertion with the same tag, as long
			-- as the expressions differ.
		local
			user_ass_list, new_tmp_ass_list, new_assertions: EIFFEL_LIST [TAGGED_AS]
			temp_assertions: LINKED_LIST [TAGGED_AS]
			assertion_found: BOOLEAN;
			assert_list_merger: ASSERT_LIST_MERGER;
		do
			if new_tmp /= Void and user /= Void then
				-- Merging assertion lists
				!! assert_list_merger;
				assert_list_merger.merge2 (user.assertion_list, new_tmp.assertion_list)
				!! merge_result
				merge_result.set_assertion_list (assert_list_merger.merge_result)
	--samik			merge_result.set_id (new_tmp.id)
			elseif new_tmp /= Void then
				-- `new_tmp' not Void, `user' Void
				-- Copying `new_tmp'
				!! merge_result
				merge_result.set_assertion_list (new_tmp.assertion_list)
	--samik			merge_result.set_id (new_tmp.id)
			elseif user /= Void then
				-- `new_tmp' Void, `user' not Void
				-- Copying `user'
				!! merge_result
				merge_result.set_assertion_list (user.assertion_list)
	--samik			merge_result.set_id (user.id)
			else
				-- Both void 
				merge_result := Void
			end
		end;

	merge_result: INVARIANT_AS

end -- class INVARIANT_PART_MERGER
