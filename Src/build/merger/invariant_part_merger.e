class INVARIANT_PART_MERGER

feature

	merge2 (i1, i2: INVARIANT_AS) is
			-- Merge invariant-parts `i1' and `i2'.
			-- It will be allowed to have more than
			-- one assertion with the same tag, as long
			-- as the expressions differ.
		local
			i1_ass_list, i2_ass_list, new_assertions: EIFFEL_LIST [TAGGED_AS]
			temp_assertions: LINKED_LIST [TAGGED_AS]
			assertion_found: BOOLEAN;
			assert_list_merger: ASSERT_LIST_MERGER;
		do
			if i2 /= Void and i1 /= Void then
				!! assert_list_merger;
				assert_list_merger.merge2 (i1.assertion_list, i2.assertion_list)
				!! merge_result
				merge_result.set_assertion_list (assert_list_merger.merge_result)
				merge_result.set_id (i2.id)
			elseif i2 /= Void then
				-- i2 not Void, i1 Void
				!! merge_result
				merge_result.set_assertion_list (i2.assertion_list)
				merge_result.set_id (i2.id)
			elseif i1 /= Void then
				-- i2 Void, i1 not Void
				!! merge_result
				merge_result.set_assertion_list (i1.assertion_list)
				merge_result.set_id (i1.id)
			else
				-- Both void 
				merge_result := Void
			end
		end;

	merge_result: INVARIANT_AS

end -- class INVARIANT_PART_MERGER
