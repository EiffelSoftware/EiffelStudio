note
	description: "Result of an incomplete/aborted verification."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_INCONCLUSIVE_RESULT

inherit

	E2B_FAILED_VERIFICATION
		redefine
			single_line_message
		end

create
	make

feature -- Display

	single_line_message (a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (locale.translation_in_context ("Inconclusive result (verifier timed out).", once "tool.auto_proof.result"))
		end

end
