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

	EV_GTK_KEY_CONVERSION

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Connect interface.
		do
			base_make (an_interface)
			-- dummy c_object
			set_c_object (C.gtk_button_new)
			create key
		end

	initialize is
		do
			create actions_internal
			connect_signal_to_actions (
				"pressed",
				actions_internal,
				Void
			)
			is_initialized := True
		end

feature {NONE} -- Implementation

	interface: EV_ACCELERATOR

	accel_group: POINTER
			-- The shared accelerator group object.

	add_accel is
			-- Add the current key combination to the invisible button.
		do
			if accel_group /= NULL then
				C.gtk_widget_add_accelerator (
					c_object,
					eiffel_to_c ("pressed"),
					accel_group,
					key_code_to_gtk (key.code),
					modifier_mask,
					0)
			end
		end

	remove_accel is
			-- Remove the current key combination to the invisible button.
		do
			if accel_group /= NULL then
				C.gtk_widget_remove_accelerator (
					c_object,
					accel_group,
					key_code_to_gtk (key.code),
					modifier_mask)
			end
		end

	modifier_mask: INTEGER is
			-- The mask consisting of alt, shift and control keys.
		do
			if control_required then
				Result := C.GDK_CONTROL_MASK_ENUM
			end
			if alt_required then
				Result := Result + C.GDK_MOD1_MASK_ENUM
			end
			if shift_required then
				Result := Result + C.GDK_SHIFT_MASK_ENUM
			end
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	set_accel_group (a_grp: POINTER) is
		do
			remove_accel
			accel_group := a_grp
			add_accel
		end

feature -- Access

	key: EV_KEY
			-- Representation of the character that must be entered
			-- by the user. See class EV_KEY_CODE

	shift_required: BOOLEAN
			-- Must the shift key be pressed?

	alt_required: BOOLEAN
			-- Must the alt key be pressed?

	control_required: BOOLEAN
			-- Must the control key be pressed?

feature -- Element change

	set_key (a_key: EV_KEY) is
			-- Set `a_key' as new key that has to be pressed.
		do
			remove_accel
			key := a_key
			add_accel
		end

	enable_shift_required is
			-- "Shift" must be pressed for the key combination.
		do
			remove_accel
			shift_required := True
			add_accel
		end

	disable_shift_required is
			-- "Shift" is not part of the key combination.
		do
			remove_accel
			shift_required := False
			add_accel
		end

	enable_alt_required is
			-- "Alt" must be pressed for the key combination.
		do
			remove_accel
			alt_required := True
			add_accel
		end

	disable_alt_required is
			-- "Alt" is not part of the key combination.
		do
			remove_accel
			alt_required := False
			add_accel
		end

	enable_control_required is
			-- "Control" must be pressed for the key combination.
		do
			remove_accel
			control_required := True
			add_accel
		end

	disable_control_required is
			-- "Control" is not part of the key combination.
		do
			remove_accel
			control_required := False
			add_accel
		end

end -- class EV_ACCELERATOR_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2001/06/07 23:08:02  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.10.2.5  2000/09/08 16:54:32  king
--| Accounted for feature name changes
--|
--| Revision 1.10.2.4  2000/09/06 23:18:40  king
--| Reviewed
--|
--| Revision 1.10.2.3  2000/08/16 19:40:35  king
--| Fixed bug on default creation
--|
--| Revision 1.10.2.2  2000/05/24 00:48:28  king
--| Made enumeration calls uppercase
--|
--| Revision 1.10.2.1  2000/05/03 19:08:37  oconnor
--| mergred from HEAD
--|
--| Revision 1.10  2000/05/02 18:55:21  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.9  2000/04/20 18:07:38  oconnor
--| Removed default_translate where not needed in sognal connect calls.
--|
--| Revision 1.8  2000/04/04 21:01:07  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.7  2000/03/22 23:54:31  brendel
--| Removed feature `name'.
--|
--| Revision 1.6  2000/03/21 23:55:11  brendel
--| Fixed FIXME.
--|
--| Revision 1.5  2000/03/21 23:08:06  brendel
--| Changed to use new key design.
--|
--| Revision 1.4  2000/03/15 22:56:08  brendel
--| Changed key_code to key.
--|
--| Revision 1.3  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
