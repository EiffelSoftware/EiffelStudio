indexing
	visual_name: "Modify"

class COMMAND3

inherit
	BUILD_NON_UNDOABLE_CMD

creation 
	make

feature  -- Initialization

	make is
		do
		end

feature  -- Access

	modify_label: STRING is "modify"

feature  -- Command

	execute is
		do
			set_transition_label (modify_label)
		end

end -- class COMMAND3
