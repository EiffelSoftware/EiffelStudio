indexing
	description: "EiffelVision window. Display a window that allows only one%
		 	% child. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I

	EV_UNTITLED_WINDOW_IMP
		redefine
			make,
			make_with_owner,
			default_style
		end

creation
	make,
	make_with_owner,
	make_root

feature {NONE} -- Initialization

	make is
			-- Create a window. Window does not have any
			-- parents
		do
			make_top ("EV_WINDOW")
		end

	make_with_owner (par: EV_WINDOW) is
			-- Create a window with a parent.
			-- For a window, we cannot set the parent after or it does a 
		local
			ww: WEL_FRAME_WINDOW
		do
			ww ?= par.implementation
			check
				valid_owner: ww /= Void
			end
			make_child (ww, "EV_WINDOW")
		end

feature  -- Access

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified
		do
			check
       	    		not_yet_implemented: False
	    		end
		end

	icon_mask: EV_PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
			check
				not_yet_implemented: False
			end
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Status report

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Status setting

	set_iconic_state is
			-- Set start state of the application to be iconic.
		do
			check
				not_yet_implemented: False
			end	
		end

	set_normal_state is
			-- Set start state of the application to be normal.
		do
			check
				not_yet_implemented: False
			end
		end

	set_maximize_state is
			-- Set start state of the application to be
			-- maximized.
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Element change

	set_icon_name (txt: STRING) is
			-- Make `txt' the new icon name.
		do
			check
				not_yet_implemented: False
			end
		end	

	set_icon_mask (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon mask.
		do
			check
				not_yet_implemented: False
			end
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon pixmap.
		do
			check
				not_yet_implemented: False
			end
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
		-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := {EV_UNTITLED_WINDOW_IMP} Precursor
					- Ws_popup + Ws_border + Ws_sysmenu 
					+ Ws_minimizebox + Ws_maximizebox
		end

end -- class EV_WINDOW_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

