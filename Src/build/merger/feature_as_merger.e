class FEATURE_AS_MERGER

inherit
	COMPILER_EXPORTER
end

feature

	merge3 (old_tmp, user, new_tmp: FEATURE_AS) is
			-- Merge `old_tmp', `user' and `new_tmp' feature.
		require
			user_f_not_void: user /= Void
		local
			o_body: BODY_AS
			o_fas_ebuild, u_fas_ebuild, n_fas_ebuild: FEATURE_AS_EBUILD
			o_ras_ebuild, u_ras_ebuild, n_ras_ebuild: ROUTINE_AS_EBUILD
			feature_names_merger: FEATURE_NAMES_MERGER;
			body_merger: BODY_MERGER;
			comment_merger: COMMENT_MERGER;
			o_comment: EIFFEL_COMMENTS;
		do
			o_fas_ebuild ?= old_tmp
			u_fas_ebuild ?= user
			n_fas_ebuild ?= new_tmp

--			if u_fas_ebuild /= Void or n_fas_ebuild /= Void then
				!FEATURE_AS_EBUILD! merge_result
--			else
--				!! merge_result
--			end

			if new_tmp /= Void then
				-- Merging feature names
				-- It's not necessary to keep track of feature names,
				-- appearing in the old template.
				!! feature_names_merger;
				feature_names_merger.merge2 (user.feature_names, new_tmp.feature_names)
				merge_result.set_feature_names (feature_names_merger.merge_result)

				if old_tmp /= Void then		
					o_body := old_tmp.body
				end

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
				merge_result.set_body (user.body)
			end

			if u_fas_ebuild /= Void and n_fas_ebuild /= Void then
				u_ras_ebuild ?= u_fas_ebuild.body.content
				n_ras_ebuild ?= n_fas_ebuild.body.content
				if o_fas_ebuild /= Void then
					o_ras_ebuild ?= o_fas_ebuild.body.content
				end
				if u_ras_ebuild = Void and n_ras_ebuild = Void and then o_ras_ebuild = Void
				then
					-- For attribute comment
					!! comment_merger
					if o_fas_ebuild /= void then
						o_comment := o_fas_ebuild.comment
					end
					
					-- Merging comments for build features.
					comment_merger.merge3 (o_comment,
										u_fas_ebuild.comment, 
										n_fas_ebuild.comment)
				end
			end
		end;

	merge_result: EXT_FEATURE_AS

end -- class FEATURE_AS_MERGER
