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
			on_hide,
			on_show,
			on_size,
			on_move,
			on_left_button_up,
			on_right_button_up,
			on_left_button_down,
			on_right_button_down,
			on_key_up,
			on_key_down,
			on_set_cursor,
			on_mouse_move,
			on_destroy
		redefine
			on_cbn_killfocus,
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
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				wc ?= parent
				set_width (25)
				set_height (item_height)
				wel_make (wc, x, y, width, height, id_default)
				!! button_list.make (5)
				realize_children
				if private_selected_button /= Void
				and then private_selected_button.managed then
					set_selected_button (private_selected_button)
				end
			end
				-- set initial focus
			if initial_focus/= void then
				initial_focus.wel_set_focus
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

feature -- Element change

	manage_item (bw: WIDGET_WINDOWS) is
			-- Manage a item in the combobox.
		local
			b: BUTTON
		do
			b ?= bw.owner
			insert_string_at (b.text, button_index (b) - unmanaged_count (b) - 1)
			adjust_size (b)
		end

	unmanage_item (bw: WIDGET_WINDOWS) is
			-- Unmanage a item in the combobox.
		local
			b: BUTTON
		do
			b ?= bw.owner
			delete_string (button_index (b) - unmanaged_count (b))
			adjust_size (b)
		end

	add_a_child (button: BUTTON_WINDOWS) is
			-- Add a button to the option pull.
		require
			button_not_void: button /= Void
			button_realized: button.realized
			button_text_not_void: button.text /= Void
		local
			max_width: INTEGER
			screen_dc: WEL_SCREEN_DC
			s: STRING
			b: BUTTON
		do
			b ?= button.owner
			if b.managed then
				s := button.text
				if not fixed_size_flag then
					adjust_size (b)	
				end
				add_string (s)
			end
			button_list.extend (b)
		ensure
			count_increased: button.managed implies count = old count + 1
			list_count_increased: button_list.count = old button_list.count + 1
		end

feature -- Status report

	text: STRING
			-- Text of the option pull

	title: STRING
			-- Title of the option pull

	width: INTEGER is
			-- Width of the option pull
		do
			if exists then
				Result := wel_width - 25
			else
				Result := private_attributes.width
			end
		end

	height: INTEGER is
			-- Height of the option pull
		do
			if exists then
				Result := wel_height - number_of_buttons * item_height
			else
				Result := private_attributes.height
			end
		end

feature -- Removal

	remove_title is
			-- Remove the tile
		do
			title := Void
		end

feature -- Status setting

	adjust_size (b: BUTTON) is
			-- Adjust the width and height on
			-- managing and unmanaging, no shrinking is allowed.
		local
			screen_dc: WEL_SCREEN_DC
			max_width: INTEGER
			s: STRING
		do
			!! screen_dc
			screen_dc.get
			s := b.text
			max_width := screen_dc.string_width (s).max (width)
			screen_dc.release
			set_size (max_width, item_height)
		end

	set_caption (a_caption: STRING) is
		do
			caption := clone (a_caption)
		end

	set_selected_button (b: BUTTON) is
			-- Select the entry in the menu
			-- corresponding the button
		do
			private_selected_button := b
			if exists and then b.managed then
				select_item (button_index (b) - unmanaged_count (b) - 1)
			end
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set widget size to `new_width', `new_height'
		do
			private_attributes.set_width (new_width)
			private_attributes.set_height (new_height)
			if exists then
				resize (new_width + 25, new_height + (number_of_buttons + 1) * item_height)
			end
			if parent /= Void then
				parent.child_has_resized
			end
		end

	set_text (s: STRING) is
			-- Set text for option pull.
		do
			text := clone (s)
		end

	set_title (t: STRING) is
			-- Set title for option pull.
		do
			title := t
		end

feature {NONE} -- Implementation

	unmanaged_count (b: BUTTON): INTEGER is
			-- Number of unmanaged buttons in the list before `b'.
			-- Including `b' itself
		do
			button_list.search (b)
			if not button_list.exhausted then
				from
					button_list.start
				until
					button_list.before
				loop
					if not button_list.item.managed then
						Result := Result + 1
					end
					button_list.back
				end
			end
		end

	button_index (b: BUTTON): INTEGER is
			-- The index of the button `b' in the `button_list'.
		require
			has_button: button_list.has (b)
		do
			button_list.start
			button_list.search (b)
			Result := button_list.index
		end

	on_cbn_killfocus is
			-- Hide the list when the focus is removed.
		do
			if list_shown then
				hide_list
			end
		end

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
			if not button_list.empty then
				Result := button_list.count - unmanaged_count (button_list.last)
			end
		end

	private_selected_button: BUTTON 
			-- Button selected before realization

end -- class OPTION_PULL_WINDOWS

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

