class RESET_FONT_CMD

inherit

	FONT_CMD
		redefine
			work
		end

feature

	work (argument: ANY) is
		local
			editor: CONTEXT_EDITOR
		do
			editor ?= argument;
			context ?= editor.edited_context;
			context_work;
			context.set_font_named ("");
			editor.reset_current_form
		end;

end
		
