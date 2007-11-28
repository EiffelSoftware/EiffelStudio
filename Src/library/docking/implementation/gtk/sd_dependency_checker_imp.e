indexing
	description: "GTK implementation for SD_DEPENDENCY_CHECKER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DEPENDENCY_CHECKER_IMP

inherit
	SD_DEPENDENCY_CHECKER

	EV_ANY_HANDLER

feature -- Command

	check_dependency (a_parent_window: EV_WINDOW) is
			-- Redefine
		do
		end

	is_solaris_cde: BOOLEAN is
			-- Redefine
		local
			l_evn: EV_ENVIRONMENT
			l_imp: EV_APPLICATION_IMP
		do
			create l_evn
			l_imp ?= l_evn.application.implementation
			check not_void: l_imp /= Void end
			-- For Solaris CDE, window manager name is `unknown',  it should be `Dtwin' although.
			-- For Solaris JDS (Gnome), window manager name is `Metacity'
			-- For Ubuntu Gnome, window manager name is `Metacity'
			-- For Ubuntu KDE, window manager name is `KWin'
			Result := l_imp.window_manager_name.is_equal ("unknown")
		end

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
