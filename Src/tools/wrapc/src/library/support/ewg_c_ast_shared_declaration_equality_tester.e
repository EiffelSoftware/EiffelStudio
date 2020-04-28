note

	description:

		"Shared equality tester for declarations"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_AST_SHARED_DECLARATION_EQUALITY_TESTER

feature -- Access

	declaration_equality_tester: EWG_C_AST_DECLARATION_EQUALITY_TESTER [EWG_C_AST_DECLARATION]
			-- Declaration equality tester
		once
			create Result
		ensure
			tester_not_void: Result /= Void
		end

	function_declaration_equality_tester: EWG_C_AST_DECLARATION_EQUALITY_TESTER [EWG_C_AST_FUNCTION_DECLARATION] 
			-- Function declaration equality tester
		once
			create Result
		ensure
			tester_not_void: Result /= Void
		end

end
