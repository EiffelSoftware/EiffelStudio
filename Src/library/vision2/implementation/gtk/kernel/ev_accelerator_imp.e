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
		local
			temp_string: ANY
		do
			if accel_group /= NULL then
				temp_string := ("pressed").to_c
				C.gtk_widget_add_accelerator (
					c_object,
					$temp_string,
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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

