indexing
	description: "Menus with a windows implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	MENU_WINDOWS

inherit
	WEL_MENU
		rename
			item as wel_item,
			make as wel_make,
			main_args as menu_main_args,
			popup_menu as wel_submenu
		end;

	MANAGER_WINDOWS
		redefine
			realized
		end

feature -- Status report

	checked_widget (widget: TOGGLE_B_WINDOWS): BOOLEAN is
		do
			Result := widget.state
		end

	disabled: BOOLEAN is
			-- Is current menu disabled?
		do
		end

	realized: BOOLEAN
			-- Is current menu realized
	
feature -- Status setting

	check_widget (widget: TOGGLE_B_WINDOWS) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				check_item (id)
			end
		end

	uncheck_widget (widget: TOGGLE_B_WINDOWS) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				uncheck_item (id)
			end
		end

	enable_widget (widget: WIDGET_WINDOWS) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				enable_item (id)
			end
		end

	disable_widget (widget: WIDGET_WINDOWS) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				disable_item (id)
			end
		end

	put_children_in_menu (root: ROOT_MENU_WINDOWS) is
			-- Put all the menu children in the list
		local
			c: ARRAYED_LIST [WIDGET_WINDOWS]
		do
			!! id_children.make (5)
			c := children_list
			from
				c.finish
			until
				c.off
			loop
				put_child_in_menu (c.item, root)
				c.back
			end
		end

	put_child_in_menu (widget: WIDGET_WINDOWS; root: ROOT_MENU_WINDOWS) is
			-- Add `widget' to the menu
		require
			widget_exists: widget /= Void
		local
			button: BUTTON_WINDOWS
			toggle_b: TOGGLE_B_WINDOWS
			separator: SEPARATOR_WINDOWS
			pulldown: MENU_PULL_WINDOWS
			menu_b: MENU_BUTTON_WINDOWS
		do
			button ?= widget
			if button /= Void then
				menu_b ?= widget
				if menu_b = Void or menu_b.associated_menu = Void then
					root.add (button)
					append_string (button.text, root.value)
					button.set_hash_code
					id_children.put (root.value, button)
					toggle_b ?= widget
					if toggle_b /= Void then
						if toggle_b.state then
							check_item (root.value)
						else
							uncheck_item (root.value)
						end
					end
				end
			else
				separator ?= widget
				if separator /= Void then
					append_separator
				else
					pulldown ?= widget
					if pulldown /= Void then
						pulldown.create
						pulldown.put_children_in_menu (root)
						append_popup (pulldown, pulldown.menu_button.text)
					else
						io.error.putstring ("Unknown type in menu ")
						io.error.putstring (widget.generator)
						io.error.new_line
					end
				end
			end
		end

	realize_current is
		do
		end

	id_children: HASH_TABLE [INTEGER, WIDGET_WINDOWS]
			-- id in menu for a child

	id_of_child (w: WIDGET_WINDOWS): INTEGER is
			-- id of child `w'
		do
			if id_children /= Void then
				Result := id_children.item (w)
			end
		end

feature -- Inapplicable

	default_style: INTEGER is
		do
		end

	class_name: STRING is
		do
		end

	set_title (s: STRING) is
		do
			title := s
		end

	title: STRING

	remove_title is
		do
		end

	wel_hide, 
	wel_set_focus, 
	wel_destroy, 
	enable, 
	disable, 
	invalidate, 
	wel_release_capture, 
	wel_set_capture, 
	wel_show  is
		do
		end

	wel_set_text (s: STRING) is 
		do 
		end

	wel_set_menu (wel_menu: WEL_MENU) is
		do
		end

	wel_parent: WEL_COMPOSITE_WINDOW is 
		do 
		end

	client_rect: WEL_RECT is 
		do 
		end

	wel_shown, 
	enabled: BOOLEAN is 
		do 
		end

	wel_children: LINKED_LIST [WEL_WINDOW]

	wel_set_width, 
	wel_set_height, 
	wel_set_x, 
	wel_set_y (i:INTEGER) is 
		do 
		end

	absolute_x, 
	absolute_y, 
	wel_width, 
	wel_height, 
	wel_x, 
	wel_y: INTEGER is 
		do 
		end

	wel_text: STRING is 
		do 
		end

	set_z_order (flags: INTEGER) is
		do
		end

	resize, 
	wel_move (new_width, new_height: INTEGER) is
		do
		end

end -- class MENU_WINDOWS

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
