indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class WM_SHELL_M

inherit

	WM_SHELL_I;

	MEL_WM_SHELL
		rename
			icon_mask as mel_icon_mask,	
			set_icon_mask as mel_set_icon_mask,
			icon_pixmap as mel_icon_pixmap,
			set_icon_pixmap as mel_set_icon_pixmap,
            background_color as mel_background_color,
            background_pixmap as mel_background_pixmap,
            set_background_color as mel_set_background_color,
            set_background_pixmap as mel_set_background_pixmap,
            destroy as mel_destroy,
			screen as mel_screen
		end

feature -- Access

	widget_group: WIDGET

	icon_mask: PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
		end;

	icon_pixmap: PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
        local
            ext_name: ANY;
            pixmap_x: PIXMAP_X
        do
            if private_icon_pixmap = Void then
                !! private_icon_pixmap.make;
                pixmap_x ?= private_icon_pixmap.implementation;
                --ext_name := MiconPixmap.to_c;
                pixmap_x.set_default_pixmap (m_wm_c_get_pixmap 
						(screen_object, $ext_name));
            end;
            Result := private_icon_pixmap
		end

feature -- Status Setting

	set_widget_group (a_widget: WIDGET) is
			-- Set `widget_group' to `a_widget'.
		do
		end;

	set_icon_mask (a_mask: PIXMAP) is
			-- Set `icon_mask' to `a_mask'.
		do
		end;

	set_icon_pixmap (a_pixmap: PIXMAP) is
			-- Set `icon_pixmap' to `a_pixmap'.
		require else
			not_a_pixmap_void: not (a_pixmap = Void);

		local
			pixmap_implementation: PIXMAP_X;
			ext_name: ANY;
			c_bitmap: POINTER;
		do
			if private_icon_pixmap /= Void then
				pixmap_implementation ?= private_icon_pixmap.implementation;
				pixmap_implementation.remove_object (Current)
			end;
			private_icon_pixmap := a_pixmap;
			pixmap_implementation ?= private_icon_pixmap.implementation;
			c_bitmap := pixmap_implementation.resource_bitmap (screen);
			pixmap_implementation.put_object (Current);
			--ext_name := MiconPixmap.to_c;
			m_wm_set_pixmap (screen_object, c_bitmap, $ext_name)
		end;

feature {NONE} -- Implementation

	private_icon_pixmap: PIXMAP;
			-- Icon pixmap for Current Shell

	screen: SCREEN_I is
			-- Widget screen
		deferred
		ensure
			valid_screen: Result /= Void;
		end;

	update_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			ext_name: ANY;
			pixmap_implementation: PIXMAP_X
		do
			--ext_name := MiconPixmap.to_c;
			pixmap_implementation ?= icon_pixmap.implementation;
			m_wm_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
		end

feature {NONE} -- External features

	m_wm_shell_set_int (scr_obj: POINTER; value: INTEGER; n: POINTER) is
		external
			"C"
		alias
			"set_int"
		end;

    m_wm_c_get_pixmap (scr_obj: POINTER; n: POINTER): POINTER is
        external
            "C"
        alias
            "ev_get_pixmap"
        end;

	m_wm_shell_get_string (scr_obj: POINTER; n: POINTER): STRING is
		external
			"C"
		alias
			"get_string"
		end;

	m_wm_shell_set_string (scr_obj: POINTER; name1, name2: POINTER) is
		external
			"C"
		alias
			"set_string"
		end;

	m_wm_shell_get_int (scr_obj: POINTER; n: POINTER): INTEGER is
		external
			"C"
		alias
			"get_int"
		end;

	m_wm_set_pixmap (scr_obj, pix: POINTER; resource: POINTER) is
		external
			"C"
		alias
			"ev_set_pixmap"
		end; 

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
