indexing
	visual_name: "Back"

class COMMAND4

inherit
	BUILD_NON_UNDOABLE_CMD;
	SHARED

creation 
	make

feature  -- Initialization

	make (arg1: SCROLLED_T) is
		do
			argument1 := arg1
		end

feature  -- Access

	argument1: SCROLLED_T

	back_label: STRING is "back"

feature  -- Command

	execute is
			-- Restore saved text and prepare to switch back
			-- to earlier state.
		do
			argument1.set_text (saved_text)
			argument1.set_editable
			set_transition_label (back_label)
		end

end -- class COMMAND4
