note
	description: "Summary description for {EBB_VERIFICATION_RESULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EBB_VERIFICATION_RESULT

inherit

	EBB_FEATURE_ASSOCIATION

feature {NONE} -- Initialization

	make (a_feature: FEATURE_I; a_configuration: EBB_TOOL_CONFIGURATION; a_score: REAL)
			-- Initialize result.
		do
			make_with_feature (a_feature)
			tool_configuration := a_configuration
			score := a_score

			weight := 1.0
		end

feature -- Access

	tool: EBB_TOOL
			-- Tool that produced result.
		do
			Result := tool_configuration.tool
		end

	tool_configuration: EBB_TOOL_CONFIGURATION
			-- Configuration that was used.

	score: REAL
			-- Final score of this result.

	weight: REAL
			-- Weight of this result.

	message: STRING
			-- Message describing result.
		deferred
		end

feature -- Status report

	has_score: BOOLEAN
			-- Is a score set?
		do
			Result := score >= 0
		end

feature -- Basic operations

	single_line_message (a_formatter: TEXT_FORMATTER)
			-- Write single line message to `a_formatter'.
		do
			a_formatter.add (message)
		end

	multi_line_message (a_formatter: TEXT_FORMATTER)
			-- Write multi line message to `a_formatter'.
		do
			single_line_message (a_formatter)
			a_formatter.add_new_line
		end

	set_weight (a_weight: REAL)
		do
			weight := a_weight
		end
		
invariant
	score_in_range: has_score implies 0.0 <= score and score <= 1.0

end
