indexing
	description: "This class represents a MS_WINDOWS toggle button"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	TOGGLE_B_WINDOWS

inherit
	BUTTON_WINDOWS
		redefine
			realize,
			x, 
			y,
			set_x,
			set_y,
			extra_width,
			unrealize
		end

	TOGGLE_B_I

	WEL_CHECK_BOX
		rename
			make as wel_make,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			width as wel_width,
			height as wel_height,
			shown as wel_shown,
			parent as wel_parent,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			move as wel_move,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture,
			release_capture as wel_release_capture,
			item as wel_item,
			font as wel_font,
			set_font as wel_set_font
		undefine
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_destroy,
			on_set_cursor,
			on_size,
			on_move,
			on_hide,
			on_show,
			on_key_up,
			on_key_down
		redefine
			default_style,
			on_bn_clicked
		end

creation 
	make

feature  

	make (a_toggle_b: TOGGLE_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Creation 
		local
			a_box: BOX_WINDOWS;
		do
			!! private_attributes
			parent ?= oui_parent.implementation;
			a_box ?= parent
			if a_box /= Void then
				a_box.add_toggle (Current)
			end
			a_toggle_b.set_font_imp (Current);
			set_text (a_toggle_b.identifier);
			managed := man
		end

	realize is
			-- Display a toggle button
		local
			wc: WEL_COMPOSITE_WINDOW
			mp: MENU_PULL_WINDOWS
		do
			if not exists then
				if in_menu then
					mp ?= parent
					if mp /= Void and then mp.realized then
						mp.add_a_child (Current)
					end
				else	
					wc ?= parent
					wel_make (wc, text, x , y , width + 20, height, id_default);
					if private_font /= Void then
						set_font (private_font)
					end
					set_default_size;
					if width = 0 then
						set_default_size
					end
				end
				if private_state then
					set_toggle_on
				else
					set_toggle_off
				end
			end
		end

	unrealize is
			-- Unrealize widget and notify parent if necessary
		local
			a_box: BOX_WINDOWS
		do
			if exists then
				wel_destroy
			end
			if in_a_box then
				a_box ?= parent
				check
					a_box_not_void: a_box /= Void
				end
				a_box.remove_toggle (Current)
			end
		end	

feature -- Status report 

	state: BOOLEAN is
			-- True if the toggle has been armed. False otherwise.
		do
			if exists then
				Result := checked
			else
				Result := private_state
			end
		end;

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			if exists then
				Result := wel_x
			else
				Result := private_attributes.x
			end
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		do
			if exists then
				Result := wel_y
			else
				Result := private_attributes.y
			end
		end;

feature -- Status setting

	set_x (a_x: INTEGER) is
		do
			if exists then
				wel_set_x (a_x)
			end
			private_attributes.set_x (a_x)
		end

	set_y (a_y: INTEGER) is
		do
			if exists then
				wel_set_y (a_y)
			end
			private_attributes.set_y (a_y)
		end

	arm is
			-- Set a toggle armed
		do
			if not state then
				set_toggle_on
				toggle_value_changed_actions.execute (Current, Void)
			end
		end

	disarm is
			-- Set a toggle disarmed
		do
			if state then
				set_toggle_off
				toggle_value_changed_actions.execute (Current, Void)
			end
		end

	set_toggle_on is
			-- Set current toggle button on.
		local
			menu_parent: MENU_WINDOWS
			radio_box: RADIO_BOX_WINDOWS
		do
			private_state := True;
			if in_menu then
				if parent.exists then
					menu_parent ?= parent
					menu_parent.check_widget (Current)
				end
			else
				if exists then
					radio_box ?= parent
					if radio_box /= Void then
						radio_box.set_index_on_checked_toggle (Current)
					end
					set_checked
				end
			end
		end

	set_toggle_off is
			-- Set current toggle button off.
		local
			menu_parent: MENU_WINDOWS
		do
			private_state := False;
			if in_menu then
				if parent.exists then
					menu_parent ?= parent
					menu_parent.uncheck_widget (Current)
				end
			else
				if exists then
					set_unchecked
				end
			end
		end

feature -- Element change  

	add_value_changed_action (a_command: COMMAND; arg: ANY) is
			-- Add a command to the list of action to execute
			-- when value is changed
		do
			toggle_value_changed_actions.add (Current, a_command, arg)
		end

feature -- Removal

	remove_value_changed_action (a_command: COMMAND; arg: ANY) is
			-- Remove a command from the list of action to execute
			-- when value is changed
		do
			toggle_value_changed_actions.remove (Current, a_command, arg)
		end

feature {BOX_WINDOWS} -- Implementation

	set_realized is
			-- To avoid a second realization
		do
		end

feature {BOX_WINDOWS} -- Status report

	toggle_height: INTEGER is
			-- The height of the toggle_b if in
			-- a radio box or a check box.
		local
			font_windows: FONT_WINDOWS
		do
			font_windows ?= font.implementation
			Result := 7 * (font_windows.string_height (Current, text).max (Minimum_height)) // 4
		ensure
			result_greater_than_minimum: Result >= 7 * Minimum_height // 4
		end

	toggle_width: INTEGER is
			-- Width of the toggle including the width
			-- of the text
		local
			font_windows: FONT_WINDOWS
		do
			font_windows ?= font.implementation
			Result := font_windows.string_width (Current, text) + 25
		end

feature {BOX_WINDOWS} -- Status setting

	resize_for_toggle is
			-- Resize to fit in a check box or in a radio box.
		do
			resize (toggle_width, toggle_height)
		end

feature {NONE} -- Implementation

	private_state: BOOLEAN;

	on_bn_clicked is
			-- Called when the button is clicked.
		local
			a_parent: RADIO_BOX_WINDOWS
		do
			a_parent ?= parent
			if a_parent = Void then
				release_actions.execute (Current, Void)
			else
				a_parent.set_index_on_checked_toggle (Current)
			end
			toggle_value_changed_actions.execute (Current, Void)
		end

	in_a_box: BOOLEAN is
			-- Is current object in a radio box or a check box?
		local
			box: BOX_WINDOWS
		do
			box ?= parent
			Result := box /= Void
		end

	Extra_width: INTEGER is
			-- Extra width
		once
			Result := 25
		end

	Minimum_height: INTEGER is 15
			-- Minimum height of a toggle button in a check box
			-- or a radio box.

	default_style: INTEGER is
			-- Default style for creation
		local
			a_radio: RADIO_BOX_WINDOWS
			a_check: CHECK_BOX_WINDOWS
		do
			a_radio ?= parent;
			a_check ?= parent;
			if a_radio /= Void then
				Result := Ws_child + Ws_visible + Bs_autoradiobutton
			else
				Result := Ws_child + Ws_visible + Bs_autocheckbox
			end
		end

end -- class TOGGLE_B_WINDOWS

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

