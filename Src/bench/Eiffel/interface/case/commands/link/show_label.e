indexing

	description: 
		"Command representing the format that shows the % 
		%label page in a relation editor.";
	date: "$Date$";
	revision: "$Revision $"

class 
	SHOW_LABEL

inherit

	RELATION_WINDOW_FORMAT

creation

	make

feature -- Properties

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated, in unselected state.
		do
			Result := Pixmaps.label_pixmap
		end;

	selected_symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated, in selected (highlighted) state.
		do
			Result := Pixmaps.selected_label_pixmap
		end;

feature -- Execution
 
	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Process a click on the format button associated 
			-- to Current command: set Current format
		do
		--	if relation_window.entity /= Void and then
		--		relation_window.current_format /= Current 
		--	then
		--		relation_window.set_label_format
		--	end
		end;

end -- class SHOW_LABEL










