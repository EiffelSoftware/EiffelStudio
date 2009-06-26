note
	description: "EiffelVision popup window, Cocoa implementation"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_WINDOW_IMP

inherit
	EV_POPUP_WINDOW_I
		undefine
			propagate_background_color,
			propagate_foreground_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_WINDOW_IMP
		redefine
			interface,
			make
		end

create
	make,
	initialize_with_shadow

feature -- Implementation

	make
		do
			Precursor
			disable_border
			disable_user_resize
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_POPUP_WINDOW note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_POPUP_WINDOW_IMP
