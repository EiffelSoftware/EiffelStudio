indexing
	description: "Button style (BS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BS_CONSTANTS

feature -- Access

	Bs_pushbutton: INTEGER is 0

	Bs_defpushbutton: INTEGER is 1

	Bs_checkbox: INTEGER is 2

	Bs_autocheckbox: INTEGER is 3

	Bs_radiobutton: INTEGER is 4

	Bs_3state: INTEGER is 5

	Bs_auto3state: INTEGER is 6

	Bs_groupbox: INTEGER is 7

	Bs_userbutton: INTEGER is 8

	Bs_autoradiobutton: INTEGER is 9

	Bs_ownerdraw: INTEGER is 11

	Bs_lefttext: INTEGER is 32

	Bs_text: INTEGER is 0

	Bs_icon: INTEGER is 64

	Bs_bitmap: INTEGER is 128

	Bs_left: INTEGER is 256

	Bs_right: INTEGER is 512

	Bs_center: INTEGER is 768

	Bs_top: INTEGER is 1024

	Bs_bottom: INTEGER is 2048

	Bs_vcenter: INTEGER is 3072

	Bs_pushlike: INTEGER is 4096

	Bs_multiline: INTEGER is 8192

	Bs_notify: INTEGER is 16384

	Bs_flat: INTEGER is 32768

	Bs_rightbutton: INTEGER is 32
			-- Same as `Bs_lefttext'.

end -- class WEL_BS_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

