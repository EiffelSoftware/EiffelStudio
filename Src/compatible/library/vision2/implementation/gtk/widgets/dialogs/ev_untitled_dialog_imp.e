note
	description: "Eiffel Vision dialog. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG_IMP

inherit
	EV_DIALOG_IMP
		redefine
			interface,
			default_wm_decorations,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'
		do
			Precursor {EV_DIALOG_IMP}
			{EV_GTK_EXTERNALS}.gtk_window_set_skip_pager_hint (c_object, True)
			{EV_GTK_EXTERNALS}.gtk_window_set_skip_taskbar_hint (c_object, True)
		end

feature {NONE} -- Implementation

	default_wm_decorations: INTEGER
			-- Default Window Manager decorations of `Current'.
		do
			Result := 0
		end

	interface: EV_UNTITLED_DIALOG;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DIALOG_IMP

