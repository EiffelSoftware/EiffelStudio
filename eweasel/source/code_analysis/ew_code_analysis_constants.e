note
	description: "String constants used for parsing the code analysis output."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EW_CODE_ANALYSIS_CONSTANTS

feature -- Output messages

	In_class_prefix: STRING = "In class "

	Violation_prefix: STRING = " ["

	Class_not_found_prefix: STRING = "Warning: class "

	Rule_not_found_prefix: STRING = "Warning: Rule "

	Argument_not_recognized_prefix: STRING = "Warning: argument "

	Analysis_clean_message: STRING = "No issues."

feature -- Violation types

	Error: STRING = "Error"

	Warning: STRING = "Warning"

	Suggestion: STRING = "Suggestion"

	Hint: STRING = "Hint"

	Unknown_violation_type: STRING = "Violation"

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
			if a_type.same_string (Error_short) then
				Result := Error
			elseif a_type.same_string (Warning_short) then
				Result := Warning
			elseif a_type.same_string (Suggestion_short) then
				Result := Suggestion
			elseif a_type.same_string (Hint_short) then
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
			if a_type.same_string (Error) then
				Result := Error_short
			elseif a_type.same_string (Warning) then
				Result := Warning_short
			elseif a_type.same_string (Suggestion) then
				Result := Suggestion_short
			elseif a_type.same_string (Hint) then
				Result := Hint_short
			end
		ensure
			valid_short: is_valid_short_violation_type (Result)
		end

end
