
class DRAWING_EVENTS 

inherit
	
    EVENT_PAGE
        rename
            make as page_make
        redefine
            is_optional,
            make_button_visible
        select
            make_button_visible
        end;

    EVENT_PAGE 
        rename
            make as page_make,
            make_button_visible as cat_make_button_visible
        redefine
            is_optional
		end;

creation

	make
	
feature {CATALOG}

	is_optional: BOOLEAN is True;
	
feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.drawing_area_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_drawing_area_pixmap
		end;

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.drawing_label)
		end;

feature {CATALOG}
    
    make_button_visible (button_rc: ROW_COLUMN) is
            -- call cat_make_button_visible and set focus string for the button
        do
            cat_make_button_visible (button_rc)
            button.set_focus_string (Focus_labels.drawing_label)
        end

feature {NONE}

	make (cat: like associated_catalog) is
		do
			page_make (cat);
			extend (expose_ev);
			extend (input_ev);
			extend (resize_ev);
			-- added by samik
	--		set_focus_string (Focus_labels.drawing_label)
			-- end of samik	
		end

end -- class TEXT_EVENTS   
