
deferred class CONTEXT_CAT_PAGE 

inherit

	FORM
		rename
			make as form_create
		undefine
			init_toolkit
		end;
	WINDOWS
		export
			{NONE} all
		end;
	CONTEXT_NAMES
		export
			{NONE} all
		end;
	COMMAND_ARGS
		export
			{NONE} all
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	FOCUSABLE
		rename
			focus_string as page_name,
			focus_source as button
		
		export
			{NONE} all
		end



	
feature 

	page_name: STRING;

	make (a_name: STRING; a_pixmap: PIXMAP) is
		local
			a_form: FORM;
		do
			a_form := context_catalog.top_form;
			form_create (a_name, a_form);

			!!button.make (a_name, a_form);
			button.set_pixmap (a_pixmap);
			button.add_activate_action (context_catalog, Current);
			initialize_focus;

			a_form.attach_top (button, 10);

			a_form.attach_top_widget (context_catalog.second_separator, Current, 10);
			a_form.attach_right (Current, 10);
			a_form.attach_left (Current, 10);
			a_form.attach_bottom (Current, 10);

			page_name := a_name;
			build;
		end;

	
feature {NONE}

	focus_label: LABEL is
		do
			Result := context_catalog.focus_label
		end;

	
feature 

	button: PICT_COLOR_B;

	
feature {NONE}

	create_type (a_name: STRING; a_context: CONTEXT; a_pixmap: PIXMAP): CONTEXT_TYPE is
		local
			a_button: PICT_COLOR_B;
		do
			!!a_button.make (a_context.eiffel_type, Current);
			a_button.set_pixmap (a_pixmap);
			!!Result.make (a_name, a_context);
			Result.initialize_callbacks (a_button);
		end;

	build is
		deferred
		end;

end
