indexing
	description: "Form used to display context properties."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class EDITOR_FORM

inherit
	EV_VERTICAL_BOX
		rename
			make as initialize
		end

	CONSTANTS

feature {NONE} -- Initialization

	make (ed: CONTEXT_EDITOR) is
			-- Add Current to the notebook of `ed'.
		require
			valid_ed: ed /= Void
		do
			editor := ed
			initialize (Void)
		ensure
			editor_set: editor /= Void
		end

feature -- Access

	editor: CONTEXT_EDITOR
			-- Assocated context editor

	reset is
			-- Reset the content of the form
		require
			valid_context: context /= Void
		deferred
		end

	apply is
			-- Update the context according to 
			-- the content of the form
		require
			valid_context: context /= Void
		deferred
		end
	
	context: CONTEXT is
			-- Current context for form
		require
			valid_editor: editor /= Void
			valid_edited_context: editor.edited_context /= Void
		do
			Result := editor.edited_context
		ensure
			valid_context: Result /= Void
		end

end -- class EDITOR_FORM

