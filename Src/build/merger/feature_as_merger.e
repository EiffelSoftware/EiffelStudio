class FEATURE_AS_MERGER

inherit
	COMPILER_EXPORTER
end

feature

	merge3 (old_tmp, user, new_tmp: EXT_FEATURE_AS) is
			-- Merge `old_tmp', `user' and `new_tmp' feature.
		require
			user_f_not_void: user /= Void
		local
			o_body: BODY_AS
			feature_names_merger: FEATURE_NAMES_MERGER
			body_merger: BODY_MERGER
			comment_merger: COMMENT_MERGER
			o_comment: EIFFEL_COMMENTS
		do
			!! merge_result

			if new_tmp /= Void then
				-- Merging feature names
				-- It's not necessary to keep track of feature names,
				-- appearing in the old template.
				!! feature_names_merger
				feature_names_merger.merge2 (user.feature_names, new_tmp.feature_names)
				merge_result.set_feature_names (feature_names_merger.merge_result)

				if old_tmp /= Void then		
					o_body := old_tmp.body
					o_comment := old_tmp.comments
				end

				-- Merging comments.
				!! comment_merger
				comment_merger.merge3 (o_comment, user.comments, new_tmp.comments)
				merge_result.set_comments (comment_merger.merge_result)

				if user.body = Void or else 
					(user.body.is_body_equiv (new_tmp.body) and then
					(user.body.is_assertion_equiv (new_tmp.body)))
				then
					-- Body of user feature is void or is
					-- equivalent to one from new template.
					-- Keeping new template feature
					merge_result.set_body (new_tmp.body)
				else
					-- Merging bodies.
					!! body_merger
					body_merger.merge3 (o_body, user.body, new_tmp.body)
					merge_result.set_body (body_merger.merge_result)
				end
			else
				-- Copying user feature
				merge_result.set_feature_names (user.feature_names)
				merge_result.set_comments (user.comments)
				merge_result.set_body (user.body)
			end
		end

	merge_result: EXT_FEATURE_AS

end -- class FEATURE_AS_MERGER
