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

	EV_GTK_KEY_CONVERSION

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Connect interface.
		do
			base_make (an_interface)
			create key
		end

	initialize is
			-- Setup `Current'
		do
			set_is_initialized (True)
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	modifier_mask: INTEGER is
			-- The mask consisting of alt, shift and control keys.
		do
			if control_required then
				Result := {EV_GTK_EXTERNALS}.gDK_CONTROL_MASK_ENUM
			end
			if alt_required then
				Result := Result.bit_or ( {EV_GTK_EXTERNALS}.gDK_MOD1_MASK_ENUM)
			end
			if shift_required then
				Result := Result.bit_or ({EV_GTK_EXTERNALS}.gDK_SHIFT_MASK_ENUM)
			end
		end		

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	add_accel (a_window_imp: EV_TITLED_WINDOW_IMP) is
			-- Add the current key combination
		require
			a_window_imp_not_void: a_window_imp /= Void
		local
			a_cs: EV_GTK_C_STRING
			a_keymap_array: POINTER
			n_keys: INTEGER
			a_success: BOOLEAN
		do
			a_cs := "activate"
			
			internal_gdk_key_code := key_code_to_gtk (key.code)
			if shift_required and then not key.is_function and then not key.is_arrow then
					-- We need to get the key val for the uppercase symbol
				a_success := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_keymap_get_entries_for_keyval (default_pointer, internal_gdk_key_code, $a_keymap_array, $n_keys)
				{EV_GTK_DEPENDENT_EXTERNALS}.set_gdk_keymapkey_struct_level (a_keymap_array, 1)
				internal_gdk_key_code := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_keymap_lookup_key (default_pointer, a_keymap_array)
				{EV_GTK_EXTERNALS}.g_free (a_keymap_array)
			end
			
			if internal_gdk_key_code > 0 then
					-- If internal_gdk_key_code is 0 then the key mapping doesn't exist so we do nothing
				{EV_GTK_EXTERNALS}.gtk_widget_add_accelerator (
					a_window_imp.accel_box,
					a_cs.item,
					a_window_imp.accel_group,
					internal_gdk_key_code,
					modifier_mask,
					0
				)				
			end
		end

	remove_accel (a_window_imp: EV_TITLED_WINDOW_IMP) is
			-- Remove the current key combination
		require
			a_window_imp_not_void: a_window_imp /= Void
		do
			{EV_GTK_EXTERNALS}.gtk_widget_remove_accelerator (
				a_window_imp.accel_box,
				a_window_imp.accel_group,
				internal_gdk_key_code,
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

feature {NONE} -- Implementation

	internal_gdk_key_code: NATURAL_32
		-- Internal gdk key code used to represent key of `Current'

	interface: EV_ACCELERATOR
		-- Interface object of `Current'

feature {NONE} -- Implementation

	destroy is
			-- Free resources of `Current'
		do
			key := Void
			set_is_destroyed (True)
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

