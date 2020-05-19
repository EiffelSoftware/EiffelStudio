note
	description: "String constants used for parsing the code analysis output."
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EW_CODE_ANALYSIS_CONSTANTS

feature -- Output messages

	In_class_prefix: STRING = "In class "

	Violation_prefix: STRING = " ["

	Class_not_found_prefix: STRING = "Warning: class "

	Rule_not_found_prefix: STRING = "Warning: rule "

	Preference_not_found_prefix: STRING = "Warning: preference "

	Argument_not_recognized_prefix: STRING = "Warning: argument "

	Analysis_clean_message: STRING = "No issues."

feature -- Violation types

	Error: STRING_32 = "Error"

	Warning: STRING_32 = "Warning"

	Suggestion: STRING_32 = "Suggestion"

	Hint: STRING_32 = "Hint"

	is_valid_violation_type (a_type: READABLE_STRING_32): BOOLEAN
		do
			Result :=
				a_type.same_string (error) or else
				a_type.same_string (warning) or else
				a_type.same_string (suggestion) or else
				a_type.same_string (hint)
		end

	error_short: STRING = "E"

	warning_short: STRING = "W"

	suggestion_short: STRING = "S"

	hint_short: STRING = "H"

	Unknown_violation_type_short: STRING = "?"

	is_valid_short_violation_type (a_type: detachable STRING): BOOLEAN
		do
			Result := a_type ~ Error_short or a_type ~ Warning_short or a_type ~ Suggestion_short or a_type ~ Hint_short
		end

	long_violation_type (a_type: STRING): READABLE_STRING_32
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
			else
				check from_precondition: False then end
			end
		ensure
			valid: is_valid_violation_type (Result)
			correct: short_violation_type (Result).same_string (a_type)
		end

	short_violation_type (a_type: READABLE_STRING_32): STRING
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
			else
				check from_precondition: False then end
			end
		ensure
			valid_short: is_valid_short_violation_type (Result)
			correct: long_violation_type (Result).same_string (a_type)
		end

end
