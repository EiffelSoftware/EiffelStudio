class COMMENT_MERGER

feature

	merge3 (o, u, n: EIFFEL_COMMENTS) is
			-- Merge comments `u' and `n'.
		local
			user_d: EIFFEL_COMMENTS
		do
			if n /= Void then 
				if o /= Void and then u /= Void then
					user_d := u.diff (o)
				end;
				!! merge_result.make
				merge_result.setup (n)
				merge_result.copy (n)
				if user_d /= Void then
					-- Keeping user added comments.
					merge_result.merge (user_d)
				end
			elseif u /= Void then
			    !! merge_result.make
                merge_result.setup (u)
                merge_result.copy (u)
        	else
				-- Otherwise the result will be the
				-- result of the previous comment merge.
				merge_result := Void 
			end
		end;

	merge_result: EIFFEL_COMMENTS

end -- class COMMENT_MERGER
