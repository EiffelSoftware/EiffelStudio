
class TEXT_EVENTS 

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
			Result := Pixmaps.text_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_text_pixmap
		end;

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Focus_labels.text_label
-- samik		end;

feature {CATALOG}
	
	make_button_visible (button_rc: ROW_COLUMN) is
            -- call cat_make_button_visible and set focus string for the button
    	do
			cat_make_button_visible (button_rc)
			button.set_focus_string (Focus_labels.text_label)
		end

feature {NONE}

	make (cat: like associated_catalog) is
		do
			make_page (cat);
			extend (text_modify_ev)
			extend (text_motion_ev)
			-- added by samik
		--	set_focus_string (Focus_labels.text_label)
		--	initialize_focus
			-- end of samik
		end

end
