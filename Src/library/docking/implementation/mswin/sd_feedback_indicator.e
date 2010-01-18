note
	description: "Objecs that use layered windows to feedback display indicators"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FEEDBACK_INDICATOR

inherit
	EV_POPUP_WINDOW
		redefine
			show,
			set_position,
			implementation,
			create_implementation
		end

	EV_ANY_HANDLER
		undefine
			default_create,
			copy
		end

create
	make,
	make_for_splash

feature {NONE} -- Initlization

	make (a_pixel_buffer: like pixel_buffer; a_parent_window: EV_WINDOW)
			-- Creation method.
		require
			not_void: a_pixel_buffer /= Void
		local
			l_composite_window: WEL_COMPOSITE_WINDOW
		do
			default_create
			l_composite_window ?= a_parent_window.implementation
			check not_void: l_composite_window /= Void end

			implementation.init_common (a_pixel_buffer, l_composite_window)
		ensure
			set: pixel_buffer = a_pixel_buffer
		end

	make_for_splash (a_pixel_buffer: like pixel_buffer)
			-- Creation method for splash screen.
		require
			not_void: a_pixel_buffer /= Void
		local
			l_env: EV_ENVIRONMENT
			l_app_imp: EV_APPLICATION_IMP
		do
			create l_env
			l_app_imp ?= l_env.application.implementation
			check not_void: l_app_imp /= Void end

			implementation.init_common (a_pixel_buffer, l_app_imp.silly_main_window)
		end

feature -- Command

	show
			-- Show current with fading effect if possible
		do
			implementation.show
		end

	set_pixel_buffer (a_pixel_buffer: like pixel_buffer)
			-- Set `pixel_buffer'
		do
			implementation.set_pixel_buffer (a_pixel_buffer)
		ensure
			set: pixel_buffer = a_pixel_buffer
		end

	set_position (a_screen_x, a_screen_y: INTEGER)
			-- Set position
		do
			implementation.set_position (a_screen_x, a_screen_y)
		end

	clear
			-- Disappear with fading effect.
		require
			exists: exists
		do
			implementation.clear
		end

feature -- Query

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixmap to show
		do
			Result := implementation.pixel_buffer
		end

	exists: BOOLEAN
			-- Does the OS native pointer exist?
		do
			Result := implementation.exists
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: SD_FEEDBACK_INDICATOR_I
			-- <Precursor>

feature {NONE} -- Implementation

	create_implementation
			-- <Precursor>
		do
			create {SD_FEEDBACK_INDICATOR_IMP} implementation.make (Current)
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
