class CONTENT_MERGER

feature

	merge3 (old_tmp, user, new_tmp: CONTENT_AS) is
			-- Only `internal' contents will be merged,
			-- otherwise the merge result will be `new_tmp'.
		local
			old_tmp_routine, user_routine, new_tmp_routine: ROUTINE_AS;
			routine_merger: ROUTINE_MERGER
		do
			new_tmp_routine ?= new_tmp	
			if new_tmp_routine /= Void then
				-- ROUTINE_AS
				old_tmp_routine ?= old_tmp
				user_routine ?= user
				!! routine_merger;
				routine_merger.merge3 (old_tmp_routine, user_routine, new_tmp_routine)
				merge_result := routine_merger.merge_result
			else
				-- CONSTANT_AS
				merge_result := new_tmp
			end
		end

	merge_result: CONTENT_AS

end -- class CONTENT_MERGER
