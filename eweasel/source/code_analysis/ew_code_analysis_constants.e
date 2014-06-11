note
	description: "Summary description for {EW_SHARED_CODE_ANALYSIS_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EW_CODE_ANALYSIS_CONSTANTS

feature -- Output messages

	In_class_prefix: STRING = "In class "
	Violation_prefix: STRING = " ["

	Analysis_clean_message: STRING = "No_issues."

feature -- Violation types

	Error: STRING = "Error"
	Warning: STRING = "Warning"
	Suggestion: STRING = "Suggestion"
	Hint: STRING = "Hint"
	Unknown_violation_type: STRING = "Unknown violation type"

	is_valid_violation_type (a_type: STRING): BOOLEAN
		do
			Result := (a_type ~ Error or a_type ~ Warning or a_type ~ Suggestion or a_type ~ Hint)
		end

	Error_short: STRING = "E"
	Warning_short: STRING = "W"
	Suggestion_short: STRING = "S"
	Hint_short: STRING = "H"
	Unknown_violation_type_short: STRING = "?"

	is_valid_short_violation_type (a_type: STRING): BOOLEAN
		do
			Result := (a_type ~ Error_short or a_type ~ Warning_short or a_type ~ Suggestion_short or a_type ~ Hint_short)
		end


	long_violation_type (a_type: STRING): STRING
			-- Convert a short violation type string to the long form.
		require
			valid_short: is_valid_short_violation_type (a_type)
		do
			-- Hardcoding should be fine for just four cases.
			if a_type ~ Error_short then
				Result := Error
			elseif a_type ~ Warning_short then
				Result := Warning
			elseif a_type ~ Suggestion_short then
				Result := Suggestion
			elseif a_type ~ Hint_short then
				Result := Hint
			end
		ensure
			valid: is_valid_violation_type (Result)
		end


	short_violation_type (a_type: STRING): STRING
			-- Convert a long violation type string to the short form.
		require
			valid: is_valid_violation_type (a_type)
		do
			-- Hardcoding should be fine for just four cases.
			if a_type ~ Error then
				Result := Error_short
			elseif a_type ~ Warning then
				Result := Warning_short
			elseif a_type ~ Suggestion then
				Result := Suggestion_short
			elseif a_type ~ Hint then
				Result := Hint_short
			end
		ensure
			valid_short: is_valid_short_violation_type (Result)
		end

end
