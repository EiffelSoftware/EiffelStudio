indexing
	description:
		" EiffelVision accelerator. Describes a special key%
		% event that launch one or severals commands. For the%
		% key codes, see class EV_KEY_CODE."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR

creation
	make

feature -- Initialization

	make (code: INTEGER; shift, alt, control: BOOLEAN) is
			-- Create an accelerator object where `keycode' is a
			-- representation of the key that must be pressed, `shift',
			-- `alt' and `control' precise if these keys must be pressed
			-- too.
		do
			keycode := code
			shift_key := shift
			alt_key := alt
			control_key := control
		end

feature -- Access

	keycode: INTEGER
			-- Representation of the character that must be entered
			-- by the user, see class EV_KEY_CODE

	shift_key: BOOLEAN
			-- Must the shift key be pressed?

	alt_key: BOOLEAN
			-- Must the alt key be pressed?

	control_key: BOOLEAN
			-- Must the control key be pressed?

feature -- Status report

	frozen id: INTEGER is
			-- Returns an id that describes the accelerator.
			-- It is a binary number of 8 bits with the
			-- following informations :
			-- 1 -> 8 : key code number
			-- 9      : shift key
			-- 10     : alt key
			-- 11     : control key
		do
			Result := keycode
			if shift_key then
				Result := Result + 512
			end
			if alt_key then
				Result := Result + 1024
			end
			if control_key then
				Result := Result + 2048
			end
		end

end -- class EV_ACCELERATOR

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------
