indexing
	description: "Command used to set the default cursor shape on a window."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class

	SET_DEFAULT_CURSOR_SHAPE_CMD

inherit

	CURSORS

	COMMAND

feature -- Execution

	execute (arg: ANY) is
		local
			a_window_c: WINDOW_C
		do
			a_window_c ?= arg
			if a_window_c /= Void then
				a_window_c.widget.set_cursor (Cursors.Arrow_cursor)
			end
		end

end -- class SET_DEFAULT_CURSOR_SHAPE_CMD
