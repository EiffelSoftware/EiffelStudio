indexing

	description: 
		"EiffelVision pixmap, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_PIXMAP_IMP
	
inherit
	EV_PIXMAP_I

	EV_DRAWABLE_IMP
		undefine
			background_color,
			foreground_color,
			set_background_color,
			set_foreground_color
		end

	EV_PRIMITIVE_IMP
		rename
			make as old_make
		export {NONE}
			set_parent,
			has_parent,
			parent_set
		redefine
			width,
			height
		end

	MEMORY
		redefine
			dispose
		end
	
creation
	make,
	make_with_size

feature {NONE} -- Initialization

	make is
                        -- Create a gtk pixmap with a temporary window
			-- as parent.
                local
			par_imp: EV_WIDGET_IMP
			p: ANY
			xpmFile: STRING
		do
			-- create the temporary window needed to create the pixmap
			creation_window := gtk_window_new (GTK_WINDOW_TOPLEVEL)

			-- create the pixmap
			-- Here we create the pixmap with a default xpm.
			widget := c_gtk_pixmap_create_empty (creation_window)

			-- setting status
			is_locked := False
	            end

	make_with_size (w, h: INTEGER) is
			-- Create a pixmap with 'par' as parent, 
			-- 'w' and `h' as size.
		do
			-- create the temporary window needed to create the pixmap
			creation_window := gtk_window_new (GTK_WINDOW_TOPLEVEL)

			-- create the gdk pixmap
			gdk_pixmap_widget := c_gtk_pixmap_create_with_size (creation_window, w, h)
		end	

feature -- Measurement

	width: INTEGER is
			-- width of the pixmap.
		do
			Result := c_gtk_pixmap_width (widget)
		end

	height: INTEGER is
			-- height of the pixmap.
		do
			Result := c_gtk_pixmap_height (widget)
		end

feature -- Element change

	read_from_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			-- If the file does not exist or it is in a 
			-- wrong format, an exception is raised.
		local
			a: ANY
		do
			a := file_name.to_c

			if widget = Void then
				widget := c_gtk_pixmap_create_from_xpm (creation_window, $a)
			else
				c_gtk_pixmap_read_from_xpm (widget, creation_window, $a)
			end

			-- The following is done only once.
			if (creation_window /= default_pointer) then
				-- Add a reference to the pixmap othewise it will be
				-- destroyed when we will destroy the `creation_window' below.
				gtk_object_ref (widget)

				-- Destroy the temporary window which
				-- was needed at the creation of the pixmap
				gtk_widget_destroy (creation_window)
				creation_window := Default_pointer
			end
		end	

feature -- Assertion

	is_locked: BOOLEAN
			-- Is the pixmap free and then can be added in a
			-- control?

feature {NONE} -- Implementation

	parent_widget: POINTER

feature {EV_PIXMAPABLE_IMP} -- Implementation

	creation_window: POINTER
			-- gtk window defined because to create the pixmap
			-- we need a realized widget.

	gdk_pixmap_widget: POINTER
			-- GDK pixmap pointer given when pixmap is created
			-- using `make_with_size'.
			-- This means we will use the pixmap in a drawing
			-- area.

feature {} -- Removal

	dispose is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			-- Default version does nothing; redefine in descendants
			-- to perform specific dispose actions. Those actions
			-- should only take care of freeing external resources;
			-- they should not perform remote calls on other objects
			-- since these may also be dead and reclaimed.
		do
			-- Destroy the gtkPixmap.
			gtk_widget_destroy (widget)
		end

feature {NONE} -- Inapplicable

	old_make is
		do
			check
				Inapplicable: False
			end
		end

end -- EV_PIXMAP_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
