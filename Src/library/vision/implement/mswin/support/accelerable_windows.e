indexing
	description: "Abstraction of accelerable widget."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ACCELERABLE_WINDOWS

inherit
	ACCELERATOR_MANAGER_WINDOWS

	WEL_ACCELERATOR_FLAG_CONSTANTS
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

feature {MENU_IMP} -- Status setting

	new_accelerator_id (new_id: INTEGER) is
			-- Set a new id for the accelerator.
		do
			accelerator.set_command_id (new_id)
			accelerators.add (accelerator)
		end

feature -- Status setting

	set_accelerator_action (translation: STRING) is
			-- Set the accelerator action (modifiers and key to use
			-- as a shortcut in selecting a button) to `a_translation'.
			-- `a_translation' must be specified with the X toolkit
			-- conventions.
		require
			translation_not_void: translation /= Void
			translatiom_not_empty: not translation.is_empty
		local
			a_translation: STRING
			i: INTEGER
			flags: INTEGER
			key: INTEGER
			key_string: STRING
			virt_key: BOOLEAN
		do
			if accelerator /= Void then
				accelerators.remove (accelerator)
			end
			a_translation := clone (translation)
			a_translation.to_lower
			if a_translation.substring_index ("shift", 1) /= 0 then
				flags := set_flag (flags, Fshift)
				virt_key := True
			end
			if a_translation.substring_index ("alt", 1) /= 0 then
				flags := set_flag (flags, Falt)
				virt_key := True
			end
			if a_translation.substring_index ("ctrl", 1) /= 0 then
				flags := set_flag (flags, Fcontrol)
				virt_key := True
			end
			from
				key_string := ""
				i := a_translation.count
			until
				i = 0 or else not a_translation.item (i).is_alpha or a_translation.item (i).is_digit

			loop
				key_string.prepend_character (a_translation.item (i))
				i := i - 1
			end
			if key_string /= "" then
				from
					key_string.to_upper
					i := 0
				until
					key /= 0 or else i > 255
				loop
					if virtual_keys.item (i).is_equal (key_string) then
						key := i
					end
					i := i + 1
				end
				if i < 256 then
					if key_string.count > 1 or virt_key then
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
		ensure
			accelerator_void: accelerator = Void
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

