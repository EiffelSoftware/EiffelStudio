deferred class
	ACCELERABLE_WINDOWS

inherit
	WEL_ACCELERATOR_FLAGS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	VIRTUAL_KEYS_WINDOWS
		export
			{NONE} all
		end

feature -- Status setting

	set_accelerator_action (a_translation: STRING) is
			-- Set the accerlator action (modifiers and key to use as a shortcut
			-- in selecting a button) to `a_translation'.
			-- `a_translation' must be specified with the X toolkit conventions.
		require
			accelerator_void: accelerator = Void
		local
			translation: TRANSLATION_COMMAND
			flags: INTEGER
			key: INTEGER
		do
			if accelerator /= Void then
				accelerators.remove (accelerator)
				accelerator := Void
			end
			!! translation.make (a_translation, Void, Void)
			if translation.shift_required then
				flags := set_flag (flags, Fshift)
			end
			if translation.alt_required then
				flags := set_flag (flags, Falt)
			end
			if translation.ctrl_required then
				flags := set_flag (flags, Fcontrol)
			end
			
			if translation.key_string.count = 1 then
				key := (translation.key_string @ 1).code
			else
				io.error.putstring ("Key string is not one character...virtual key?")
				-- Add Fvirtkey to flags
			end
			!! accelerator.make (key, 0, flags)
				-- We have no id for the callback yet...
				-- We have to wait for the realize.
			accelerators.add (accelerator)
		ensure
			accelerator_not_void: accelerator /= Void
		end

feature -- Removal

	remove_accelerator_action is
			-- Remove the accelerator action.
		do
			if accelerator /= Void then
				accelerators.remove (accelerator)
				accelerator := Void
			end
		end

feature -- Status Report

	has_accelerator: BOOLEAN is
			-- Is there an accelerator key associated with
			-- this widget?
		do
			Result := accelerator /= Void
		end

	accelerator: WEL_ACCELERATOR
			-- Accelerator associated with menu entry
			-- if the widget is in a menu.

feature {NONE} -- Implementation

	accelerators: ACCELERATORS_WINDOWS is
			-- Accelerators in system.
		deferred
		end

end -- class ACCELERABLE_WINDOWS
