indexing
	description: "Eiffel Vision dialog. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHADOW_DIALOG_IMP

inherit
	EV_WINDOW_IMP
		redefine
			show
		end

create
	make

feature {NONE} -- Implementation

	show is
			--Redefine
		do
			Precursor {EV_WINDOW_IMP}
			{EV_GTK_EXTERNALS}.gtk_window_set_skip_taskbar_hint (c_object, True)
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
