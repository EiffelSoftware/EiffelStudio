class FEATURE_AS_MERGER

feature

	merge3 (o, u, n: FEATURE_AS) is
			-- Merge `o'ld, `u'ser-defined and `n'ew feature.
		require
			u_not_void: u /= Void
		local
			o_body: BODY_AS
			o_fas_ebuild, u_fas_ebuild, n_fas_ebuild: FEATURE_AS_EBUILD
			o_ras_ebuild, u_ras_ebuild, n_ras_ebuild: ROUTINE_AS_EBUILD
			feature_names_merger: FEATURE_NAMES_MERGER;
			body_merger: BODY_MERGER;
			comment_merger: COMMENT_MERGER
		do
			o_fas_ebuild ?= o
			u_fas_ebuild ?= u
			n_fas_ebuild ?= n

			if u_fas_ebuild /= Void or n_fas_ebuild /= Void then
				!FEATURE_AS_EBUILD! merge_result
			else
				!! merge_result
			end

			if n /= Void then
				!! feature_names_merger;
				feature_names_merger.merge2 (u.feature_names, n.feature_names)
				merge_result.set_feature_names (feature_names_merger.merge_result)

				if o /= Void then		
					o_body := o.body
				end

				if u.body.is_body_equiv (n.body) then
					merge_result.set_body (n.body)
				else
					!! body_merger
					body_merger.merge3 (o_body, u.body, n.body)
					merge_result.set_body (body_merger.merge_result)
				end
			else
				merge_result.set_feature_names (u.feature_names)
				merge_result.set_body (u.body)
				merge_result.set_body_id (u.body_id)
				merge_result.set_id (u.id)
			end

			if u_fas_ebuild /= Void and n_fas_ebuild /= Void then
				u_ras_ebuild ?= u_fas_ebuild.body.content
				n_ras_ebuild ?= n_fas_ebuild.body.content
				o_ras_ebuild ?= o_fas_ebuild.body.content
				if u_ras_ebuild = Void and n_ras_ebuild = Void and then
					o_ras_ebuild = Void
				then
						-- For attribute comment
					!! comment_merger
					comment_merger.merge3 (o_fas_ebuild.comment,
										u_fas_ebuild.comment, 
										n_fas_ebuild.comment)
					merge_result.set_comment (comment_merger.merge_result)
				end
			end
		end;

	merge_result: FEATURE_AS

end -- class FEATURE_AS_MERGER
