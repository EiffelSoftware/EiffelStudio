indexing
	description:
		"Eiffel Vision titled window. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TITLED_WINDOW_IMP

inherit
	EV_TITLED_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_WINDOW_IMP
		redefine
			interface
		end

	EV_TITLED_WINDOW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	initialize_client_area
			-- Setup client area of window
		do
		end

feature {NONE} -- Implementation

	call_window_state_event (a_window_state: INTEGER)
			-- Call either minimize, maximize or restore actions for window
		do
		end

	call_accelerators (a_v2_key_value, accel_mods: INTEGER)
			-- Call the accelerator matching v2 key `a_v2_key_value' with a control mask of `accel_mods'
		do
		end

feature -- Access

	icon_name: STRING_32
			-- Alternative name, displayed when window is minimised.
		do
		end

	icon_pixmap: EV_PIXMAP
			-- Window icon.

	icon_mask: EV_PIXMAP
			-- Transparency mask for `icon_pixmap'.

feature -- Status report

	is_minimized: BOOLEAN
			-- Is displayed iconified/minimised?

	is_maximized: BOOLEAN
			-- Is displayed at maximum size?

feature -- Status setting

	raise
			-- Request that window be displayed above all other windows.
		do
		end

	lower
			-- Request that window be displayed below all other windows.
		do
		end

	minimize
			-- Display iconified/minimised.
		do
		end


	maximize
			-- Display at maximum size.
		do
		end

	restore
			-- Restore to original position when minimized or maximized.
		do
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING_GENERAL)
			-- Assign `an_icon_name' to `icon_name'.
		do
		end

	set_icon_pixmap (an_icon: EV_PIXMAP)
			-- Assign `an_icon' to `icon'.
		do
			icon_pixmap := an_icon
		end

feature {NONE} -- Implementation

	default_wm_decorations: INTEGER
			-- Default WM decorations of `Current'.?
		do
		end

feature {EV_MENU_BAR_IMP, EV_ACCELERATOR_IMP} -- Implementation

feature {EV_ANY_I} -- Implementation

	icon_name_holder: STRING_32
			-- Name holder for applications icon name

	interface: EV_TITLED_WINDOW;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TITLED_WINDOW_IMP

