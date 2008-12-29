note
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

	make (an_interface: like interface)
			-- Connect interface.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_menu_item_new)
			create key
		end

	initialize
		do
			real_signal_connect (c_object, "activate", agent (App_implementation.gtk_marshal).accelerator_actions_internal_intermediary (c_object), Void)
			set_is_initialized (True)
		end

feature {NONE} -- Implementation

	interface: EV_ACCELERATOR

feature {EV_WINDOW_IMP} -- Implementation

	modifier_mask: INTEGER
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

	add_accel (a_window_imp: EV_WINDOW_IMP)
			-- Add the current key combination to the invisible button.
		require
			a_window_imp_not_void: a_window_imp /= Void
		local
			a_cs: EV_GTK_C_STRING
			l_accel_grp: POINTER
		do
			a_cs := "activate"
			l_accel_grp := a_window_imp.accel_group
			{EV_GTK_EXTERNALS}.gtk_widget_add_accelerator (
				c_object,
				a_cs.item,
				l_accel_grp,
				key_code_to_gtk (key.code),
				modifier_mask,
				0
			)
		end

	remove_accel (a_window_imp: EV_WINDOW_IMP)
			-- Remove the current key combination to the invisible button.
		require
			a_window_imp_not_void: a_window_imp /= Void
		local
			l_accel_grp: POINTER
		do
			l_accel_grp := a_window_imp.accel_group
			{EV_GTK_EXTERNALS}.gtk_widget_remove_accelerator (
				c_object,
				l_accel_grp,
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

	set_key (a_key: EV_KEY)
			-- Set `a_key' as new key that has to be pressed.
		do
			key := a_key.twin
		end

	enable_shift_required
			-- "Shift" must be pressed for the key combination.
		do
			shift_required := True
		end

	disable_shift_required
			-- "Shift" is not part of the key combination.
		do
			shift_required := False
		end

	enable_alt_required
			-- "Alt" must be pressed for the key combination.
		do
			alt_required := True
		end

	disable_alt_required
			-- "Alt" is not part of the key combination.
		do
			alt_required := False
		end

	enable_control_required
			-- "Control" must be pressed for the key combination.
		do
			control_required := True
		end

	disable_control_required
			-- "Control" is not part of the key combination.
		do
			control_required := False
		end

note
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

