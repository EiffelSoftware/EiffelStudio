-- Procedure text for class BACK
-- (See ``Guided Tour'' of EiffelBuild manual.)

execute is
		-- Restore saved text and prepare to switch back
		-- to earlier state.
	do
		argument1.set_text (saved_text)
		argument1.set_editable
		set_transition_label (back_label)
	end
