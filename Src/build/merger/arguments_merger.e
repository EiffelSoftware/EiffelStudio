class ARGUMENTS_MERGER

inherit
    COMPILER_EXPORTER

feature

	merge2 (user, new_tmp: EIFFEL_LIST [TYPE_DEC_AS]) is
            -- Merge arguments `user' and `new_tmp' in case
            -- user changes template feature. The user is not
            -- allowed to change the arguments of a template
            -- feature manually, so the result will be `new_tmp'.
		do
			if new_tmp /= Void then
				-- Copying arguments of `new_tmp'.
				!! merge_result.make (new_tmp.count)
				merge_result.merge_after_position (0, new_tmp)
			else
				-- Resetting merge result, otherwise it will
				-- be the same as the previous result.
				merge_result := Void
			end
		end;

	merge_result: EIFFEL_LIST [TYPE_DEC_AS]

end -- class ARGUMENTS_MERGER
