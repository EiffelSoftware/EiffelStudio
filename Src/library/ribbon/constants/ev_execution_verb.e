note
	description: "Summary description for {EV_EXECUTION_VERB}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_EXECUTION_VERB

feature -- Enumeration

	execute: INTEGER = 0
			-- UI_EXECUTIONVERB_EXECUTE

	preview: INTEGER = 1
			-- UI_EXECUTIONVERB_EXECUTE

	cancel_preview: INTEGER = 2
			-- UI_EXECUTIONVERB_CANCELPREVIEW

feature -- Query

	is_valid (a_int: INTEGER): BOOLEAN
			-- If `a_int' valid ?
		do
			if a_int = execute or else
				a_int = preview or else
				a_int = cancel_preview then
				Result := True
			end
		end
end
