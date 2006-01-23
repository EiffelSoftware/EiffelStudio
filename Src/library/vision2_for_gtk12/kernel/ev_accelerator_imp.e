indexing
	description: "EiffelVision accelerator. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_IMP

inherit
	EV_ACCELERATOR_I
		export
			{EV_INTERMEDIARY_ROUTINES} actions_internal
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
			set_c_object ({EV_GTK_EXTERNALS}.gtk_menu_item_new)
			create key
		end

	initialize is
		do
			real_signal_connect (c_object, "activate", agent (App_implementation.gtk_marshal).accelerator_actions_internal_intermediary (c_object), Void)
			set_is_initialized (True)
		end

feature {NONE} -- Implementation

	interface: EV_ACCELERATOR

	modifier_mask: INTEGER is
			-- The mask consisting of alt, shift and control keys.
		do
			if control_required then
				Result := {EV_GTK_EXTERNALS}.gDK_CONTROL_MASK_ENUM
			end
			if alt_required then
				Result := Result.bit_or ({EV_GTK_EXTERNALS}.gDK_MOD1_MASK_ENUM)
			end
			if shift_required then
				Result := Result.bit_or ({EV_GTK_EXTERNALS}.gDK_SHIFT_MASK_ENUM)
			end
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	add_accel (a_accel_grp: POINTER) is
			-- Add the current key combination to the invisible button.
		require
			a_accel_grp_not_null: a_accel_grp /= NULL
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := "activate"
			{EV_GTK_EXTERNALS}.gtk_widget_add_accelerator (
				c_object,
				a_cs.item,
				a_accel_grp,
				key_code_to_gtk (key.code),
				modifier_mask,
				0
			)
		end

	remove_accel (a_accel_grp: POINTER) is
			-- Remove the current key combination to the invisible button.
		require
			a_accel_grp_not_null: a_accel_grp /= NULL
		do
			{EV_GTK_EXTERNALS}.gtk_widget_remove_accelerator (
				c_object,
				a_accel_grp,
				key_code_to_gtk (key.code),
				modifier_mask
			)
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
			key := a_key.twin
		end

	enable_shift_required is
			-- "Shift" must be pressed for the key combination.
		do
			shift_required := True
		end

	disable_shift_required is
			-- "Shift" is not part of the key combination.
		do
			shift_required := False
		end

	enable_alt_required is
			-- "Alt" must be pressed for the key combination.
		do
			alt_required := True
		end

	disable_alt_required is
			-- "Alt" is not part of the key combination.
		do
			alt_required := False
		end

	enable_control_required is
			-- "Control" must be pressed for the key combination.
		do
			control_required := True
		end

	disable_control_required is
			-- "Control" is not part of the key combination.
		do
			control_required := False
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




end -- class EV_ACCELERATOR_IMP

