
class GENERAL_EVENTS 

inherit
	
    EVENT_PAGE
        rename
            make as page_make
        redefine
            make_button_visible
        select
            make_button_visible
        end;

    EVENT_PAGE 
        rename
            make as page_make,
            make_button_visible as cat_make_button_visible
        end;

creation

	make
	
feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.general_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_general_pixmap
		end;

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.general_label)
		end;

	append_general_events is
		do
			extend (widget_destroy_ev);
			extend (mouse_enter_ev);
			extend (key_press_ev);
			extend (key_release_ev);
			extend (mouse_leave_ev);
			extend (pointer_motion_ev);
		end;
	
feature {CATALOG}
    
    make_button_visible (button_rc: ROW_COLUMN) is
            -- call cat_make_button_visible and set focus string for the button
        do
            cat_make_button_visible (button_rc)
            button.set_focus_string (Focus_labels.general_label)
        end

feature {NONE} --samik, this was CATALOG

	make (cat: like associated_catalog) is
		do
			page_make (cat);
			append_general_events;
			-- added by samik
	--		set_focus_string (Focus_labels.general_label)
			-- end of samik
		end

end -- class GENERAL_EVENTS   
