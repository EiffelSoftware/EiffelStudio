class ROUTINE_MERGER

feature

	merge3 (old_tmp, user, new_tmp: ROUTINE_AS) is
			-- Merge routine's `old_tmp', `user', `new_tmp'.
		local
			old_tmp_rout_body, user_rout_body, new_tmp_rout_body: ROUT_BODY_AS
			user_require, new_tmp_require: REQUIRE_AS
			user_ensure, new_tmp_ensure: ENSURE_AS
			old_tmp_locals, user_locals, new_tmp_locals: EIFFEL_LIST [TYPE_DEC_AS]
			old_tmp_com, user_com, new_tmp_com: EIFFEL_COMMENTS
			rout_body_merger: ROUT_BODY_MERGER
			require_merger: REQUIRE_MERGER
			ensure_merger: ENSURE_MERGER
			locals_merger: LOCALS_MERGER
			comment_merger: COMMENT_MERGER
			user_eb, new_tmp_eb: ROUTINE_AS_EBUILD
		do
			if old_tmp /= Void then
		--samik		old_tmp_com := old_tmp.comment
				old_tmp_rout_body := old_tmp.routine_body
				old_tmp_locals := old_tmp.locals
			end

			if user /= Void then
		--samik		user_com := user.comment
				user_rout_body := user.routine_body
				user_require := user.precondition
				user_ensure := user.postcondition
				user_locals := user.locals
			end
	
			if new_tmp /= Void then
			--samik	new_tmp_com := new_tmp.comment
				new_tmp_rout_body := new_tmp.routine_body
				new_tmp_require := new_tmp.precondition
				new_tmp_ensure := new_tmp.postcondition
				new_tmp_locals := new_tmp.locals
			end

			if new_tmp_rout_body /= Void then
				user_eb ?= user
				new_tmp_eb ?= new_tmp
				if user_eb /= Void or new_tmp_eb /= Void then
					!ROUTINE_AS_EBUILD! merge_result
				else
					!! merge_result
				end

				!! rout_body_merger;
				rout_body_merger.merge3 (old_tmp_rout_body, user_rout_body, new_tmp_rout_body)
				merge_result.set_routine_body (rout_body_merger.merge_result)

				!! require_merger;
				require_merger.merge2 (user_require, new_tmp_require)
				merge_result.set_precondition (require_merger.merge_result)

				!! ensure_merger;
				ensure_merger.merge2 (user_ensure, new_tmp_ensure)
				merge_result.set_postcondition (ensure_merger.merge_result)	

				!! locals_merger;
				locals_merger.merge3 (old_tmp_locals, user_locals, new_tmp_locals)
				merge_result.set_locals (locals_merger.merge_result)

				merge_result.set_obsolete_message (new_tmp.obsolete_message)
				merge_result.set_rescue_clause (new_tmp.rescue_clause)
				!! comment_merger;
				comment_merger.merge3 (old_tmp_com, user_com, new_tmp_com)
		--samik		merge_result.set_comment (comment_merger.merge_result)
			else
				!! merge_result
				merge_result.set_routine_body (new_tmp_rout_body)
				merge_result.set_precondition (new_tmp_require)
				merge_result.set_postcondition (new_tmp_ensure)
				merge_result.set_locals (new_tmp_locals)
				merge_result.set_obsolete_message (new_tmp.obsolete_message)
				merge_result.set_rescue_clause (new_tmp.rescue_clause)
			end
		end

	merge_result: ROUTINE_AS

end -- class ROUTINE_MERGER
