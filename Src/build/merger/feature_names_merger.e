class FEATURE_NAMES_MERGER

inherit
	COMPILER_EXPORTER
end

feature

	merge2 (user, new_tmp: EIFFEL_LIST [FEATURE_NAME]) is
			-- Merge feature names `user' and `new_tmp'.
		local
			new_feature_names: EIFFEL_LIST [FEATURE_NAME]
			new_names: LINKED_LIST [FEATURE_NAME]
		do
			!! new_names.make
			new_names.start
	
			-- Keeping names from template feature	
			from
				new_tmp.start
			until
				new_tmp.after
			loop
				new_names.put_left (new_tmp.item)
				new_tmp.forth
			end

			-- Adding user defined names.
			from
				user.start
			until
				user.after
			loop
				from 
					new_tmp.start
				until
					new_tmp.after or else (new_tmp.item <= user.item and new_tmp.item >= user.item)
				loop
					new_tmp.forth
				end
				if new_tmp.after then
					new_names.put_left (user.item)
				end

				user.forth
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
