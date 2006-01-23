indexing
	description: "Eiffel Vision popup window. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			frame_width, border_width,
			initialize
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
		
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_WINDOW_IMP}
			user_can_resize := False
			internal_is_border_enabled := False
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
			if user_can_resize then
				mw := mw + 2 * window_frame_width
			elseif is_border_enabled then
				mw := mw + 2 * dialog_window_frame_height
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
			if user_can_resize then
				mh := mh + 2 * window_frame_width
			elseif is_border_enabled then
				mh := mh + 2 * dialog_window_frame_height
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
			if user_can_resize then
				mw := mw + 2 * window_frame_width
				mh := mh + 2 * window_frame_width
			elseif is_border_enabled then
				mw := mw + 2 * dialog_window_frame_height
				mh := mh + 2 * dialog_window_frame_height
			end
			ev_set_minimum_size (mw, mh)
		end
		
	frame_width: INTEGER is 0
			-- `Result' is frame width of `Current'.
	
	border_width: INTEGER is 0
			-- `Result' is border width of `Current'.
	
feature  -- Implementation

	interface: EV_POPUP_WINDOW;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_WINDOW_IMP

