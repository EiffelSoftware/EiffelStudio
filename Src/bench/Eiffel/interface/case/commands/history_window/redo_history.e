indexing
	description: 
		"Command that redoes the current element %
		%in the history window, if any.";
	date: "$Date$";
	revision: "$Revision $"

class REDO_HISTORY

inherit
	HISTORY_COM

feature -- Properties 

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
		do
			Result := Pixmaps.redo_pixmap
		end;

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Redo the last command undone.
		do
			if history.count > 0 and then 
				history.index < history.count 
			then
				history.forth
			end
		end

end -- REDO_HISTORY
