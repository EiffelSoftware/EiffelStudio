class ARGUMENTS_MERGER

feature

	merge2 (a1, a2: EIFFEL_LIST [TYPE_DEC_AS]) is
			-- Merge arguments `a1' and `a2'.
			-- Result will be `a2'.
		do
			if a2 /= Void then
				!! merge_result.make (a2.count)
				merge_result.merge_after_position (0, a2)
			else
				-- Otherwise the result will be the same
				-- as the previous merge result.
				merge_result := Void
			end
		end;

	merge_result: EIFFEL_LIST [TYPE_DEC_AS]

end -- class ARGUMENTS_MERGER
