class INDEXES_MERGER

inherit
    COMPILER_EXPORTER

feature

	merge2 (user, new_tmp: EIFFEL_LIST [INDEX_AS]) is
			-- Merge indexes `user' and `new_tmp'.
			-- It will be allowed to have more 
			-- than one index with the same tag.
			-- as long as the indexes differ.
		local
			new_indexes: EIFFEL_LIST [INDEX_AS]
			temp_indexes: LINKED_LIST [INDEX_AS]
			index_found: BOOLEAN
		do
			if user /= Void then
				if new_tmp /= Void then
					from
						!! temp_indexes.make 
						temp_indexes.start
						user.start
					until
						user.after
					loop
						from
							new_tmp.start
							index_found := False
						until
							new_tmp.after or else index_found
						loop
							index_found := user.item.is_equiv (new_tmp.item)
							new_tmp.forth
						end

						if not index_found then
							temp_indexes.put_left (user.item)
						end

						user.forth
					end

					!! new_indexes.make_filled (temp_indexes.count + new_tmp.count)
				
					-- First indexes of `new_tmp'
					new_indexes.merge_after_position (0, new_tmp)

					-- Keep indexes of `user' not appearing in `new_tmp'.
					new_indexes.go_i_th (new_tmp.count + 1)
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
				if new_tmp /= Void then
					!! merge_result.make_filled (new_tmp.count)
					merge_result.merge_after_position (0, user)
				else
					merge_result := Void
				end
			end
		end;

	merge_result: EIFFEL_LIST [INDEX_AS]

end -- class INDEXES_MERGE
