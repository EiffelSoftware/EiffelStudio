indexing
	description: "This class represents a MS_IMPbutton"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BUTTON_IMP

inherit
	PRIMITIVE_IMP
		export
			{ACTION_IMP, MENU_IMP} set_hash_code
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

	in_menu: BOOLEAN is
			-- Is current button in a menu?
		do
			Result := is_parent_option_pull or
				is_parent_menu_pull
		end

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
		local
			fw: FONT_IMP
		do
			fw ?= font.implementation
			check
				font_not_void: fw /= Void
			end
			if exists then
				set_size (fw.string_width (Current, text) + extra_width,
					(7 * fw.string_height (Current, text)) // 4 - 2)
			else
				set_form_width (fw.string_width (Current, text) + extra_width)
				set_form_height ((7 * fw.string_height (Current, text)) // 4 - 2)
			end
		end

	set_text (t: STRING) is
			-- Set window text to t.
		do
			private_text := clone (t)
			if exists then
				wel_set_text (t)
			elseif realized and then in_menu and then managed then
				set_managed (False)
				set_managed (True)
			end
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

	add_arm_action (a_command: COMMAND; arg: ANY) is
			-- Add a_command to the list of action to execute when
			-- current push button is armed.
		do
			arm_actions.add (Current, a_command, arg)
		end

	add_release_action (a_command: COMMAND; arg: ANY) is
			-- Add a_command to the list of action to execute when
			-- current push button is released.
		do
			release_actions.add (Current, a_command, arg)
		end

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove a_command from the list of action to execute when
			-- current push button is activated.
		do
			activate_actions.remove (Current, a_command, argument)
		end

	remove_arm_action (a_command: COMMAND; arg: ANY) is
			-- Remove a_command from the list of action to execute when
			-- current push button is armed.
		do
			arm_actions.remove (Current, a_command, arg)
		end

	remove_release_action (a_command: COMMAND; arg: ANY) is
			-- Remove a_command from the list of action to execute when
			-- current push button is released.
		do
			release_actions.remove (Current, a_command, arg)
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
			mp: MENU_PULL_IMP
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

end -- class BUTTON_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

