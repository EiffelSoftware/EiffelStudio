indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG_IMP_MODAL

inherit
	EV_DIALOG_IMP_MODAL
		undefine
			extra_minimum_height,
			promote_to_dialog_window,
			update_style,
			has_title_bar
		redefine
			interface,
			other_imp,
			common_dialog_imp
		end

	EV_UNTITLED_DIALOG_IMP_COMMON
		undefine
			hide, is_modal, setup_dialog
		redefine
			interface,
			other_imp,
			common_dialog_imp
		end

create
	make_with_dialog_window

feature {EV_DIALOG_I} -- Implementation

	other_imp: EV_UNTITLED_DIALOG_IMP
			-- Previous Implementation if any, Void otherwise.
			
feature {NONE} -- Implementation

	common_dialog_imp: EV_DIALOG_IMP_MODAL is
			-- Dialog implementation type common to all descendents.
		do
		end
			
feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_UNTITLED_DIALOG
			-- Interface for `Current'.

end -- class EV_DIALOG_IMP_MODAL

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

