
deferred class EDITOR_FORM 

inherit

	WIDGET_NAMES
		export
			{NONE} all
		end;
	EDITOR_NAMES
		export
			{NONE} all
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	FORM
		rename
			make as form_create
		end

feature 

	form_name: STRING is
			-- Name of the form in the menu
		do
			Result := S_pecific_attributes
		end;

	
feature {NONE}

	editor: CONTEXT_EDITOR;

	
feature 

	make_visible (an_editor: CONTEXT_EDITOR) is
		deferred
		end;

	is_initialized: BOOLEAN;

	
feature {NONE}

	initialize (a_name: STRING; a_parent: CONTEXT_EDITOR) is
			-- Creates the form
		local
			top_form: FORM;
		do
			editor := a_parent;
			form_create (a_name, a_parent.top_form);
			editor.attach_attributes_form (Current);
			is_initialized := true;
		end;

	context: CONTEXT;
	
feature 

	reset_form is
		do
			context := editor.edited_context;
			reset
		end;

	apply is
			-- update the context according to the content of the form
		deferred
		end;

	
feature {NONE}

	reset is
			-- reset the content of the form
		deferred
		end;

end
