indexing
	description:
		"EiffelVision window, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I
		
	EV_UNTITLED_WINDOW_IMP
		undefine
			set_default_colors,
			has_parent
		redefine
			make,
			make_with_owner
		end
	
create
	make,
	make_with_owner,
	make_root

feature {NONE} -- Initialization
	
	make is
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)

			-- set the events to be handled by the window
			c_gtk_widget_set_all_events (widget)

			initialize
		end

        make_with_owner (par: EV_WINDOW) is
			-- Create a window with `par' as parent.
			-- The life of the window will depend on
			-- the one of `par'.
		local
			par_imp: EV_WINDOW_IMP
		do
			par_imp ?= par.implementation

			-- Create the window
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)

			-- Attach the window to `par'.
			gtk_window_set_transient_for (widget, par_imp.widget)

			-- set the events to be handled by the window
			c_gtk_widget_set_all_events (widget)

			initialize
		end

feature  -- Access

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified
		do
			Result := "Sorry, not yet implemented."
		end

        icon_mask: EV_PIXMAP is
                        -- Bitmap that could be used by window manager
                        -- to clip `icon_pixmap' bitmap to make the
                        -- icon nonrectangular 
		do
			check
                                not_yet_implemented: False
                        end
                end

        icon_pixmap: EV_PIXMAP is
                        -- Bitmap that could be used by the window manager
                        -- as the application's icon
		do
			check
                                not_yet_implemented: False
                        end
		end
	
feature -- Status report

        is_iconic_state: BOOLEAN is
                        -- Does application start in iconic state?
		do
			check
                                not_yet_implemented: False
                        end
                end

 	is_minimized: BOOLEAN is
			-- Is the window minimized (iconic state)?
		do
			check
				not_yet_implemented: False
            		end	
		end

	is_maximized: BOOLEAN is
			-- Is the window maximized (take the all screen).
		do
			check
				not_yet_implemented: False
            		end	
		end

feature -- Status setting

	set_iconic_state is
                        -- Set start state of the application to be iconic.
		do
			check
				not_yet_implemented: False
            		end	
        	end

	set_normal_state is
                        -- Set start state of the application to be normal.
		do
			check
				not_yet_implemented: False
            		end
        	end

	set_maximize_state is
			-- Set start state of the application to be
			-- maximized.
		do
			check
				to_be_implemented: False
			end
		end

	raise is
			-- Raise a window. ie: put the window on the front
			-- of the screen.
		do
			gdk_window_raise (widget)
		end

	lower is
			-- Lower a window. ie: put the window on the back
			-- of the screen.
		do
			gdk_window_lower (widget)
		end

	minimize is
			-- Minimize the window.
		do
			check
				to_be_implemented: False
			end
		end

	maximize is
			-- Minimize the window.
		do
			check
				to_be_implemented: False
			end
		end

	restore is
			-- Restore the window when it is minimized or
			-- maximized. Do nothing otherwise.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Element change

        set_icon_name (new_name: STRING) is
                        -- Set `icon_name' to `new_name'.
		local
			temp_name: ANY
		do
			temp_name := new_name.to_c
			gdk_window_set_icon_name(widget, $new_name)
                end

        set_icon_mask (mask: EV_PIXMAP) is
                        -- Set `icon_mask' to `mask'.
		do
			--gtk_pixmap_get
                end

        set_icon_pixmap (pixmap: EV_PIXMAP) is
                        -- Set `icon_pixmap' to `pixmap'.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= pixmap.implementation
			gtk_pixmap_get (pixmap_imp.widget, $gdkpix, $gdkmask)
			gdk_window_set_icon (widget, pixmap_imp.create_window, pixmap_imp.gdk_pixmap_widget, gdkmask)
                end

	gdkpix, gdkmask : POINTER

feature -- External

	gtk_pixmap_get (gtk_pixmap, gdk_pixmap, gdk_bitmap: POINTER) is
		external
			"C (GtkPixmap *, GdkPixmap *, GdkBitmap *) | <gtk/gtk.h>"
		end

	gdk_window_set_icon (window, icon_window, pixmap, mask: POINTER) is
		external
			"C (GdkWindow *, GdkWindow *, GdkPixmap *, GdkBitmap *) | <gdk/gdk.h>"
		end

	gdk_window_raise (window: POINTER) is
		external
			"C (GdkWindow *) | <gdk/gdk.h>"
		end

	gdk_window_lower (window: POINTER) is
		external
			"C (GdkWindow *) | <gdk/gdk.h>"
		end

end -- class EV_WINDOW_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
