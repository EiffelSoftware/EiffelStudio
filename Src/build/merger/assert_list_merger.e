class ASSERT_LIST_MERGER

inherit
    COMPILER_EXPORTER

feature
	
	merge2 (user, new_tmp: EIFFEL_LIST [TAGGED_AS]) is
			-- Merge assertions `user' and `new_tmp'.
			-- It will be allowed to have more
			-- than one tag with the same value
			-- as long as the expressions differ
		local
			temp_assertions: LINKED_LIST [TAGGED_AS]
			assertion_found: BOOLEAN
		do

			-- Temporarily storing assertions that
			-- should be kept.
			!! temp_assertions.make
			temp_assertions.start

			from
				user.start
			until
				new_tmp.after
			loop
				-- Traversing `user' and `new_tmp' assertions
				-- to keep user defined assertions.

				from
					new_tmp.start
					assertion_found := False
				until
					new_tmp.after or else assertion_found
				loop
					assertion_found := new_tmp.item.is_equiv (user.item)
					new_tmp.forth
				end
				
				if not assertion_found then
					temp_assertions.put_left (user.item)
				end
				user.forth
			end

			!! merge_result.make (new_tmp.count + temp_assertions.count)

			-- First the assertions of `new_tmp' will be put
			-- in the merge result.
			merge_result.merge_after_position (0, new_tmp)

			-- Keeping assertions from `user' not appearing in `new_tmp'.
			merge_result.go_i_th (new_tmp.count + 1)
			from
				temp_assertions.start
			until
				temp_assertions.after
			loop
				merge_result.put_i_th (temp_assertions.item, merge_result.index)
				merge_result.forth
				temp_assertions.forth
			end
		end;

	merge_result: EIFFEL_LIST [TAGGED_AS]

end -- class ASSERT_LIST_MERGER
