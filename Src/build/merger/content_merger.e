class CONTENT_MERGER

feature

	merge3 (c1, c2, c3: CONTENT_AS) is
			-- Only `internal' contents will be merged,
			-- otherwise the merge result will be `c3'.
		local
			c1_routine, c2_routine, c3_routine: ROUTINE_AS;
			routine_merger: ROUTINE_MERGER
		do
			c3_routine ?= c3	
			if c3_routine /= Void then
				c1_routine ?= c1
				c2_routine ?= c2
				!! routine_merger;
				routine_merger.merge3 (c1_routine, c2_routine, c3_routine)
				merge_result := routine_merger.merge_result
			else
				-- CONSTANT_AS
				merge_result := c3
			end
		end

	merge_result: CONTENT_AS

end -- class CONTENT_MERGER
