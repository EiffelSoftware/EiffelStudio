note
	description: "Result of a failed verification."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_FAILED_VERIFICATION

inherit

	E2B_VERIFICATION_RESULT
	SHARED_LOCALE
	FORMATTED_MESSAGE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize.
		do
			create errors.make
		end

feature -- Access

	errors: LINKED_LIST [E2B_VERIFICATION_ERROR]
			-- List of verification errors.

feature -- Display

	single_line_message (a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		local
			n: like errors.count
		do
			if errors.is_empty then
				a_formatter.add ("(no message found)")
			else
				errors.first.single_line_message (a_formatter)
				n := errors.count
				if n > 1 then
					format_elements
						(a_formatter,
						locale.plural_translation_in_context (" (+1 more error)", " (+{1} more errors)", "tool.autoproof.error", n - 1),
						<<agent {TEXT_FORMATTER}.add ((n - 1).out)>>)
				end
			end
		end

end
