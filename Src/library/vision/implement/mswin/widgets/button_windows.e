indexing
	description: "This class represents a MS_WINDOWS button"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BUTTON_WINDOWS

inherit
	PRIMITIVE_WINDOWS
		export
			{ACTION_WINDOWS, MENU_WINDOWS} set_hash_code
		redefine
			realized
		end

	SIZEABLE_WINDOWS

feature -- Access

	text: STRING is
			-- Text of the button
		do
			if exists then
				Result := wel_text
			else
				Result := private_text
			end
		end;

feature -- Status report

	realized: BOOLEAN is
			-- Is the button realized?
		do
			Result := exists
		end

	in_menu: BOOLEAN
			-- Is current button in a menu?

feature -- Status setting 

	set_center_alignment is
			-- Set text alignment to center
		do
			if alignment_type /= center_alignment_type then
				alignment_type := center_alignment_type;
			end
		end

	set_left_alignment is
			-- Set text alignment to left
		do
			if alignment_type /= left_alignment_type then
				alignment_type := left_alignment_type;
			end
		end

	set_right_alignment is
			-- Set text alignment to right
		do
			if alignment_type /= right_alignment_type then
				alignment_type := right_alignment_type;
			end
		end

	alignment_type: INTEGER
			-- Type of alignment

	Center_alignment_type: INTEGER is 0
			-- Centered alignment type

	Left_alignment_type: INTEGER is 1
			-- Left alignment type

	Right_alignment_type: INTEGER is 2
			-- Right alignment type

	set_default_size is
			-- Resize to a default size.
			-- Does nothing by default.
		local
			fw: FONT_WINDOWS
		do
			fw ?= font.implementation
			check
				font_not_void: fw /= Void
			end
			if exists then
				set_size (fw.string_width (Current, text) + extra_width,
					(7 * fw.string_height (Current, text)) // 4)
			else
				set_form_width (fw.string_width (Current, text) + extra_width)
				set_form_height ((7 * fw.string_height (Current, text)) // 4)
			end
		end

	set_text (t: STRING) is
			-- Set window text to t.
		local
			ext_text: ANY
		do
			if exists then
				wel_set_text (t)
			end
			private_text := clone (t)
			if not fixed_size_flag then
				set_default_size
			end
		end

feature -- Element change 

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add a_command to the list of action to execute when
			-- current push button is activated.
		do
			activate_actions.add (Current, a_command, argument)
		end

	add_arm_action (command: COMMAND; arg: ANY) is
			-- Add a_command to the list of action to execute when
			-- current push button is armed.
		do
			arm_actions.add (Current, command, arg)
		end

	add_release_action (command: COMMAND; arg: ANY) is
			-- Add a_command to the list of action to execute when
			-- current push button is released.
		do
			release_actions.add (Current, command, arg)
		end

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove a_command from the list of action to execute when
			-- current push button is activated.
		do
			activate_actions.remove (Current, a_command, argument)
		end

	remove_arm_action (command: COMMAND; arg: ANY) is
			-- Remove a_command from the list of action to execute when
			-- current push button is armed.
		do
			arm_actions.remove (Current, command, arg)
		end

	remove_release_action (command: COMMAND; arg: ANY) is
			-- Remove a_command from the list of action to execute when
			-- current push button is released.
		do
			release_actions.remove (Current, command, arg)
		end

feature -- Behavior

	on_activate is
			-- Perform activate action.
 		do
			activate_actions.execute (Current, Void)
		end

feature -- Implementation

	private_text: STRING
			-- Private text

	extra_width: INTEGER is
			-- Extra width
		once
			Result := 10
		end

	is_parent_menu_pull: BOOLEAN is
			-- Is my parent a menu pull?
		local
			mp: MENU_PULL_WINDOWS
		do
			mp ?= parent;
			Result := mp /= Void
		end

	is_parent_option_pull: BOOLEAN is
			-- Is my parent a option pull?
		local
			op: OPT_PULL_I
		do
			op ?= parent;
			Result := op /= Void
		end

end -- class BUTTON_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
