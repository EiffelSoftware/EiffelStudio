note
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

	old_make (an_interface: attached like interface)
			-- Create an empty drawing area.
		do
			assign_interface (an_interface)
		end

	make
			-- Set up action sequence connections and create graphics context.
		do
			drawable := {GTK}.gdk_pixmap_new (default_pointer, 1, 1, 1)
			gc := {GTK}.gdk_gc_new (drawable)
			set_default_colors
			init_default_values
			set_is_initialized (True)
		end

feature -- Status Setting

	set_size (a_width, a_height: INTEGER)
			-- Set the size of the pixmap to `a_width' by `a_height'.
		local
			oldpix: POINTER
			l_width, l_height: INTEGER
		do
			if drawable /= default_pointer then
				oldpix := drawable
				l_width := width
				l_height := height
			end

			drawable := {GTK}.gdk_pixmap_new (default_pointer, a_width, a_height, 1)
			clear_rectangle (0, 0, a_width, a_height)

			if oldpix /= default_pointer then
				{GTK}.gdk_draw_pixmap (drawable, gc, oldpix, 0, 0, 0, 0, l_width, l_height)
				{GTK}.gdk_bitmap_unref (oldpix)
			end
		end

	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Erase rectangle specified with `background_color'.
		do
			{GTK}.gdk_gc_set_foreground (gc, fg_color)
			{GTK}.gdk_gc_set_background (gc, bg_color)

			{GTK}.gdk_draw_rectangle (drawable, gc, 1, a_x, a_y, a_width, a_height)

			set_default_colors
		end

feature -- Access

	width: INTEGER
		-- Width in pixels of mask bitmap.
		local
			a_y: INTEGER
		do
			if drawable /= default_pointer then
				{GTK}.gdk_window_get_size (drawable, $Result, $a_y)
			end
		end

	height: INTEGER
		-- Width in pixels of mask bitmap.
		local
			a_x: INTEGER
		do
			if drawable /= default_pointer then
				{GTK}.gdk_window_get_size (drawable, $a_x, $Result)
			end
		end

feature {EV_PIXMAP_IMP} -- Implementation

	drawable: POINTER
		-- Pointer to the GdkPixmap objects used for `Current'.

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP
			-- Access to application object implementation.
		local
			env: EV_ENVIRONMENT
			l_result: detachable EV_APPLICATION_IMP
		once
			create env
			l_result ?= env.implementation.application_i
			check l_result /= Void then end
			Result := l_result
		end

	redraw
			-- Redraw the entire area.
		do
			-- Not needed for masking implementation.
		end

	set_default_colors
			-- Set foreground and background color to their default values.
		do
			{GTK}.gdk_gc_set_foreground (gc, bg_color)
			{GTK}.gdk_gc_set_background (gc, fg_color)
		end

	destroy
		do
			if drawable /= default_pointer then
				{GTK}.gdk_bitmap_unref (drawable)
				drawable := default_pointer
			end
			set_is_destroyed (True)
		end

	dispose
			-- Cleanup
		do
			if drawable /= default_pointer then
				{GTK}.gdk_bitmap_unref (drawable)
			end
		end

	flush
			-- Force all queued draw to be called.
		do
		end

	update_if_needed
			-- Update `Current' if needed.
		do
		end

	mask: POINTER
		do
			-- Not applicable
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_BITMAP note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_SCREEN_IMP
