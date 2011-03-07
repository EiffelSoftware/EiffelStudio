note
	description: "Summary description for {EV_EXECUTION_VERB_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_EXECUTION_VERB_CONSTANTS

feature -- Enumeration

	ui_executionverb_execute: INTEGER = 0
			-- UI_EXECUTIONVERB_EXECUTE

	ui_executionverb_preview: INTEGER = 1
			-- UI_EXECUTIONVERB_EXECUTE

	ui_executionverb_cancelpreview: INTEGER = 2
			-- UI_EXECUTIONVERB_CANCELPREVIEW

feature -- Query

	is_valid (a_int: INTEGER): BOOLEAN
			-- If `a_int' valid ?
		do
			if a_int = ui_executionverb_execute or else
				a_int = ui_executionverb_preview or else
				a_int = ui_executionverb_cancelpreview then
				Result := True
			end
		end
end
