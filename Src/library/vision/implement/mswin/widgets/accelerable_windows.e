indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ACCELERABLE_WINDOWS

inherit

	ACCELERATOR_MANAGER_WINDOWS

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

	new_accelerator_id (new_id: INTEGER) is
			-- Set a new id for the accelerator.
		do
			accelerator.set_command_id (new_id)
			accelerators.add (accelerator)
		end

	set_accelerator_action (translation: STRING) is
			-- Set the accerlator action (modifiers and key to use as a shortcut
			-- in selecting a button) to `a_translation'.
			-- `a_translation' must be specified with the X toolkit conventions.
		require
			translation_not_void: translation /= Void
			translatiom_not_empty: not translation.empty
		local
			a_translation: STRING
			i: INTEGER
			flags: INTEGER
			key: INTEGER
			key_string: STRING
		do
			if accelerator /= Void then
				accelerators.remove (accelerator)
			end
			a_translation := clone (translation)
			a_translation.to_lower
			if a_translation.substring_index ("shift", 1) /= 0 then
				flags := set_flag (flags, Fshift)
			end
			if a_translation.substring_index ("alt", 1) /= 0 then
				flags := set_flag (flags, Falt)
			end
			if a_translation.substring_index ("ctrl", 1) /= 0 then
				flags := set_flag (flags, Fcontrol)
			end
			from
				key_string := ""
				i := a_translation.count
			until
				i = 0 or else not
				((a_translation @ i).is_alpha or
				(a_translation @ i).is_digit)
				
			loop
				key_string.prepend_character (a_translation @ i)
				i := i - 1
			end
			if key_string /= "" then
				from
					key_string.to_upper
					i := 0
				until
					key /= 0 or else i > 255
				loop
					if (virtual_keys @ i).is_equal (key_string) then
						key := i
					end
					i := i + 1
				end
				if i < 256 then
					if key_string.count > 1 then
						flags := set_flag (flags, Fvirtkey)
					end
					!! accelerator.make (key, 0, flags)
				end
			end
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

end -- class ACCELERABLE_WINDOWS
