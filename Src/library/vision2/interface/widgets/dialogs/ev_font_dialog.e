indexing 
	description:
		"EiffelVision font selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG

inherit
	EV_STANDARD_DIALOG
		redefine
			implementation
		end

create
	default_create,
	make_with_title

feature -- Access
		
	font: EV_FONT is
			-- Font selected in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.font
		ensure
			Result_not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.font)
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			not_destroyed: not is_destroyed
			a_font_not_void: a_font /= Void
		do
			implementation.set_font (a_font)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_FONT_DIALOG_I
	
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_FONT_DIALOG_IMP} implementation.make (Current)
		end

end -- class EV_FONT_DIALOG

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

