indexing
	description: "Eiffelbuild button that has a callback when activated."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class EB_BUTTON_COM

inherit
	EB_BUTTON
		redefine
			make
		end

	EV_COMMAND

feature {NONE}

	make (par: EV_TOOL_BAR) is	
		require else
			valid_parent: par /= Void
		do
			Precursor (par)
			add_select_command (Current, Void)
		end

end -- class EB_BUTTON_COM

