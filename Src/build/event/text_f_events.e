
class TEXT_F_EVENTS 

inherit
	
    EVENT_PAGE
        rename
            make as make_page
        redefine
            is_optional,
            make_button_visible
        select
            make_button_visible
        end;

    EVENT_PAGE 
        rename
            make as make_page,
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
			Result := Pixmaps.text_field_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_text_field_pixmap
		end;

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.text_field_label)
		end;

feature {CATALOG}
    
    make_button_visible (button_rc: ROW_COLUMN) is
            -- call cat_make_button_visible and set focus string for the button
        do
            cat_make_button_visible (button_rc)
            button.set_focus_string (Focus_labels.text_field_label)
        end

feature {NONE} --samik, this was CATALOG

	make (cat: like associated_catalog) is
		do
			make_page (cat);
			extend (key_return_ev);
			-- added by samik
			--button.set_focus_string (Focus_labels.text_field_label)
			-- end of samik
		end

end
