
deferred class CONTEXT_CAT_PAGE 

inherit

	FORM
		rename
			make as make_visible
		end;
	CONSTANTS;
	WINDOWS;
	FOCUSABLE
	
feature 

	focus_label: FOCUS_LABEL is
		do
			Result := context_catalog.focus_label
		end;

	symbol: PIXMAP is
		deferred
		end;

	selected_symbol: PIXMAP is
		deferred
		end;

	focus_string: STRING is
		deferred
		end;

	focus_source: WIDGET is
		do
			Result := button
		end;

	button: CON_CAT_BUTTON

feature {NONE}

	make (a_parent: COMPOSITE; button_parent: ROW_COLUMN) is
		do
			make_visible (Widget_names.form, a_parent);
			!! button.make (Current, button_parent);
			build_interface
		end;

	create_type (a_name: STRING; 
			a_context: CONTEXT; 
			a_pixmap: PIXMAP): CONTEXT_TYPE is
		local
			a_button: PICT_COLOR_B;
		do
			!!a_button.make (a_context.eiffel_type, Current);
			a_button.set_pixmap (a_pixmap);
			!!Result.make (a_name, a_context);
			Result.initialize_callbacks (a_button);
		end;

	build_interface is
			-- Build the interface
		deferred
		end;

end
