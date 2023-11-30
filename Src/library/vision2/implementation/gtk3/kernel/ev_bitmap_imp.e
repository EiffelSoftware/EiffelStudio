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
			interface
			--clear_rectangle
		end

	DISPOSABLE

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
		local
			l_app_imp: like app_implementation
		do
--			cairo_context := {GDK}.gdk_pixmap_new (default_pointer, 1, 1, 1)
--			gc := {GDK}.gdk_gc_new (cairo_context)
--			set_default_colors
--			init_default_values
			l_app_imp := app_implementation

			set_size (1, 1)
				-- Initialize the Graphical Context
			clear_rectangle (0, 0, 1, 1)

			set_is_initialized (True)
		end

feature -- Status Setting

	set_size (a_width, a_height: INTEGER)
			-- Set the size of the pixmap to `a_width' by `a_height'.
		do
			release_previous_cairo_surface
			cairo_surface := {CAIRO}.image_surface_create ({CAIRO}.format_argb32, a_width, a_height)
			get_new_cairo_context
			init_default_values
		end

--	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER)
--			-- Erase rectangle specified with `background_color'.
--		do
----			{GDK}.gdk_gc_set_foreground (gc, fg_color)
----			{GDK}.gdk_gc_set_background (gc, bg_color)

----			{GDK}.gdk_draw_rectangle (cairo_context, gc, 1, a_x, a_y, a_width, a_height)

----			set_default_colors
--		end

feature {EV_ANY_I} -- Drawing wrapper

	pre_drawing
		local
			cr: like cairo_context
		do
				-- If inside drawing session
				-- the cairo context is already created in `start_drawing_session`
			if not is_in_drawing_session then
					-- Reuse or get once a new cairo_context
				get_cairo_context
				cr := cairo_context
				if not cr.is_default_pointer then
					{CAIRO}.save (cr)
				end
			end
		end

	post_drawing
		local
			cr: like cairo_context
		do
				-- If inside drawing session
				-- keep the cairo context for the next draw operation, it will be releazed by `end_drawing_session`
			if not is_in_drawing_session then
				cr := cairo_context
				if not cr.is_default_pointer then
					{CAIRO}.restore (cr)
				end
			end
		end

feature {EV_ANY_I} -- cairo object access

	cairo_surface: POINTER
			-- Cairo drawable surface used for storing pixmap data in RGB format.

	get_cairo_context
		local
			cr: like cairo_context
			l_surface: like cairo_surface
		do
			cr := cairo_context
			if cr.is_default_pointer then
				l_surface := cairo_surface
				if not l_surface.is_default_pointer then
					cairo_context := {CAIRO}.create_context (l_surface)
				end
			end
		end

feature {EV_ANY_I} -- cairo object release

	release_cairo_surface (a_surface: POINTER)
		do
			if not a_surface.is_default_pointer then
				{CAIRO}.surface_destroy (a_surface)
			end
		end

	release_previous_cairo_surface
		do
			clear_cairo_context
			release_cairo_surface (cairo_surface)
			cairo_surface := default_pointer
		end

feature -- Access		

	width: INTEGER
			-- Width in pixels of mask bitmap.
		do
			if cairo_surface /= default_pointer then
				Result := {CAIRO}.image_surface_get_width (cairo_surface)
			end
		end

	height: INTEGER
			-- Width in pixels of mask bitmap.
		do
			if cairo_surface /= default_pointer then
				Result := {CAIRO}.image_surface_get_height (cairo_surface)
			end
		end

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
--			{GDK}.gdk_gc_set_foreground (gc, bg_color)
--			{GDK}.gdk_gc_set_background (gc, fg_color)
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

feature {EV_ANY_I} -- Cleaning		

	destroy
		do
			clear_cairo_context
			if not cairo_surface.is_default_pointer then
				release_cairo_surface (cairo_surface)
				cairo_surface := default_pointer
			end
			set_is_destroyed (True)
		end

	dispose
			-- Cleanup
		do
			if not cairo_context.is_default_pointer then
				{CAIRO}.destroy (cairo_context)
				cairo_context := default_pointer
			end
			if not cairo_surface.is_default_pointer then
				{CAIRO}.surface_destroy (cairo_surface)
				cairo_surface := default_pointer
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_BITMAP note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
