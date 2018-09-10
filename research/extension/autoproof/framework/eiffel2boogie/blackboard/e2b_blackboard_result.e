note
	description: "Summary description for {E2B_BLACKBOARD_RESULT}."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_BLACKBOARD_RESULT

inherit

	EBB_VERIFICATION_RESULT
		rename make as make_ end

create
	make

feature {NONE} -- Initialization

	make (a_procedure_result: E2B_VERIFICATION_RESULT; a_configuration: EBB_TOOL_CONFIGURATION; a_score: REAL)
			-- Initialize blackboard result.
		do
			make_ (a_procedure_result.context_feature, a_configuration, a_score)
			procedure_result := a_procedure_result
		end

feature -- Access

	procedure_result: E2B_VERIFICATION_RESULT
			-- Result.

	message: STRING
			-- Message describing result.
		local
			l_formatter: YANK_STRING_WINDOW
		do
			create l_formatter.make
			procedure_result.single_line_message (l_formatter)
			Result := l_formatter.stored_output
		end

end
