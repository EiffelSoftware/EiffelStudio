indexing

	description: 
		"Command that undoes the current element %
		%in the history window, if any.";
	date: "$Date$";
	revision: "$Revision $"

class 
	UNDO_HISTORY

inherit
	HISTORY_COM

feature -- Properties

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
		do
			Result := Pixmaps.undo_pixmap
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Redo the last command undone.
		do
			if history.index > 0 then
				history.back
			end
		end

end -- class UNDO_HISTORY
