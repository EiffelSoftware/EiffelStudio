class FEATURE_NAMES_MERGER

feature

	merge2 (f1, f2: EIFFEL_LIST [FEATURE_NAME]) is
			-- Merge feature names `f1' and `f2'.
		local
			new_feature_names: EIFFEL_LIST [FEATURE_NAME]
			new_names: LINKED_LIST [FEATURE_NAME]
		do
			!! new_names.make
			new_names.start
	
			-- Keeping names from template feature	
			from
				f2.start
			until
				f2.after
			loop
				new_names.put_left (f2.item)
				f2.forth
			end

			-- Adding user defined names.
			from
				f1.start
			until
				f1.after
			loop
				from 
					f2.start
				until
					f2.after or else (f2.item <= f1.item and f2.item >= f1.item)
				loop
					f2.forth
				end
				if f2.after then
					new_names.put_left (f1.item)
				end

				f1.forth
			end;
			
			!! merge_result.make (new_names.count)

			from
				merge_result.start
				new_names.start
			until
				merge_result.after
			loop
				merge_result.put_i_th (new_names.item, merge_result.index)
				merge_result.forth
				new_names.forth
			end
		end;

	merge_result: EIFFEL_LIST [FEATURE_NAME]

end -- class FEATURE_NAMES_MERGER
