indexing
    status: "See notice at end of class";
    date: "$Date$";
    revision: "$Revision$"

class
	OPTION_PULL_WINDOWS

inherit
	OPT_PULL_I

	SIZEABLE_WINDOWS

	MANAGER_WINDOWS
		redefine
			realize,
			set_size,
			width,
			height
		end

	WEL_DROP_DOWN_LIST_COMBO_BOX
		rename
			x as wel_x,
			y as wel_y,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			width as wel_width,
			height as wel_height,
			show as wel_show,
			hide as wel_hide,
			shown as wel_shown,
			destroy as wel_destroy,
			parent as wel_parent,
			set_font as wel_set_font,
			font as wel_font,
			set_text as wel_set_text,
			text as wel_text,
			make as wel_make,
			move as wel_move,
			set_capture as wel_set_capture,
			release_capture as wel_release_capture,
			set_focus as wel_set_focus,
			text_length as wel_text_length,
			item as wel_item,
			selected_item as wel_selected_item
		undefine
			on_left_button_up,
			on_right_button_up ,
			on_left_button_down,
			on_right_button_down,
			on_key_up,
			on_key_down,
			on_set_cursor,
			on_mouse_move,
			on_destroy
		redefine
			exists
		end

creation
	make

feature -- Initialization

	make (a_pulldown: OPT_PULL; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create an option pull
		local
			opt_b_windows: OPTION_BUTTON_WINDOWS
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			managed := man
			!! option_button.make ("dummy", oui_parent)
			opt_b_windows ?= option_button.implementation
			opt_b_windows.set_option_pull (Current)
		end

	realize_current, realize is
			-- Display a  option pull
		local
			s: STRING
			l: ARRAYED_LIST [WIDGET]
			wc: WEL_COMPOSITE_WINDOW
			b: BUTTON
			c: COMPOSITE
			h, max_width: INTEGER
			screen_dc: WEL_SCREEN_DC
		do
			if not realized then
				wc ?= parent
				!! button_list.make (5)
				c ?= owner
				l := c.children
				from
					l.start
				until
					l.after
				loop
					if l.item.managed then
						b ?= l.item
						button_list.extend (b)
					end
					l.forth
				end
				max_width := width
				wel_make (wc, x, y, width, height, id_default)
				from
					button_list.finish
					!! screen_dc
					screen_dc.get
				until
					button_list.before
				loop
					button_list.item.realize
					s := button_list.item.text
					max_width := screen_dc.string_width (s).max (max_width)
					add_string (s)
					button_list.back
				end
				if not fixed_size_flag then
					set_size (max_width, item_height)
				end
				screen_dc.release
				if private_selected_button /= Void then
					set_selected_button (private_selected_button)
				end
			end
		end

feature -- Access

	caption : STRING

	selected_button: BUTTON is
			-- Selected button
		do
			if exists and then selected then
				Result := button_list.i_th (number_of_buttons - wel_selected_item)
			else
				Result := private_selected_button
			end
		end

	text: STRING

	title: STRING

	width: INTEGER is
		do
			if exists then
				Result := wel_height - 25
			else
				Result := private_attributes.width
			end
		end

	height: INTEGER is
		do
			if exists then
				Result := wel_height - number_of_buttons * item_height
			else
				Result := private_attributes.height
			end
		end

feature -- Status setting

	remove_title is
		do
			title := Void
		end

	set_caption (a_caption: STRING) is
		do
			caption := clone (a_caption)
		end

	set_selected_button (a_button: BUTTON) is
		do
			private_selected_button := a_button
			if exists then
				from
					button_list.start
				until
					button_list.after
				loop
					if button_list.item = a_button then
						select_item (number_of_buttons - button_list.index)
					end
					button_list.forth
				end
			end
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set widget size to `new_width', `new_height'
		do
			private_attributes.set_width (new_width)
			private_attributes.set_height (new_height)
			if exists then
				resize (new_width + 25, new_height + number_of_buttons * item_height)
			end
			if parent /= Void then
				parent.child_has_resized
			end
		end
			
	set_text (s: STRING) is
		do
			text := clone (s)
		end

	set_title (t: STRING) is
		do
			title := t
		end

feature {NONE} -- Implementation

	button_list: ARRAYED_LIST [BUTTON]

	set_default_size is
		do
		end


	private_text: STRING

	exists: BOOLEAN

	wel_set_menu (a_menu: WEL_MENU) is
		do
		end
	
	wel_children: LINKED_LIST [WEL_WINDOW]

	item_height: INTEGER is
		local
			screen_dc: WEL_SCREEN_DC
		once
			!! screen_dc
			screen_dc.get
			Result := screen_dc.string_height ("I")
			screen_dc.release
		end

	number_of_buttons: INTEGER is
			-- Number of buttons in option pull
		do
			Result := button_list.count
		end

	private_selected_button: BUTTON 
			-- Button selected before realization

end -- class OPTION_PULL_WINDOWS

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
