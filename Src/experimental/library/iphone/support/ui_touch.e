note
	description: "Wrapper around UITouch class."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_TOUCH

inherit
	NS_OBJECT

	UI_ROUTINES

create
	share_from_pointer

feature -- Access

	view: UI_VIEW
		local
			l_obj: POINTER
		do
			l_obj := c_view (item)
			check l_obj_not_null: l_obj /= default_pointer end
			if attached eiffel_object_from_c (l_obj) as l_view then
				Result := l_view
			else
					-- It is not an Eiffel UIView instance.
				create Result.share_from_pointer (l_obj)
			end
		end

	window: UI_WINDOW
		local
			l_obj: POINTER
		do
			l_obj := c_view (item)
			check l_obj_not_null: l_obj /= default_pointer end
			if attached {UI_WINDOW} eiffel_object_from_c (l_obj) as l_window then
				Result := l_window
			else
					-- It is not an Eiffel UIView instance.
				create Result.share_from_pointer (l_obj)
			end
		end

	location: CG_POINT
		local
		do
			create Result.make_empty
			c_location_in_view (item, window.item, Result.item)
		end

	tap_count: like ns_uinteger
		do
			Result := c_tap_count (item)
		end

	phase: NATURAL
		do
			Result := c_phase (item)
		end

feature -- Status report

	is_starting: BOOLEAN
			-- Is a touch starting?
		do
			Result := phase = phase_began
		end

	is_moving: BOOLEAN
			-- Is a touch moving?
		do
			Result := phase = phase_moved
		end

	is_stationary: BOOLEAN
			-- Is a touch still at the same place?
		do
			Result := phase = phase_stationary
		end

	is_ending: BOOLEAN
			-- Is a touch ending?
		do
			Result := phase = phase_ended
		end

	is_cancelling: BOOLEAN
			-- Is a touch cancelling?
		do
			Result := phase = phase_cancelled
		end

feature {NONE} -- Constants

 	phase_began: NATURAL = 0
 	phase_moved: NATURAL = 1
 	phase_stationary: NATURAL = 2
 	phase_ended: NATURAL = 3
 	phase_cancelled: NATURAL = 4

feature {NONE} -- Externals

	c_view (a_touch_ptr: POINTER): POINTER
		require
			a_touch_ptr_not_null: a_touch_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITouch *) $a_touch_ptr).view;"
		end

	c_window (a_touch_ptr: POINTER): POINTER
		require
			a_touch_ptr_not_null: a_touch_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITouch *) $a_touch_ptr).window;"
		end

	c_tap_count (a_touch_ptr: POINTER): like ns_uinteger
		require
			a_touch_ptr_not_null: a_touch_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITouch *) $a_touch_ptr).tapCount;"
		end

	c_phase (a_touch_ptr: POINTER): NATURAL
		require
			a_touch_ptr_not_null: a_touch_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITouch *) $a_touch_ptr).phase;"
		end

	c_location_in_view (a_touch_ptr, a_view_ptr, a_rect_ptr: POINTER)
		require
			a_touch_ptr_not_null: a_touch_ptr /= default_pointer
			a_view_ptr_not_null: a_view_ptr /= default_pointer
			a_rect_ptr_not_null: a_rect_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[
				CGPoint p = [(UITouch *) $a_touch_ptr locationInView:(UIView *) $a_view_ptr];
				memcpy($a_rect_ptr, &p, sizeof(CGPoint));
			]"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
