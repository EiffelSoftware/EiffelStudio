indexing 
	description: "EiffelVision color selection dialog."
	status: "See notice at end of class"
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
	default_create

feature -- Access

	color: EV_COLOR is
			-- Currently selected color.
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
		
feature {EV_ANY_I} -- Implementation

	implementation: EV_COLOR_DIALOG_I

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_COLOR_DIALOG_IMP} implementation.make (Current)
		end

end -- class EV_COLOR_DIALOG

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------
