note
	description: "Eiffel Vision scrollable area. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit
	EV_SCROLLABLE_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			set_item_width,
			set_item_height
		redefine
			interface
		end

	EV_VIEWPORT_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create scrollable area.
		do
			base_make (an_interface)

			create scroll_view.make_with_flipped_content_view
			scroll_view.set_has_horizontal_scroller (True)
			scroll_view.set_has_vertical_scroller (True)
--			scroll_view.set_autohides_scrollers (True)
			scroll_view.set_draws_background (False)
			cocoa_item := scroll_view

			set_horizontal_step (20)
			set_vertical_step (20)
		end

feature -- Access

	horizontal_step: INTEGER

	vertical_step: INTEGER

	is_horizontal_scroll_bar_visible: BOOLEAN
			-- Should horizontal scroll bar be displayed?
		do
			Result := scroll_view.has_horizontal_scroller
		end

	is_vertical_scroll_bar_visible: BOOLEAN
			-- Should vertical scroll bar be displayed?
		do
			Result := scroll_view.has_vertical_scroller
		end

feature -- Element change

	set_horizontal_step (a_step: INTEGER)
			-- Set `horizontal_step' to `a_step'.
		do
			horizontal_step := a_step
		end

	set_vertical_step (a_step: INTEGER)
			-- Set `vertical_step' to `a_step'.
		do
			vertical_step := a_step
		end

	show_horizontal_scroll_bar
			-- Display horizontal scroll bar.
		do
			scroll_view.set_has_horizontal_scroller (True)
		end

	hide_horizontal_scroll_bar
			-- Do not display horizontal scroll bar.
		do
			scroll_view.set_has_horizontal_scroller (False)
		end

	show_vertical_scroll_bar
			-- Display vertical scroll bar.
		do
			scroll_view.set_has_vertical_scroller (True)
		end

	hide_vertical_scroll_bar
			-- Do not display vertical scroll bar.
		do
			scroll_view.set_has_vertical_scroller (False)
		end

feature {EV_ANY_I} -- Implementation		

	interface: EV_SCROLLABLE_AREA;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_SCROLLABLE_AREA_IMP

