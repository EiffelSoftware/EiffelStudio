class GENERICS_MERGER

inherit
    COMPILER_EXPORTER
end

feature

	merge2 (user, new_tmp: EIFFEL_LIST [FORMAL_DEC_AS]) is
			-- Merge generics `user' and `new_tmp'.
			-- `user' will become `new_tmp'.
		do
			if new_tmp /= Void then
				!! merge_result.make (new_tmp.count)
				merge_result.merge_after_position (0, new_tmp)
			else
				merge_result := Void
			end
		end;

	merge_result: EIFFEL_LIST [FORMAL_DEC_AS]

end -- class GENERICS_MERGER
