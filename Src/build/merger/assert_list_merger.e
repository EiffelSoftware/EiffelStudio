class ASSERT_LIST_MERGER

feature
	
	merge2 (a1, a2: EIFFEL_LIST [TAGGED_AS]) is
			-- Merge assertions `a1' and `a2'.
			-- It will be allowed to have more
			-- than one tag with the same value
			-- as long as the expressions differ
		local
			temp_assertions: LINKED_LIST [TAGGED_AS]
			assertion_found: BOOLEAN
		do
			!! temp_assertions.make
			temp_assertions.start

			from
				a1.start
			until
				a2.after
			loop
				from
					a2.start
					assertion_found := False
				until
					a2.after or else assertion_found
				loop
					assertion_found := a2.item.is_equiv (a1.item)
					a2.forth
				end
				
				if not assertion_found then
					temp_assertions.put_left (a1.item)
				end
				a1.forth
			end

			!! merge_result.make (a2.count + temp_assertions.count)

			-- First assertions `a2'.
			merge_result.merge_after_position (0, a2)

			-- Keep assertions from `a1' not appearing in `a2'.
			merge_result.go_i_th (a2.count + 1)
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
