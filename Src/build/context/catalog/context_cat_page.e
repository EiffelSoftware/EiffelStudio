
deferred class CONTEXT_CAT_PAGE 

inherit

	FORM
		rename
			make as make_visible,
			init_toolkit as form_init_toolkit
		end;
	CONSTANTS;
	WINDOWS
		select
			init_toolkit
		end
	FOCUSABLE
	
feature 

	symbol: PIXMAP is
		deferred
		end;

	selected_symbol: PIXMAP is
		deferred
		end;

    Focus_labels: FOCUS_LABEL_CONSTANTS is
        once
            !! Result
        end
    
	focus_label: FOCUS_LABEL_I is
			-- has to be redefined, so that it returns correct toolkit initializer
			-- to which object belongs for every instance of this class
                local
                        ti: TOOLTIP_INITIALIZER
                do
                        ti ?= top
                        check
                                valid_tooltip_initializer: ti/= void
                        end
                        Result := ti.label
                end

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
			set_background_color (Resources.catalog_background_color)
			set_foreground_color (Resources.catalog_foreground_color)
			
			build_interface
			-- build_interface sets the focus string for the button so 
			-- that call button.initialize_focus is legal
			button.initialize_focus
		end;

	create_type (a_name: STRING; 
			a_context: CONTEXT; 
			a_pixmap: PIXMAP): CONTEXT_TYPE is
		local
--			a_button: PICT_COLOR_B;
			a_button: CONTEXT_TYPE_BUTTON
		do
			!!a_button.make (a_context.eiffel_type, Current);
			a_button.set_pixmap (a_pixmap);
			a_button.set_focus_string (a_context.full_type_name)
			!!Result.make (a_name, a_context);
			Result.initialize_callbacks (a_button);
		end;

	build_interface is
			-- Build the interface
		deferred
		end;

end
