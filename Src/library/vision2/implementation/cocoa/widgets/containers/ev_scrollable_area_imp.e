note
	description: "Eiffel Vision scrollable area. Cocoa implementation."
	author:	"Daniel Furrer"
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
			make,
			replace,
			ev_apply_new_size
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create scroll_view.make_with_flipped_content_view
			scroll_view.set_has_horizontal_scroller (True)
			scroll_view.set_has_vertical_scroller (True)
--			scroll_view.set_autohides_scrollers (True)
			scroll_view.set_draws_background (False)
			cocoa_view := scroll_view

			set_horizontal_step (10)
			set_vertical_step (10)
			initialize
			set_is_initialized (True)
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

	replace (v: like item)
			-- Replace `item' with `v'.
		do
			if attached item_imp as l_item_imp then
				l_item_imp.set_parent_imp (Void)
				notify_change (Nc_minsize, Current)
			end
			if attached v and then attached {like item_imp} v.implementation as v_imp then
				v_imp.set_parent_imp (current)
				scroll_view.set_document_view (v_imp.attached_view)
				v_imp.ev_apply_new_size (0, 0, v_imp.width, v_imp.height, True)
				v_imp.set_parent_imp (Current)
				notify_change (Nc_minsize, Current)
			end
			item := v
			ev_apply_new_size (x_position, y_position, width, height, False)
		end

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

feature {NONE} -- Implementation

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if attached item_imp as l_item_imp then
				scroll_view.set_document_view (l_item_imp.attached_view)
				l_item_imp.ev_apply_new_size (0, 0, l_item_imp.width, l_item_imp.height, True)
			end
		end


feature {EV_ANY, EV_ANY_I} -- Implementation		

	interface: detachable EV_SCROLLABLE_AREA note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_SCROLLABLE_AREA_IMP
