indexing

	description: "Abstract command related to editor windows.";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	EC_EDITOR_WINDOW_COM

inherit
	EV_COMMAND

	CONSTANTS

feature -- Properties

	editor_window: EC_EDITOR_WINDOW [ANY]
			-- Associated editor window
			--| To be redefined with the exact type in heirs

feature {NONE} -- Implementation

	make (ed: like editor_window) is
			-- Create Current command and editor window `ed'.
		require
			valid_ed: ed /= Void
		do
			editor_window := ed
		ensure
			editor_window_set: editor_window = ed
		end

invariant
	editor_window_exists: editor_window /= Void

end -- class EDITOR_WINDOW_COM
