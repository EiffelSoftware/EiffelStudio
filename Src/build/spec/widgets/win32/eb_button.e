-- Eiffelbuild button that is focusable and has a symbol. 
deferred class EB_BUTTON

inherit

	FOCUSABLE
	CONSTANTS
	ACTIVE_PICT_COLOR_B
		rename
			make as pict_color_make,
			identifier as oui_identifier,
			init_toolkit as eb_button_init_toolkit
		end;

feature {NONE}

	Focus_labels: FOCUS_LABEL_CONSTANTS is
		once
			!! Result
		end
	
	focus_source: WIDGET is
		do
			Result := Current
		end;

	make_visible (a_parent: COMPOSITE) is	
		require
			valid_a_parent: a_parent /= Void
		do
			pict_color_make (Widget_names.pcbutton, a_parent);
			set_symbol (symbol);

			-- Default value for focus_string
			create_focus_label
			initialize_focus;
		end;

	symbol: PIXMAP is
		deferred
		end;

	set_symbol (s: PIXMAP) is
			-- Set icon symbol.
		require
			valid_argument: s /= Void
		do
			if s.is_valid then
				set_pixmap (s);
			end
		end;

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
		
	create_focus_label is
		deferred
		end

end
