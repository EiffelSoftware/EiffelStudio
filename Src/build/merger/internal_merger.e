class INTERNAL_MERGER

feature
	
	merge3 (i1, i2, i3: INTERNAL_AS) is
		require
			i3_not_void: i3 /= Void
		local
			i1_compound, i2_compound, i3_compound: EIFFEL_LIST [INSTRUCTION_AS]
			do_as: DO_AS;
			compound_merger: COMPOUND_MERGER
		do	
			if i2 /= Void then
				if i1 /= Void then
					i1_compound := i1.compound
				end

				!! compound_merger;
				compound_merger.merge3 (i1_compound, i2.compound, i3.compound)
			
				do_as ?= i3
				if do_as /= Void then	
					!DO_AS! merge_result
				else
					!ONCE_AS! merge_result
				end

				merge_result.set_compound (compound_merger.merge_result)
			else
				do_as ?= i3
				if do_as /= Void then
					!DO_AS! merge_result
				else
					!ONCE_AS! merge_result
				end

				merge_result.set_compound (i3.compound)	
			end
		end;

	merge_result: INTERNAL_AS

end -- class INTERNAL_MERGER
