class INDEXES_MERGER

feature

	merge2 (user_i, new_i: EIFFEL_LIST [INDEX_AS]) is
			-- Merge indexes `user_i' and `new_i'.
			-- It will be allowed to have more 
			-- than one index with the same tag.
			-- as long as the indexes differ.
		local
			new_indexes: EIFFEL_LIST [INDEX_AS]
			temp_indexes: LINKED_LIST [INDEX_AS]
			index_found: BOOLEAN
		do
			if user_i /= Void then
				if new_i /= Void then
					from
						!! temp_indexes.make 
						temp_indexes.start
						user_i.start
					until
						user_i.after
					loop
						from
							new_i.start
							index_found := False
						until
							new_i.after or else index_found
						loop
							index_found := user_i.item.is_equiv (new_i.item)
							new_i.forth
						end

						if not index_found then
							temp_indexes.put_left (user_i.item)
						end

						user_i.forth
					end

					!! new_indexes.make (temp_indexes.count + new_i.count)
				
					-- First indexes of `new_i'
					new_indexes.merge_after_position (0, new_i)

					-- Keep indexes of `user_i' not appearing in `new_i'.
					new_indexes.go_i_th (new_i.count + 1)
					from
						temp_indexes.start
					until
						temp_indexes.after
					loop
						new_indexes.put_i_th (temp_indexes.item, new_indexes.index)
						new_indexes.forth
						temp_indexes.forth
					end

					merge_result := new_indexes
				end
			else
				if new_i /= Void then
					!! merge_result.make (new_i.count)
					merge_result.merge_after_position (0, user_i)
				else
					merge_result := Void
				end
			end
		end;

	merge_result: EIFFEL_LIST [INDEX_AS]

end -- class INDEXES_MERGE
