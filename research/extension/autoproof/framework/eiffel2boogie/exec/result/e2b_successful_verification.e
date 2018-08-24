note
	description: "Result of a successful verification."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_SUCCESSFUL_VERIFICATION

inherit

	E2B_VERIFICATION_RESULT

feature -- Access

	original_errors: detachable LINKED_LIST [E2B_VERIFICATION_ERROR]
			-- Original errors (if any)

	suggestion: STRING
			-- Suggestion for user.

feature -- Element change

	add_original_error (a_error: E2B_VERIFICATION_ERROR)
			-- Add `a_error' to `original_errors'.
		do
			if not attached original_errors then
				create original_errors.make
			end
			original_errors.extend (a_error)
			if attached {E2B_DEFAULT_VERIFICATION_ERROR} a_error as l_default then
				if l_default.boogie_error.is_precondition_violation then
					set_suggestion ("You might need to weaken the precondition.")
				elseif l_default.boogie_error.is_assert_error or l_default.boogie_error.is_postcondition_violation then
					set_suggestion ("You might need to strenghten the loop invariant or postcondition of called features.")
				end
			end
		end

	set_suggestion (a_string: STRING)
			-- Set `suggestion' to `a_string'.
		do
			suggestion := a_string.twin
		end

feature -- Display

	single_line_message (a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			if attached original_errors and then not original_errors.is_empty then
				a_formatter.add (locale.plural_translation_in_context
					("Verification successful after inlining. (See an original error.)",
					"Verification successful after inlining. (See original errors.)",
					 once "tool.auto_proof.result", original_errors.count))
			else
				a_formatter.add (locale.translation_in_context (once "Verification successful.", once "tool.auto_proof.result"))
			end
		end

end
