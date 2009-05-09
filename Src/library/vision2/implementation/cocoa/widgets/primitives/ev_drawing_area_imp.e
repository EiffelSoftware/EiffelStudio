note
	description: "EiffelVision drawing area. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			make,
			initialize
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color,
			background_color,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			default_key_processing_blocked,
			initialize,
			set_focus
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			create view.new_custom (agent
				do
					image.draw_at_point_from_rect_operation_fraction (create {NS_POINT}.make_point (0, 0), create {NS_RECT}.make_rect (0, 0, 1000, 1000), {NS_IMAGE}.composite_source_over, 1)
				end)
			cocoa_item := view
		end

	initialize
			-- Initialize `Current'
		do
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_DRAWABLE_IMP}
			initialize_events
		end


feature -- Status setting

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN
			-- Should default key processing be allowed for `a_key'.
		do
		end

	redraw
			-- Redraw the entire area.
		do
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Redraw the rectangle area defined by `a_x', `a_y', `a_width', a_height'.
		do
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
		end

	update_if_needed
			-- Update `Current' if needed.
		do
			view.set_needs_display (True)
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	lose_focus
			-- Current has lost keyboard focus.
		do
		end

	set_focus
			-- Grab keyboard focus.
		do
		end

feature {EV_ANY_I} -- Implementation

	view: NS_VIEW

	interface: EV_DRAWING_AREA;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_DRAWING_AREA_IMP
