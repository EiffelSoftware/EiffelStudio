
class SCALE_EVENTS 

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
			Result := Pixmaps.scale_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_scale_pixmap
		end;

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.scale_label)
		end;
	
feature {CATALOG}
    
    make_button_visible (button_rc: ROW_COLUMN) is
            -- call cat_make_button_visible and set focus string for the button
        do
            cat_make_button_visible (button_rc)
            button.set_focus_string (Focus_labels.scale_label)
        end

feature {NONE}

	make (cat: like associated_catalog) is
		do
			make_page (cat);
			extend (move_ev);
			extend (value_changed_ev)
			-- added by samik
	--		set_focus_string (Focus_labels.scale_label)
			-- end of samik	
		end

end -- class SCALE_EVENTS   
