note
	description:
		"Eiffel Vision titled window. Carbon implementation."
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
			interface,
--			make,
			default_wm_decorations,
			is_displayed,
			initialize,
			initialize_client_area
		end

	EV_TITLED_WINDOW_ACTION_SEQUENCES_IMP
	MACWINDOWS_FUNCTIONS_EXTERNAL

create
	make

feature {NONE} -- Initialization

--	make (an_interface: like interface) is
--			-- Create the titled window.
--		do
--
--		end

	initialize
			--
		do
			Precursor {EV_WINDOW_IMP}
		end

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

	is_displayed: BOOLEAN
			-- Is 'Current' displayed on screen?
		do
		end

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
		local
			ret: INTEGER
		do
			ret:=collapse_window_external(c_object,1)
		end


	maximize
			-- Display at maximum size.
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{	
					WindowRef aWindow;
					aWindow = GetWindowList();
					Point p;
					ZoomWindowIdeal(aWindow, inZoomOut, &p); // does not work yet
				}
			]"
		end

	restore
			-- Restore to original position when minimized or maximized.
		local
			ret: INTEGER
		do
			ret:=collapse_window_external(c_object,0)
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

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_TITLED_WINDOW_IMP

