indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BITMAP_IMP

inherit
	EV_BITMAP_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			clear_rectangle
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
		end

	initialize is
			-- Set up action sequence connections and create graphics context.
		do
			drawable := {EV_GTK_EXTERNALS}.gdk_pixmap_new (default_pointer, 1, 1, 1)
			gc := {EV_GTK_EXTERNALS}.gdk_gc_new (drawable)
			set_default_colors
			init_default_values
			set_is_initialized (True)
		end

feature -- Status Setting

	set_size (a_width, a_height: INTEGER) is
			-- Set the size of the pixmap to `a_width' by `a_height'.
		local
			oldpix: POINTER
			l_width, l_height: INTEGER
			pixgc: POINTER
		do
			if drawable /= default_pointer then
				oldpix := {EV_GTK_EXTERNALS}.gdk_pixmap_ref (drawable)
				l_width := width
				l_height := height
			end

			drawable := {EV_GTK_EXTERNALS}.gdk_pixmap_new (oldpix, a_width, a_height, 1)
			clear

			if oldpix /= default_pointer then
				{EV_GTK_DEPENDENT_EXTERNALS}.gdk_draw_drawable (drawable, gc, oldpix, 0, 0, 0, 0, l_width, l_height)
			end
		end

	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Erase rectangle specified with `background_color'.
		do
			{EV_GTK_EXTERNALS}.gdk_gc_set_foreground (gc, app_implementation.fg_color)
			{EV_GTK_EXTERNALS}.gdk_gc_set_background (gc, app_implementation.bg_color)

			{EV_GTK_EXTERNALS}.gdk_draw_rectangle (drawable, gc, 1, a_x, a_y, a_width, a_height)

			set_default_colors
		end

feature -- Access

	width: INTEGER is
		-- Width in pixels of mask bitmap.
		local
			a_y: INTEGER
		do
			if drawable /= default_pointer then
				{EV_GTK_DEPENDENT_EXTERNALS}.gdk_drawable_get_size (drawable, $Result, $a_y)
			end
		end

	height: INTEGER is
		-- Width in pixels of mask bitmap.
		local
			a_x: INTEGER
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gdk_drawable_get_size (drawable, $a_x, $Result)
		end

feature {EV_PIXMAP_IMP} -- Implementation

	drawable: POINTER
		-- Pointer to the GdkPixmap objects used for `Current'.

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP is
			-- Access to application object implementation.
		local
			env: EV_ENVIRONMENT
		once
			create env
			Result ?= env.application.implementation
			check
				result_not_void: Result /= Void
			end
		end

	redraw is
			-- Redraw the entire area.
		do
			-- Not needed for masking implementation.
		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
			{EV_GTK_EXTERNALS}.gdk_gc_set_foreground (gc, app_implementation.bg_color)
			{EV_GTK_EXTERNALS}.gdk_gc_set_background (gc, app_implementation.fg_color)
		end

	destroy is
		do
			if drawable /= default_pointer then
				{EV_GTK_EXTERNALS}.object_unref (drawable)
				drawable := default_pointer
			end
			set_is_destroyed (True)
		end

	dispose is
			-- Cleanup
		do
			if drawable /= default_pointer then
				{EV_GTK_EXTERNALS}.object_unref (drawable)
			end
		end

	flush is
			-- Force all queued draw to be called.
		do
		end

	update_if_needed is
			-- Update `Current' if needed.
		do
		end

	mask: POINTER is
		do
			-- Not applicable
		end

	interface: EV_BITMAP

end -- class EV_SCREEN_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
