indexing
	description:
		"MESSAGE_DIALOG_COMMAND, launch a message dialog.%
		% Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_DIALOG_COMMAND

inherit
	EV_COMMAND

feature -- Command execution

	execute (arg: EV_ARGUMENT1[EV_WINDOW]; data: EV_EVENT_DATA) is
		local
			dialog: EV_INFORMATION_DIALOG
		do
			create dialog.make_default(arg.first, "Info box", "This is some information!")
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


end -- class MESSAGE_DIALOG_COMMAND

