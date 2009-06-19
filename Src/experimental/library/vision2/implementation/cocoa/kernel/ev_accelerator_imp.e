note
	description: "EiffelVision accelerator. Cocoa implementation."
	author:	"Daniel Furrer"

class
	EV_ACCELERATOR_IMP

inherit
	EV_ACCELERATOR_I

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create the window.
		do
			assign_interface (an_interface)
		end

	make
			-- Setup `Current'
		do
			set_is_initialized (True)
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	modifier_mask: INTEGER
			-- The mask consisting of alt, shift and control keys.
		do
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	add_accel (a_window_imp: EV_TITLED_WINDOW_IMP)
			-- Add the current key combination
		require
			a_window_imp_not_void: a_window_imp /= Void
		do
		end

	remove_accel (a_window_imp: EV_TITLED_WINDOW_IMP)
			-- Remove the current key combination
		require
			a_window_imp_not_void: a_window_imp /= Void
		do
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

feature {NONE} -- Implementation

	destroy
			-- Free resources of `Current'
		do
		end

end -- class EV_ACCELERATOR_IMP
