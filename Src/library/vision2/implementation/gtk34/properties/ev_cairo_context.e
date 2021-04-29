note
	description: "Summary description for {EV_CAIRO_CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CAIRO_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_window: POINTER)
			-- Create a cairo context and call gdk_window_begin_draw_frame.
		do
			window := a_window
			cr := {GDK_CAIRO}.cairo_region_create
				-- Check if the current window `a_window`
				-- already has a drawing context.
			draw_ctx := {GDK}.gdk_window_begin_draw_frame  (window, cr)
			drawable := {GDK_CAIRO}.gdk_drawing_context_get_cairo_context (draw_ctx)
		end



feature -- Access

	drawable: POINTER
			-- Pointer to the current Cairo context for `Current'.

    cr: POINTER
    		-- Pointer to the current Cairo region for `Cairo`.

    draw_ctx: POINTER
    		-- Pointer to the current frame to draw.		

    window: POINTER
    		-- Pointer to the widget window.		

feature -- End Drawing

	is_valid_context: BOOLEAN
		do
			Result := {GDK}.gdk_drawing_context_is_valid (draw_ctx)
		end

	end_draw_frame
		do
			{GDK}.gdk_window_end_draw_frame (window, draw_ctx)
		end

	clear
		do
			if {CAIRO}.get_reference_count (cr) > 0 then
				{GDK_CAIRO}.cairo_region_destroy (cr)
			end
		end

;note
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
