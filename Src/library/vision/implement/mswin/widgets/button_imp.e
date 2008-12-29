note
	description: "This class represents a MS_IMPbutton"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	text: STRING
			-- Text of the button
		do
			if exists then
				Result := wel_text
			else
				Result := private_text
			end
		end;

feature -- Status report

	realized: BOOLEAN
			-- Is the button realized?
		do
			Result := exists
		end

	in_menu: BOOLEAN
			-- Is current button in a menu?
		do
			Result := is_parent_option_pull or
				is_parent_menu_pull
		end

feature -- Status setting

	set_center_alignment
			-- Set text alignment to center
		do
			if alignment_type /= center_alignment_type then
				alignment_type := center_alignment_type;
			end
		end

	set_left_alignment
			-- Set text alignment to left
		do
			if alignment_type /= left_alignment_type then
				alignment_type := left_alignment_type;
			end
		end

	set_right_alignment
			-- Set text alignment to right
		do
			if alignment_type /= right_alignment_type then
				alignment_type := right_alignment_type;
			end
		end

	alignment_type: INTEGER
			-- Type of alignment

	Center_alignment_type: INTEGER = 0
			-- Centered alignment type

	Left_alignment_type: INTEGER = 1
			-- Left alignment type

	Right_alignment_type: INTEGER = 2
			-- Right alignment type

	set_default_size
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

	set_text (t: STRING)
			-- Set window text to t.
		do
			if t /= Void then
				private_text := t.twin
			else
				private_text := Void
			end
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

	add_activate_action (a_command: COMMAND; argument: ANY)
			-- Add a_command to the list of action to execute when
			-- current push button is activated.
		do
			activate_actions.add (Current, a_command, argument)
		end

	add_arm_action (a_command: COMMAND; arg: ANY)
			-- Add a_command to the list of action to execute when
			-- current push button is armed.
		do
			arm_actions.add (Current, a_command, arg)
		end

	add_release_action (a_command: COMMAND; arg: ANY)
			-- Add a_command to the list of action to execute when
			-- current push button is released.
		do
			release_actions.add (Current, a_command, arg)
		end

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY)
			-- Remove a_command from the list of action to execute when
			-- current push button is activated.
		do
			activate_actions.remove (Current, a_command, argument)
		end

	remove_arm_action (a_command: COMMAND; arg: ANY)
			-- Remove a_command from the list of action to execute when
			-- current push button is armed.
		do
			arm_actions.remove (Current, a_command, arg)
		end

	remove_release_action (a_command: COMMAND; arg: ANY)
			-- Remove a_command from the list of action to execute when
			-- current push button is released.
		do
			release_actions.remove (Current, a_command, arg)
		end

feature -- Implementation

	private_text: STRING
			-- Private text

	extra_width: INTEGER
			-- Extra width
		once
			Result := 10
		end

	is_parent_menu_pull: BOOLEAN
			-- Is my parent a menu pull?
		local
			mp: MENU_PULL_IMP
		do
			mp ?= parent;
			Result := mp /= Void
		end

	is_parent_option_pull: BOOLEAN
			-- Is my parent a option pull?
		local
			op: OPT_PULL_I
		do
			op ?= parent;
			Result := op /= Void
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




end -- class BUTTON_IMP

