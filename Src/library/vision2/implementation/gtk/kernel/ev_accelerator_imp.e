--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision accelerator. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_IMP

inherit
	EV_ACCELERATOR_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Connect interface.
		do
			base_make (an_interface)
			set_c_object (C.gtk_button_new)
		end

	initialize is
		do
			connect_signal_to_actions ("pressed", interface.actions)
			is_initialized := True
		end

feature {NONE} -- Implementation

	interface: EV_ACCELERATOR

	accel_group: POINTER
			-- The shared accelerator group object.

	add_accel is
			-- Add the current key combination to the invisible button.
		do
			if accel_group /= Default_pointer then
				C.gtk_widget_add_accelerator (
					c_object,
					eiffel_to_c ("pressed"),
					accel_group,
					key_code,
					modifier_mask,
					0)
			end
		end

	remove_accel is
			-- Remove the current key combination to the invisible button.
		do
			if accel_group /= Default_pointer then
				C.gtk_widget_remove_accelerator (
					c_object,
					accel_group,
					key_code,
					modifier_mask)
			end
		end

	modifier_mask: INTEGER is
			-- The mask consisting of alt, shift and control keys.
		do
			if control_key then
				Result := Result + C.Gdk_control_mask_enum
			end
			if alt_key then
				Result := Result + C.Gdk_mod1_mask_enum
			end
			if shift_key then
				Result := Result + C.Gdk_shift_mask_enum
			end
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	set_accel_group (a_grp: POINTER) is
		do
			remove_accel
			accel_group := a_grp
			add_accel
		end

	name: STRING is
			-- Get the GTK string representation.
		do
			create Result.make (0)
			Result.from_c (C.gtk_accelerator_name (key_code, modifier_mask))
		end

feature -- Access

	key_code: INTEGER
			-- Representation of the character that must be entered
			-- by the user. See class EV_KEY_CODE

	shift_key: BOOLEAN
			-- Must the shift key be pressed?

	alt_key: BOOLEAN
			-- Must the alt key be pressed?

	control_key: BOOLEAN
			-- Must the control key be pressed?

feature -- Element change

	set_key_code (a_key_code: INTEGER) is
			-- Set `a_key_code' as new key that has to be pressed.
		do
			remove_accel
			key_code := a_key_code
			add_accel
		end

	enable_shift_key is
			-- "Shift" must be pressed for the key combination.
		do
			remove_accel
			shift_key := True
			add_accel
		end

	disable_shift_key is
			-- "Shift" is not part of the key combination.
		do
			remove_accel
			shift_key := False
			add_accel
		end

	enable_alt_key is
			-- "Alt" must be pressed for the key combination.
		do
			remove_accel
			alt_key := True
			add_accel
		end

	disable_alt_key is
			-- "Alt" is not part of the key combination.
		do
			remove_accel
			alt_key := False
			add_accel
		end

	enable_control_key is
			-- "Control" must be pressed for the key combination.
		do
			remove_accel
			control_key := True
			add_accel
		end

	disable_control_key is
			-- "Control" is not part of the key combination.
		do
			remove_accel
			control_key := False
			add_accel
		end

end -- class EV_ACCELERATOR_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:08  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/02/04 04:20:42  oconnor
--| released
--|
--| Revision 1.1.2.4  2000/01/27 19:29:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.3  2000/01/25 16:58:13  brendel
--| Implemented Alt-key in modifier_mask.
--|
--| Revision 1.1.2.2  2000/01/25 03:15:59  brendel
--| Implemented.
--|
--| Revision 1.1.2.1  2000/01/24 23:15:03  brendel
--| Accelerators are now platform dependent.
--| Features are not yet implemented.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
