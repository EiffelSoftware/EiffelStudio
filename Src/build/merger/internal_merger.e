class INTERNAL_MERGER

feature
	
	merge3 (old_tmp, user, new_tmp: INTERNAL_AS) is
			-- Merge `old_tmp', `user' and `new_tmp'.
		require
			new_tmp_not_void: new_tmp /= Void
		local
			old_tmp_compound, user_compound, new_tmp_compound: EIFFEL_LIST [INSTRUCTION_AS]
			do_as: DO_AS;
			compound_merger: COMPOUND_MERGER
		do	
			if user /= Void then
				if old_tmp /= Void then
					old_tmp_compound := old_tmp.compound
				end

				!! compound_merger;
				compound_merger.merge3 (old_tmp_compound, user.compound, new_tmp.compound)
			
				do_as ?= new_tmp
				if do_as /= Void then	
					-- If `new_tmp' is a `do'-function,
					-- result should be the same.
					!DO_AS! merge_result
				else
					-- `new_tmp' is a `once_function',
					-- so the result will be the same.
					!ONCE_AS! merge_result
				end

				merge_result.set_compound (compound_merger.merge_result)
			else
				-- Copying new template
				do_as ?= new_tmp
				if do_as /= Void then
					!DO_AS! merge_result
				else
					!ONCE_AS! merge_result
				end

				merge_result.set_compound (new_tmp.compound)	
			end
		end;

	merge_result: INTERNAL_AS

end -- class INTERNAL_MERGER
