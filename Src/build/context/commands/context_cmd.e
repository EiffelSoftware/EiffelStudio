indexing
	description: "General notion of a command on a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class CONTEXT_CMD 

inherit
	EB_UNDOABLE_COMMAND

	CONSTANTS

feature {NONE} -- Initialization

	make (ctxt: CONTEXT) is
		do
			context ?= ctxt
		end

feature -- Access

	context: CONTEXT

	associated_form: INTEGER is
		deferred
		end

	comment: STRING is
		do
			Result := context.label
		end

feature -- Command

 	failed: BOOLEAN 

	execute (arg: EV_ARGUMENT1 [CONTEXT_EDITOR]; ev_data: EV_EVENT_DATA) is
			-- Do not update the history.
		require else
			valid_editor: arg.first /= Void
		do
			context ?= arg.first.edited_context
			check
				valid_context: context /= Void
			end
			work
			arg.first.apply_form (associated_form)
		end

feature {NONE} -- Implementation

	work is
			-- Do not record into history.
		deferred
		end

	undo is
		local
			editor: CONTEXT_EDITOR
		do
			editor := context_catalog.editor (context)
			if editor /= Void then
				editor.reset_form (associated_form)
			end
		end

	redo is
		do
			undo
		end

end -- class CONTEXT_CMD

