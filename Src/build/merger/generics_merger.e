class GENERICS_MERGER

feature

	merge2 (g1, g2: EIFFEL_LIST [FORMAL_DEC_AS]) is
			-- Merge generics `g1' and `g2'.
			-- `g1' will become `g2'.
		do
			if g2 /= Void then
				!! merge_result.make (g2.count)
				merge_result.merge_after_position (0, g2)
			else
				merge_result := Void
			end
		end;

	merge_result: EIFFEL_LIST [FORMAL_DEC_AS]

end -- class GENERICS_MERGER
