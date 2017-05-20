note
	description: "Windows implementation for SD_SYSTEM_SETTER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_SETTER_IMP

inherit
	SD_SYSTEM_SETTER

	EV_ANY_HANDLER

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature -- Command

	before_enable_capture
			-- <Precursor>
		do
			if attached {EV_APPLICATION_IMP} ev_application.implementation as l_app_imp then
				l_app_imp.set_capture_type ({EV_APPLICATION_IMP}.capture_normal)
			else
				check False end -- Implied by basic design of Vision2
			end
		end

	after_disable_capture
			-- <Precursor>
		do
			if attached {EV_APPLICATION_IMP} ev_application.implementation as l_app_imp then
				l_app_imp.set_capture_type ({EV_APPLICATION_IMP}.capture_heavy)
			else
				check False end -- Implied by basic design of Vision2
			end
		end

	is_remote_desktop: BOOLEAN
			-- <Precursor>
		do
			Result := (create {WEL_WINDOWS_ROUTINES}).is_terminal_service
		end

	is_during_pnd: BOOLEAN
			-- <Precursor>
		do
			if attached {EV_APPLICATION_IMP} ev_application.implementation as l_app_imp then
				Result := attached l_app_imp.pick_and_drop_source
			end
		end

	clear_background_for_theme (a_widget: EV_DRAWING_AREA; a_rect: EV_RECTANGLE)
			-- <Precursor>
		do
			a_widget.clear_rectangle (a_rect.x, a_rect.y, a_rect.width, a_rect.height)
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
