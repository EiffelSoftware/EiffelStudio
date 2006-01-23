indexing 
	description: "EiffelVision color selection dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COLOR_DIALOG

inherit
	EV_STANDARD_DIALOG
		redefine
			implementation
		end

create
	default_create,
	make_with_title

feature -- Access

	color: EV_COLOR is
			-- Currently selected color or last color
			-- passed to `set_color' if user cancelled `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.color
		ensure
			Result_not_Void: Result /= Void
			bridge_ok: Result.is_equal (implementation.color)
		end

feature -- Element change

	set_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `color'.
		require
			not_destroyed: not is_destroyed
			a_color_not_void: a_color /= Void
		do
			implementation.set_color (a_color)
		end
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_COLOR_DIALOG_I

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_COLOR_DIALOG_IMP} implementation.make (Current)
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




end -- class EV_COLOR_DIALOG

