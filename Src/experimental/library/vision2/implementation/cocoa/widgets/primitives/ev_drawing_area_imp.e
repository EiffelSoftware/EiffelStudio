note
	description: "EiffelVision drawing area. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I
		redefine
			interface
		select
			copy
		end

	EV_DRAWABLE_IMP
		undefine
			old_make,
			is_flipped
		redefine
			interface,
			make,
			prepare_drawing,
			finish_drawing
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color_internal,
			background_color_internal,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			make,
			dispose
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

	NS_VIEW
		rename
			make as make_cocoa,
			make_custom as make_custom_cocoa,
			initialize as initialize_cocoa,
			copy as copy_cocoa
		redefine
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			Precursor {EV_DRAWABLE_IMP}
			make_custom_cocoa (agent cocoa_draw_rect)
			cocoa_view := current
			Precursor {EV_PRIMITIVE_IMP}
			initialize_events
			disable_tabable_from
		end


feature -- Status setting

	redraw
			-- Redraw the entire area.
		do
			set_needs_display (True)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Redraw the rectangle area defined by `a_x', `a_y', `a_width', a_height'.
		do
			set_needs_display_in_rect (create {NS_RECT}.make_rect (a_x, a_y, a_width, a_height))
		end

	clear_and_redraw
			-- Clear `Current' and redraw.
		do
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Clear the rectangle area defined by `a_x', `a_y', `a_width', `a_height' and then redraw it.
		do
		end

	flush
			-- Redraw the screen immediately.
		do
--			display
		end

	prepare_drawing
		local
			l_color: detachable EV_COLOR_IMP
			trans: NS_AFFINE_TRANSFORM
		do
			if not lock_focus_if_can_draw then
				image.lock_focus
				is_drawing_buffered := True
			else
				is_drawing_buffered := False
			end
				create trans.make
				trans.translate_by_xy (0.0, height)
				trans.scale_by_xy (1.0, -1.0)
				trans.concat
			l_color ?= foreground_color.implementation
			check l_color /= void end
			l_color.color.set
		end


	finish_drawing
		do
			if is_drawing_buffered then
				image.unlock_focus
			else
				unlock_focus
			end
			-- update the view
			update_if_needed
		end

feature {NONE} -- Implementation

	is_drawing_buffered: BOOLEAN

	update_if_needed
		do
			set_needs_display (True)
		end

	cocoa_draw_rect
			-- Draw callback
		local
			invalid_rect: NS_RECT
		do
			create invalid_rect.make_rect (0, 0, width, height)

--			image.draw (create {NS_POINT}.make_point (0, 0), create {NS_RECT}.make_rect (0, 0, 1000, 1000), {NS_IMAGE}.composite_source_over, 1.0)

			if expose_actions_internal /= Void then
				expose_actions_internal.call ([
					invalid_rect.origin.x,
					invalid_rect.origin.y,
					invalid_rect.size.width,
					invalid_rect.size.height
					])
			end
		end

feature {EV_ANY_I} -- Implementation

	dispose
		do
			Precursor {NS_VIEW}
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DRAWING_AREA note option: stable attribute end;

end -- class EV_DRAWING_AREA_IMP
