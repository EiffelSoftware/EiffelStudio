note
	description: "Objects that do something speciall on different operation systems"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_SYSTEM_SETTER


feature -- Command

	before_enable_capture
			-- Do something before enable capture
		deferred
		end

	after_disable_capture
			-- Do something after disable capture
		deferred
		end

	is_remote_desktop: BOOLEAN
			-- If current running in remote desktop?
		deferred
		end

	is_during_pnd: BOOLEAN
			-- If mouse is in Pick and Drop mode now?
		deferred
		end

	clear_background_for_theme (a_widget: EV_DRAWING_AREA; a_rect: EV_RECTANGLE)
			-- Clear background
			-- This feature will set background to theme background color/pixmap
		require
			a_widget_not_void: a_widget /= Void
			a_rect_not_void: a_rect /= Void
		deferred
		end

note
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
