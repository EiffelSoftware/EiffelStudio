note
	description: "Summary description for {SD_FEEDBACK_INDICATOR_I}."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_FEEDBACK_INDICATOR_I

inherit
	EV_POPUP_WINDOW_I
		redefine
			interface
		end

feature {SD_FEEDBACK_INDICATOR} -- Initialization

	init_common (a_pixel_buffer: EV_PIXEL_BUFFER; a_parent_window: WEL_WINDOW)
			-- Initlize common parts
		require
			not_void: a_pixel_buffer /= Void
			not_void: a_parent_window /= Void
		deferred
		end

feature -- Command

	show
			-- Show current with fading effect if possible
		deferred
		end

	clear
			-- Disappear with fading effect
		require
			exists: exists
		deferred
		end

	set_position (a_screen_x, a_screen_y: INTEGER)
			-- Set position
		deferred
		end

	set_pixel_buffer (a_pixel_buffer: like pixel_buffer)
			-- Set `pixel_buffer'
		deferred
		ensure
			set: pixel_buffer = a_pixel_buffer
		end

feature -- Query

	exists: BOOLEAN
			-- Does the OS native pointer exist?
		deferred
		end

	pixel_buffer: detachable EV_PIXEL_BUFFER
			-- Pixmap to show.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable SD_FEEDBACK_INDICATOR note option: stable attribute end
			-- <Precursor>

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
