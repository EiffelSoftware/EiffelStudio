indexing

	description:
		"Abstract notion of a source for the local focus area.";
	date: "$Date$";
	revision: "$Revision$"

deferred class EB_FOCUSABLE  

feature -- Initialization

	initialize_focus (new_parent: COMPOSITE) is
			-- Add the focusable behavior to Current.
		require
			valid_focus_string: valid_focus_string
		do
			focus_parent := new_parent;
			focus_label.initialize_widget (Current);
		end;

feature -- Properties

	focus_source: WIDGET is
			-- Widget representing
			-- Current on the screen
		deferred
		end;	

	focus_string: STRING is
			-- String to be associated
			-- with Current when it is
			-- in focus
		deferred
		end;

feature -- Access

	valid_focus_string: BOOLEAN is
		do
			Result := focus_string /= Void	
		end;

feature {NONE} -- Implementation

	focus_label: FOCUS_LABEL_I is
			-- Label onto which the focus
			-- string of Current is to be 
			-- displayed
		once	
			!FOCUS_LABEL! Result.initialize (focus_parent)
		end;

	focus_parent: COMPOSITE
			-- Parent for `focus_label'

end -- class EB_FOCUSABLE
