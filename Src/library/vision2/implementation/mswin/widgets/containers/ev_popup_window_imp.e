indexing
	description: "Eiffel Vision popup window. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_WINDOW_IMP

inherit
	EV_WINDOW_IMP
		redefine
			interface,
			default_style,
			compute_minimum_size,
			compute_minimum_height,
			compute_minimum_width,
			make,
			frame_width, border_width
		end

	EV_POPUP_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			make_child (application_imp.silly_main_window, "")
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style of `Current'.
			-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_popup + Ws_overlapped + Ws_clipchildren + Ws_clipsiblings
		end
		
	compute_minimum_width is
			-- Recompute the minimum width of `Current'.
		local
			mw: INTEGER
		do
			if item /= Void then
				mw := item.minimum_width
			end
			ev_set_minimum_width (mw)
		end

	compute_minimum_height is
			-- Recompute the minimum height of `Current'.
		local
			mh: INTEGER
		do
			if item /= Void then
				mh := item.minimum_height
			end
			ev_set_minimum_height (mh)
		end

	compute_minimum_size is
			-- Recompute the minimum size of `Current'.
		local
			mw, mh: INTEGER
		do
			if item /= Void then
				mw := item.minimum_width
				mh := item.minimum_height
			end
			ev_set_minimum_size (mw, mh)
		end
		
	frame_width: INTEGER is 0
			-- `Result' is frame width of `Current'.
	
	border_width: INTEGER is 0
			-- `Result' is border width of `Current'.
	
feature  -- Implementation

	interface: EV_POPUP_WINDOW

end -- class EV_WINDOW_IMP

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

