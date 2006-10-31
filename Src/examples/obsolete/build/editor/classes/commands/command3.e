indexing
	visual_name: "Modify"

class COMMAND3

inherit
	BUILD_NON_UNDOABLE_CMD

create 
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


end -- class COMMAND3
