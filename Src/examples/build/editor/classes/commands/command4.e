indexing
	visual_name: "Back"

class COMMAND4

inherit
	BUILD_NON_UNDOABLE_CMD;
	SHARED

create 
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class COMMAND4
