indexing
	visual_name: "Quit"

class COMMAND2

inherit
	BUILD_NON_UNDOABLE_CMD

create 
	make

feature  -- Initialization

	make is
		do
		end

feature  -- Access

	quit_label: STRING is "quit"

feature  -- Command

	execute is
		do
			set_transition_label (quit_label)
		end

end -- class COMMAND2
