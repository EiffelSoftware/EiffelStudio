
deferred class CAT_PAGE [T -> DATA] 

inherit
	
	CONSTANTS;
	CATALOG_BOX [T]
		rename
			make_visible as box_make_visible,
			make_unmanaged as box_make_unman
		export
			{CAT_COM_IS,CATALOG, CMD_CAT_BUTTON} 
			hide, show, shown, manage, unmanage, 
			managed, associated_catalog
		end
	
feature {CATALOG}

	is_optional: BOOLEAN is
			-- Is Current page optional?
		do
		end;

	button: CAT_BUTTON;
			-- Button which represents the page

	focus_source: WIDGET is
		do
			Result := button
		end;

	make_visible (a_parent: COMPOSITE) is
		do
	
			box_make_visible (Widget_names.row_column, a_parent);
			set_column_layout;
			set_preferred_count (5);
		end;

	make_unmanaged (a_parent: COMPOSITE) is
		do
			box_make_unman (Widget_names.row_column, a_parent);
			set_column_layout;
			set_preferred_count (5);
		end;
feature {NONE} -- Focus label	
	
	Focus_labels: FOCUS_LABEL_CONSTANTS is
		once
			!! Result
		end
	
	focus_label: FOCUS_LABEL_I is
                	-- has to be redefined, so that it returns
                	-- correct toolkit initializer to which object
                	-- belongs for every instance of this class
                local
                        ti: TOOLTIP_INITIALIZER
                do
                       ti ?= top
                        check
                                valid_tooltip_initializer: ti/= void
                        end
                        Result := ti.label
                end
	
	set_focus_string is
		deferred
		end
	

feature {NONE}

	symbol: PIXMAP is
			-- Symbol which represents the page 
		deferred
		end;

	selected_symbol: PIXMAP is
		deferred
		end;
	
feature {CATALOG}

	make_button_visible (button_rc: ROW_COLUMN) is
			-- Make a button visible with `a_name' as the
			-- widget_name of button and `button_rc' as
			-- the parent. Also set the pixmap of button
			-- with symbol.
		require
			not_void_form: button_rc /= Void;
		do	
			!! button.make (Current, button_rc, symbol)
			set_focus_string
			button.initialize_focus	
		end;

	set_selected_symbol is
		do
			button.set_symbol (selected_symbol)
		end;

	set_symbol is
		do
			button.set_symbol (symbol)
		end;

feature

	select_it is
		do
			associated_catalog.update_page (Current);
		end;

end -- class CAT_PAGE 
