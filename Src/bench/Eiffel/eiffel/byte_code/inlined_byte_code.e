class INLINED_BYTE_CODE

inherit

	STD_BYTE_CODE
		redefine
			enlarged, has_inlined_code
		end

feature

	fill_from (std: STD_BYTE_CODE) is
		do
			arguments := std.arguments
			body_index := std.body_index
			byte_id := std.byte_id
			feature_name := std.feature_name
			locals := std.locals
			old_expressions := std.old_expressions
			pattern_id := std.pattern_id
			postcondition := std.postcondition
			precondition := std.precondition
			real_body_id := std.real_body_id
			rescue_clause := std.rescue_clause
			result_type := std.result_type
			rout_id := std.rout_id
			compound := std.compound
		end

	enlarged: INLINED_BYTE_CODE is
		do
		end

	has_inlined_code: BOOLEAN is
		do
			Result := True
		end

end
