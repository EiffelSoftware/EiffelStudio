indexing

	description: 
		"EiffelVision implmentation of a Motif scrollbar."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	SCROLLBAR_IMP

inherit

	SCROLLBAR_I;

	PRIMITIVE_IMP
		rename
			is_shown as shown
		undefine
			create_callback_struct
		end;

	MEL_SCROLL_BAR
		rename
			make as mel_scroll_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			increment as line_increment,
			value as position,
			set_increment as set_line_increment,
			set_horizontal as mel_set_horizontal,
			set_vertical as mel_set_vertical,
			set_value as set_position,
			is_shown as shown
		end

create

	make

feature {NONE} -- Initialization

	make (a_scrollbar: SCROLLBAR; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif scrollbar.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_scroll_make (a_scrollbar.identifier, mc, man)
		end;

feature -- Status report

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		do
			if is_horizontal then
				Result := not is_maximum_on_left
			else
				Result := not is_maximum_on_top
			end
		end;

feature -- Status setting

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		do
			if flag then
				mel_set_horizontal
			else
				mel_set_vertical
			end
		end;

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise.
		do
			if flag then
				if is_horizontal then
					set_maximum_on_right
				else
					set_maximum_on_bottom
				end
			else
				if is_horizontal then
					set_maximum_on_left
				else
					set_maximum_on_top
				end
			end
		end;

feature -- Element change

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (drag_command);
			if list = Void then
				create list.make;
				set_drag_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end; 

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (value_changed_command);
			if list = Void then
				create list.make;
				set_value_changed_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

feature -- Removal

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		do
			remove_command (drag_command, a_command, argument)
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		do
			remove_command (value_changed_command, a_command, argument)
		end;

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




end -- class SCROLLBAR_IMP

