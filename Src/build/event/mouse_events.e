
class MOUSE_EVENTS 

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
			Result := Pixmaps.mouse_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_mouse_pixmap
		end;

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.mouse_label)
		end;

	append_mouse_events is
		do
			extend (mouse_motion1_ev);
			extend (mouse_motion2_ev);
			extend (mouse_motion3_ev);
			extend (mouse1u_ev);
			extend (mouse2u_ev);
			extend (mouse3u_ev);
			extend (mouse1d_ev);
			extend (mouse2d_ev);
			extend (mouse3d_ev);
		end;
	
feature {CATALOG}
    
    make_button_visible (button_rc: ROW_COLUMN) is
            -- call cat_make_button_visible and set focus string for the button
        do
            cat_make_button_visible (button_rc)
            button.set_focus_string (Focus_labels.mouse_label)
        end

feature {NONE}

	make (cat: like associated_catalog) is
		do
			page_make (cat);
			append_mouse_events
			-- added by samik
	--		set_focus_string (Focus_labels.mouse_label)
			-- end of samik
		end

end -- class MOUSE_EVENTS   
