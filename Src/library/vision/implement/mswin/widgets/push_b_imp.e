indexing
	description: "This class represents a MS_IMPpush button"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	PUSH_B_IMP

inherit

	ACCELERABLE_WINDOWS

	BUTTON_IMP
		redefine
			realize,
			realized,
			unrealize,
			set_managed,
			set_insensitive,
			insensitive,
			destroy
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
			set_font as wel_set_font,
			foreground_color as wel_foreground_color,
			background_color as wel_background_color
		undefine
			on_hide,
			on_show,
			on_size,
			on_move,
			on_right_button_up, on_left_button_down,
			on_left_button_up, on_right_button_down,
			on_mouse_move, on_destroy, on_set_cursor,
			on_bn_clicked, on_key_up,
			on_key_down,
			background_brush
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

	realize is
			-- Realize a push_button
		local
			wc: WEL_COMPOSITE_WINDOW
			mp: MENU_PULL_IMP
			op: OPT_PULL_IMP
		do
			if not realized then
				if in_menu and not managed then
					set_managed (True)
					realized := True
				else
					realized := True
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
		end

feature -- Access

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		local
			mp: MENU_PULL_IMP
			op: OPT_PULL_IMP
		do
			if in_menu then
				if realized then
					if parent /= Void and parent.realized then
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
				Precursor {BUTTON_IMP} (flag)
			end
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if `flag'. This means
			-- that any events with an event type of KeyPress,
			-- KeyRelease, ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or FocusOut will
			-- not be dispatched to current widget and to all its children.
			-- Set it to sensitive mode otherwise.
		local
			mp: MENU_PULL_IMP
		do
			private_attributes.set_insensitive (flag)
			if in_menu then
				mp ?= parent
				mp.set_insensitive_widget (Current, flag)
			else
				if exists then
					if flag then
						disable
					else
						enable
					end
				end
			end
		end

	unrealize is
			-- Unrealize the button.
		do
			if exists then
				wel_destroy
			end
			if has_accelerator then
				accelerators.remove (accelerator)
			end
			if in_menu and then managed then
				set_managed (False)
			end
			realized := False
		end

feature -- Status report

	realized: BOOLEAN
			-- Is this widget realized?

	insensitive: BOOLEAN is
			-- Is Current insensitive?
		do
			if in_menu then
				Result := private_attributes.insensitive
			else
				if exists then
					Result := not enabled
				else
					Result := private_attributes.insensitive
				end
			end
		end

feature -- Removal

	destroy (wid_list: LINKED_LIST [WIDGET]) is
			-- Destroy Current.
		local
			ww: WIDGET_IMP
		do
			if
				in_menu and then
				managed
			then
				set_managed (False)
			end
			if exists then
				wel_destroy
			end
			from
				wid_list.start
			until
				wid_list.after
			loop
				ww ?= wid_list.item.implementation
				actions_manager_list.deregister (ww)
				wid_list.forth
			end
		end
	
feature {NONE} -- Notification

	on_bn_clicked is
			-- Button pressed.
		do
			activate_actions.execute (Current, Void)
		end

end -- class PUSH_B_IMP


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

