indexing
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

	before_enable_capture is
			-- Redefine
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			l_app_imp ?= ev_application.implementation
			l_app_imp.set_capture_type ({EV_APPLICATION_IMP}.capture_normal)
		end

	after_disable_capture is
			-- Redefine
		local
			l_env: EV_ENVIRONMENT
			l_app_imp: EV_APPLICATION_IMP
		do
			l_app_imp ?= ev_application.implementation
			l_app_imp.set_capture_type ({EV_APPLICATION_IMP}.capture_heavy)
		end

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
end
