indexing
	description: "This class represents a MS_WINDOWS push button"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	PUSH_BUTTON_WINDOWS

inherit
	BUTTON_WINDOWS
		rename
			set_managed as widget_set_managed
		redefine
			realize,
			realized,
			unrealize
		end;

	BUTTON_WINDOWS
		redefine
			realize,
			realized,
			unrealize,
			set_managed
		select
			set_managed
		end

	PUSH_B_I

	WEL_PUSH_BUTTON
		rename
			make as wel_make,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
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
			on_hide,
			on_show,
			on_size,
			on_move,
			on_right_button_up, on_left_button_down,
			on_left_button_up, on_right_button_down,
			on_mouse_move, on_destroy, on_set_cursor,
			on_bn_clicked, on_key_up,
			on_key_down
		end

creation
	make

feature {NONE} -- Initialization

	make (a_button: PUSH_B; man: BOOLEAN; oui_parent: COMPOSITE) is
		do
			!! private_attributes
			parent ?= oui_parent.implementation;
			private_text := clone (a_button.identifier);
			a_button.set_font_imp (Current);
			managed := man;
			set_default_size
			set_center_alignment
		end

feature -- Access

	realized: BOOLEAN
			-- Is this widget realized?

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		local
			mp: MENU_PULL_WINDOWS
			op: OPTION_PULL_WINDOWS
		do
			if in_menu then
				if realized then
					if parent /= Void and parent.realized and then parent.exists then
						if not managed and then flag then
							managed := flag
							if is_parent_menu_pull then
								mp ?= parent
								mp.manage_item (Current)
							elseif is_parent_option_pull then
								managed := flag
								op ?= parent
								op.manage_item (Current)
							end
						elseif managed and then not flag then
							if is_parent_menu_pull then
								managed := flag
								mp ?= parent
								mp.unmanage_item (Current)
							elseif is_parent_option_pull then
								managed := flag
								op ?= parent
								op.unmanage_item (Current)
							end
						end
					end
					managed := flag
				else
					managed := flag
					realize
				end
				managed := flag
			else
				widget_set_managed (flag)
			end
		end

feature -- Status setting

	unrealize is
			-- Unrealize the button.
		do
			if exists then
				wel_destroy
			end
			realized := False
		end

	realize is
			-- Display a push_button
		local
			menu: MENU_WINDOWS
			wc: WEL_COMPOSITE_WINDOW
			mp: MENU_PULL_WINDOWS
			op: OPTION_PULL_WINDOWS
		do
			if not realized then
				realized := true
				if is_parent_menu_pull then
					mp ?= parent
					if mp.realized then
						mp.add_a_child (Current)
					end
				elseif is_parent_option_pull then
					op ?= parent
					if op.realized then
						op.add_a_child (Current)
					end
				else
					resize_for_shell
					wc ?= parent
					wel_make (wc, text, x, y, width, height, id_default);
					if private_font /= Void then
						set_font (private_font)
					end
					if not fixed_size_flag then
						set_default_size
					end
					if private_attributes.insensitive then
						set_insensitive (true)
					end
				end
			end
		end

	on_bn_clicked is
		local
			cd: BUTCLICK_DATA
		do
			!! cd.make (owner, 0, 0, 0, 0, id, buttons_state);
			activate_actions.execute (Current, cd)
		end

end -- class PUSH_BUTTON_WINDOWS

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
