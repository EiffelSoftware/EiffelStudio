note
	description: "Eiffel Vision titled window. Cocoa implementation."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
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
			make,
			window_mask
		end

	EV_TITLED_WINDOW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make
		do
			internal_icon_name := ""
			create icon_pixmap
			Precursor {EV_WINDOW_IMP}
		end

	window_mask: NATURAL
		do
			Result := {NS_WINDOW}.closable_window_mask | {NS_WINDOW}.miniaturizable_window_mask | {NS_WINDOW}.resizable_window_mask
		end

feature -- Access

	icon_name: STRING_32
			-- Alternative name, displayed when window is minimised.
			-- FIXME: What is this? There is really no such thing on Mac OS!
		do
			Result := internal_icon_name.twin
		end

	icon_pixmap: EV_PIXMAP
			-- Window icon.
			-- FIXME: OS X windows generally do not have icons! (in the same sense as in windows...)

feature -- Status report

	is_minimized: BOOLEAN
			-- Is displayed iconified/minimised?
		do
			Result := is_miniaturized
		end

	is_maximized: BOOLEAN
			-- Is displayed at maximum size?

feature -- Status setting

	raise
			-- Request that window be displayed above all other windows.
		do
			--show
			 make_key_and_order_front (current)
		end

	lower
			-- Request that window be displayed below all other windows.
		do
			order_back
		end

	minimize
			-- Display iconified/minimised.
		do
			miniaturize
			is_maximized := False
		end

	maximize
			-- Display at maximum size.
		do
			if not is_zoomed then
				zoom
			end
			is_maximized := True
		end

	restore
			-- Restore to original position when minimized or maximized.
		do
			if is_zoomed then
				zoom
			end
			is_maximized := False
		end

feature -- Element change

	set_icon_name (a_icon_name: STRING_GENERAL)
			-- Assign `a_icon_name' to `icon_name'.
		do
			internal_icon_name := a_icon_name.twin
		end

	set_icon_pixmap (a_icon: EV_PIXMAP)
			-- Assign `a_icon' to `icon'.
		local
			l_pix_imp: detachable EV_PIXMAP_IMP
		do
			-- FIXME Mac Issue: This is problematic because on the Mac there is a application icon in the dock, but usually no window icon (there may be one for document windows... should probably go with that)
			icon_pixmap := a_icon
			l_pix_imp ?= a_icon.implementation
			check l_pix_imp /= Void end
			app_implementation.set_application_icon_image (l_pix_imp.image)
		end

feature {NONE} -- Implementation

	internal_icon_name: STRING_32
		-- Name given by the user. internal representation.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TITLED_WINDOW note option: stable attribute end;

end -- class EV_TITLED_WINDOW_IMP
