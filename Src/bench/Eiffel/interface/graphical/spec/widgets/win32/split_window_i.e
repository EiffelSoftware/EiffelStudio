indexing

	description: 
		"Motif implementation of a split window.";
	date: "$Date$";
	revision: "$Revision $"

class SPLIT_WINDOW_I

inherit

	FORM_WINDOWS
		rename
			make as form_windows_make
		end

creation

	make

feature {NONE} -- Initialization

	make (a_window: SPLIT_WINDOW; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a frame.
		do
			!! private_attributes;
			parent ?= oui_parent.implementation;
			check
				parent_exists: parent /= Void
			end;
			initialize;
			managed := man
		end

end -- class SPLIT_WINDOW_I
