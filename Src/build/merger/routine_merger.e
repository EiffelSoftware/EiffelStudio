class ROUTINE_MERGER

feature

	merge3 (r1, r2, r3: ROUTINE_AS) is
			-- Merge routine's `r1', `r2', `r3'.
		local
			r1_rout_body, r2_rout_body, r3_rout_body: ROUT_BODY_AS
			r2_require, r3_require: REQUIRE_AS
			r2_ensure, r3_ensure: ENSURE_AS
			r1_locals, r2_locals, r3_locals: EIFFEL_LIST [TYPE_DEC_AS]
			r1_com, r2_com, r3_com: EIFFEL_COMMENTS
			rout_body_merger: ROUT_BODY_MERGER
			require_merger: REQUIRE_MERGER
			ensure_merger: ENSURE_MERGER
			locals_merger: LOCALS_MERGER
			comment_merger: COMMENT_MERGER
			r2_eb, r3_eb: ROUTINE_AS_EBUILD
		do
			if r1 /= Void then
				r1_com := r1.comment
				r1_rout_body := r1.routine_body
				r1_locals := r1.locals
			end

			if r2 /= Void then
				r2_com := r2.comment
				r2_rout_body := r2.routine_body
				r2_require := r2.precondition
				r2_ensure := r2.postcondition
				r2_locals := r2.locals
			end
	
			if r3 /= Void then
				r3_com := r3.comment
				r3_rout_body := r3.routine_body
				r3_require := r3.precondition
				r3_ensure := r3.postcondition
				r3_locals := r3.locals
			end

			if r3_rout_body /= Void then
				r2_eb ?= r2
				r3_eb ?= r3
				if r2_eb /= Void or r3_eb /= Void then
					!ROUTINE_AS_EBUILD! merge_result
				else
					!! merge_result
				end

				!! rout_body_merger;
				rout_body_merger.merge3 (r1_rout_body, r2_rout_body, r3_rout_body)
				merge_result.set_routine_body (rout_body_merger.merge_result)

				!! require_merger;
				require_merger.merge2 (r2_require, r3_require)
				merge_result.set_precondition (require_merger.merge_result)

				!! ensure_merger;
				ensure_merger.merge2 (r2_ensure, r3_ensure)
				merge_result.set_postcondition (ensure_merger.merge_result)	

				!! locals_merger;
				locals_merger.merge3 (r1_locals, r2_locals, r3_locals)
				merge_result.set_locals (locals_merger.merge_result)

				merge_result.set_obsolete_message (r3.obsolete_message)
				merge_result.set_rescue_clause (r3.rescue_clause)
				!! comment_merger;
				comment_merger.merge3 (r1_com, r2_com, r3_com)
				merge_result.set_comment (comment_merger.merge_result)
			else
				!! merge_result
				merge_result.set_routine_body (r3_rout_body)
				merge_result.set_precondition (r3_require)
				merge_result.set_postcondition (r3_ensure)
				merge_result.set_locals (r3_locals)
				merge_result.set_obsolete_message (r3.obsolete_message)
				merge_result.set_rescue_clause (r3.rescue_clause)
			end
		end

	merge_result: ROUTINE_AS

end -- class ROUTINE_MERGER
